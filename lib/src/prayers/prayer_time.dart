// ignore_for_file: depend_on_referenced_packages

import 'package:prayers_times/src/calculation/celestial_time_calculation.dart';
import 'package:prayers_times/src/calculation/prayer_calculation_parameters.dart';
import 'package:prayers_times/src/celestial/celestial_math.dart';
import 'package:prayers_times/src/celestial/stellar_moment.dart';
import 'package:prayers_times/src/prayers/prayer_time_converter.dart';
import 'package:prayers_times/src/prayers/prayer_types.dart';
import 'package:prayers_times/src/utils/constant.dart';
import 'package:prayers_times/src/utils/coordinates.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// The `PrayerTimes` class calculates prayer times based on provided coordinates, date, and calculation parameters.
///
/// This class uses the CelestialMath and StellarMoment classes for calculations.
///
/// The calculations are based on established CelestialMath algorithms and formulas.
/// Please refer to authoritative sources for detailed explanations and references for the calculations.
class PrayerTimes {
  /// The geographic coordinates (latitude and longitude) of the location for which prayer times are calculated.
  late Coordinates coordinates;

  /// The date for which the prayer times are being calculated.
  late DateTime date;

  /// The calculation parameters used to determine the prayer times.
  late PrayerCalculationParameters calculationParameters;

  /// The time for the Fajr (pre-dawn) prayer's start and end.
  DateTime? fajrStartTime;
  DateTime? fajrEndTime;

  /// The time for the Sehri (pre-dawn meal) corresponding to Fajr.
  DateTime? sehri;

  /// The time for the Sunrise prayer.
  DateTime? sunrise;

  /// The time for the Dhuhr (noon) prayer's start and end.
  DateTime? dhuhrStartTime;
  DateTime? dhuhrEndTime;

  /// The time for the Asr (afternoon) prayer's start and end.
  DateTime? asrStartTime;
  DateTime? asrEndTime;

  /// The time for the Maghrib (evening) prayer's start and end.
  DateTime? maghribStartTime;
  DateTime? maghribEndTime;

  /// The time for the Isha (night) prayer's start and end.
  DateTime? ishaStartTime;
  DateTime? ishaEndTime;
  DateTime? tahajjudEndTime;

  /// The name of the location for which the prayer times are being calculated.
  final String locationName;

  /// Constructs a `PrayerTimes` object and calculates Islamic prayer times based on the provided parameters.
  ///
  /// The calculated prayer times are based on the provided coordinates, date, and calculation parameters.
  ///
  /// @param coordinates The geographic coordinates (latitude and longitude) of the location.
  /// @param calculationParameters The calculation parameters used for determining prayer times.
  /// @param precision Specifies whether to round the calculated times to the nearest minute (default: false).
  /// @param locationName The name of the location for which prayer times are being calculated.
  /// @param dateTime The specific date and time for which to calculate prayer times (default: current date and time).
  PrayerTimes(
      {required this.coordinates,
      required this.calculationParameters,
      bool precision = false,
      required this.locationName,
      DateTime? dateTime}) {
    tz.initializeTimeZones();
    final location = tz.getLocation(locationName);
    DateTime date = tz.TZDateTime.from(dateTime ?? DateTime.now(), location);
    this.date = date;

    // Calculate StellarMoment objects for the current date and adjacent days
    DateTime dateBefore = date.subtract(const Duration(days: 1));
    DateTime dateAfter = date.add(const Duration(days: 1));
    StellarMoment solarTime = StellarMoment(date, coordinates);
    StellarMoment solarTimeBefore = StellarMoment(dateBefore, coordinates);
    StellarMoment solarTimeAfter = StellarMoment(dateAfter, coordinates);

    // Calculate various time components using StellarMoment calculations
    DateTime fajrTime;
    DateTime asrTime;
    DateTime maghribTime;
    DateTime ishaTime;
    DateTime ishabeforeTime;
    DateTime fajrafterTime;
    double? nightFraction;
    DateTime dhuhrTime = PrayerTimeConverter(solarTime.transit)
        .utcDate(date.year, date.month, date.day);
    DateTime sunriseTime = PrayerTimeConverter(solarTime.sunrise)
        .utcDate(date.year, date.month, date.day);
    DateTime sunsetTime = PrayerTimeConverter(solarTime.sunset)
        .utcDate(date.year, date.month, date.day);
    DateTime sunriseafterTime = PrayerTimeConverter(solarTimeAfter.sunrise)
        .utcDate(dateAfter.year, dateAfter.month, dateAfter.day);
    DateTime sunsetbeforeTime = PrayerTimeConverter(solarTimeBefore.sunset)
        .utcDate(dateBefore.year, dateBefore.month, dateBefore.day);

    // Calculate Asr time based on shadow length and madhab
    asrTime = PrayerTimeConverter(solarTime.afternoon(
            PrayerTimeCalculator.shadowLength(calculationParameters.madhab)))
        .utcDate(date.year, date.month, date.day);

    DateTime tomorrow = CelestialTimeUtils.dateByAddingDays(date, 1);
    var tomorrowStellarMoment = StellarMoment(tomorrow, coordinates);
    DateTime tomorrowSunrise =
        PrayerTimeConverter(tomorrowStellarMoment.sunrise)
            .utcDate(tomorrow.year, tomorrow.month, tomorrow.day);
    int night = (tomorrowSunrise.difference(sunsetTime)).inSeconds;

    // Calculate Fajr times
    fajrTime = PrayerTimeConverter(
            solarTime.hourAngle(-1 * calculationParameters.fajrAngle, false))
        .utcDate(date.year, date.month, date.day);
    fajrafterTime = PrayerTimeConverter(solarTimeAfter.hourAngle(
            -1 * calculationParameters.fajrAngle, false))
        .utcDate(dateAfter.year, dateAfter.month, dateAfter.day);

    // Special case for moonsighting committee above latitude 55
    if (calculationParameters.method == "MoonsightingCommittee" &&
        coordinates.latitude >= 55) {
      nightFraction = night / 7;
      fajrTime = CelestialTimeUtils.dateByAddingSeconds(
          sunriseTime, -nightFraction.round());
      fajrafterTime = CelestialTimeUtils.dateByAddingSeconds(
          sunriseafterTime, -nightFraction.round());
    }

    // Calculate safe Fajr time adjustments
    DateTime safeFajr() {
      if (calculationParameters.method == "MoonsightingCommittee") {
        return CelestialMath.seasonAdjustedMorningTwilight(coordinates.latitude,
            CelestialTimeUtils.dayOfYear(date), date.year, sunriseTime);
      } else {
        var portion = calculationParameters.nightPortions()["fajr"];
        nightFraction = (portion ?? 1) * night;
        return CelestialTimeUtils.dateByAddingSeconds(
            sunriseTime, -nightFraction!.round());
      }
    }

    // // Calculate safe Fajr time adjustments after sunrise
    // DateTime safeFajrAfter() {
    //   if (calculationParameters.method == "MoonsightingCommittee") {
    //     return CelestialMath.seasonAdjustedMorningTwilight(coordinates.latitude, CelestialTimeUtils.dayOfYear(date), date.year, sunriseTime);
    //   } else {
    //     var portion = calculationParameters.nightPortions()["fajr"];
    //     nightFraction = (portion ?? 1) * night;
    //     return CelestialTimeUtils.dateByAddingSeconds(sunriseTime, -nightFraction!.round());
    //   }
    // }

    //Apply safe Fajr time adjustments
    if (safeFajr().isAfter(fajrTime)) {
      fajrTime = safeFajr();
    }

    if (safeFajr().isAfter(fajrafterTime)) {
      fajrafterTime = safeFajr();
    }

    // Calculate Isha times based on interval and angle
    if (calculationParameters.ishaInterval != null &&
        calculationParameters.ishaInterval! > 0) {
      ishaTime = CelestialTimeUtils.dateByAddingMinutes(
          sunsetTime, calculationParameters.ishaInterval ?? 0);
      ishabeforeTime = CelestialTimeUtils.dateByAddingMinutes(
          sunsetbeforeTime, calculationParameters.ishaInterval ?? 0);
    } else {
      ishaTime = PrayerTimeConverter(
              solarTime.hourAngle(-1 * calculationParameters.ishaAngle, true))
          .utcDate(date.year, date.month, date.day);
      ishabeforeTime = PrayerTimeConverter(solarTimeBefore.hourAngle(
              -1 * calculationParameters.ishaAngle, true))
          .utcDate(dateBefore.year, dateBefore.month, dateBefore.day);

      // Special case for moonsighting committee above latitude 55
      if (calculationParameters.method == "MoonsightingCommittee" &&
          coordinates.latitude >= 55) {
        nightFraction = night / 7;
        ishaTime = CelestialTimeUtils.dateByAddingSeconds(
            sunsetTime, nightFraction!.round());
        ishabeforeTime = CelestialTimeUtils.dateByAddingSeconds(
            sunsetbeforeTime, nightFraction!.round());
      }

      // Calculate safe Isha time adjustments
      DateTime safeIsha() {
        if (calculationParameters.method == "MoonsightingCommittee") {
          return CelestialMath.seasonAdjustedEveningTwilight(
              coordinates.latitude,
              CelestialTimeUtils.dayOfYear(date),
              date.year,
              sunsetTime);
        } else {
          var portion = calculationParameters.nightPortions()["isha"];
          nightFraction = (portion ?? 1) * night;
          return CelestialTimeUtils.dateByAddingSeconds(
              sunsetTime, nightFraction!.round());
        }
      }

      // Calculate safe Isha time adjustments before sunset
      DateTime safeIshaBefore() {
        if (calculationParameters.method == "MoonsightingCommittee") {
          return CelestialMath.seasonAdjustedEveningTwilight(
              coordinates.latitude,
              CelestialTimeUtils.dayOfYear(date),
              date.year,
              sunsetTime);
        } else {
          var portion = calculationParameters.nightPortions()["isha"];
          nightFraction = (portion ?? 1) * night;
          return CelestialTimeUtils.dateByAddingSeconds(
              sunsetTime, nightFraction!.round());
        }
      }

      // Apply safe Isha time adjustments
      if (safeIsha().isBefore(ishaTime)) {
        ishaTime = safeIsha();
      }

      if (safeIshaBefore().isBefore(ishabeforeTime)) {
        ishabeforeTime = safeIshaBefore();
      }
    }

    // Calculate Maghrib time based on angle
    maghribTime = sunsetTime;
    if (calculationParameters.maghribAngle != null) {
      DateTime angleBasedMaghrib = PrayerTimeConverter(solarTime.hourAngle(
              -1 * calculationParameters.maghribAngle!, true))
          .utcDate(date.year, date.month, date.day);
      if (sunsetTime.isBefore(angleBasedMaghrib) &&
          ishaTime.isAfter(angleBasedMaghrib)) {
        maghribTime = angleBasedMaghrib;
      }
    }

    // Apply adjustments for each prayer time
    double fajrAdjustment = (calculationParameters.adjustments["fajr"] ?? 0) +
        (calculationParameters.methodAdjustments["fajr"] ?? 0);
    double sunriseAdjustment =
        (calculationParameters.adjustments["sunrise"] ?? 0) +
            (calculationParameters.methodAdjustments["sunrise"] ?? 0);
    double dhuhrAdjustment = (calculationParameters.adjustments["dhuhr"] ?? 0) +
        (calculationParameters.methodAdjustments["dhuhr"] ?? 0);
    double asrAdjustment = (calculationParameters.adjustments["asr"] ?? 0) +
        (calculationParameters.methodAdjustments["asr"] ?? 0);
    double maghribAdjustment =
        (calculationParameters.adjustments["maghrib"] ?? 0) +
            (calculationParameters.methodAdjustments["maghrib"] ?? 0);
    double ishaAdjustment = (calculationParameters.adjustments["isha"] ?? 0) +
        (calculationParameters.methodAdjustments["isha"] ?? 0);

    fajrStartTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(fajrTime, fajrAdjustment),
            precision: precision),
        location);
    ishaEndTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(fajrafterTime, fajrAdjustment),
            precision: precision),
        location);
    tahajjudEndTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(fajrTime, fajrAdjustment),
            precision: precision),
        location);
    sehri = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(
                fajrTime.subtract(const Duration(minutes: 10)), fajrAdjustment),
            precision: precision),
        location);
    sunrise = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(
                sunriseTime, sunriseAdjustment),
            precision: precision),
        location);
    fajrEndTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(
                sunriseTime, sunriseAdjustment),
            precision: precision),
        location);
    dhuhrStartTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(dhuhrTime, dhuhrAdjustment),
            precision: precision),
        location);
    asrStartTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(asrTime, asrAdjustment),
            precision: precision),
        location);
    dhuhrEndTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(asrTime, asrAdjustment),
            precision: precision),
        location);
    maghribStartTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(
                maghribTime, maghribAdjustment),
            precision: precision),
        location);
    asrEndTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(
                maghribTime, maghribAdjustment),
            precision: precision),
        location);
    ishaStartTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(ishaTime, ishaAdjustment),
            precision: precision),
        location);
    //  fajrafter = tz.TZDateTime.from(CelestialTimeUtils.roundedMinute(CelestialTimeUtils.dateByAddingMinutes(fajrafterTime, fajrAdjustment), precision: precision), location);
    // ishabefore = tz.TZDateTime.from(CelestialTimeUtils.roundedMinute(CelestialTimeUtils.dateByAddingMinutes(ishabeforeTime, ishaAdjustment), precision: precision), location);
    maghribEndTime = tz.TZDateTime.from(
        CelestialTimeUtils.roundedMinute(
            CelestialTimeUtils.dateByAddingMinutes(
                ishabeforeTime, ishaAdjustment),
            precision: precision),
        location);
  }

  /// Returns the calculated time for the specified prayer.
  ///
  /// @param prayer The prayer for which to retrieve the time (e.g., Prayer.Fajr).
  /// @return The calculated DateTime for the specified prayer, or null if the prayer is not recognized.
  DateTime? timeForPrayer(String prayer) {
    if (prayer == PrayerType.fajr) {
      return fajrStartTime;
    } else if (prayer == PrayerType.sunrise) {
      return sunrise;
    } else if (prayer == PrayerType.dhuhr) {
      return dhuhrStartTime;
    } else if (prayer == PrayerType.asr) {
      return asrStartTime;
    } else if (prayer == PrayerType.maghrib) {
      return maghribStartTime;
    } else if (prayer == PrayerType.isha) {
      return ishaStartTime;
      // } else if (prayer == PrayerType.IshaBefore) {
      //   return ishabefore;
      // } else if (prayer == PrayerType.FajrAfter) {
      //   return fajrafter;
    } else if (prayer == PrayerType.sehri) {
      return sehri;
    } else {
      return null;
    }
  }

  /// Returns the current prayer based on the provided date.
  ///
  /// @param date The DateTime for which to determine the current prayer.
  /// @return The current prayer (e.g., Prayer.Fajr, Prayer.Sunrise), or Prayer.IshaBefore if none of the prayers match.
  String currentPrayer() {
    DateTime date = DateTime.now();
    if (date.isAfter(ishaStartTime!)) {
      return PrayerType.isha;
    } else if (date.isAfter(maghribStartTime!)) {
      return PrayerType.maghrib;
    } else if (date.isAfter(asrStartTime!)) {
      return PrayerType.asr;
    } else if (date.isAfter(dhuhrStartTime!)) {
      return PrayerType.dhuhr;
    } else if (date.isAfter(sunrise!)) {
      return PrayerType.sunrise;
    } else if (date.isAfter(fajrStartTime!)) {
      return PrayerType.fajr;
    } else {
      return PrayerType.ishaBefore;
    }
  }

  /// Returns the next prayer based on the provided date.
  ///
  /// @param date The DateTime for which to determine the next prayer.
  /// @return The next prayer (e.g., Prayer.FajrAfter, Prayer.Isha), or Prayer.Fajr if none of the prayers match.
  String nextPrayer({DateTime? date}) {
    date ??= DateTime.now();
    if (date.isAfter(ishaStartTime!)) {
      return PrayerType.fajrAfter;
    } else if (date.isAfter(maghribStartTime!)) {
      return PrayerType.isha;
    } else if (date.isAfter(asrStartTime!)) {
      return PrayerType.maghrib;
    } else if (date.isAfter(dhuhrStartTime!)) {
      return PrayerType.asr;
    } else if (date.isAfter(sunrise!)) {
      return PrayerType.dhuhr;
    } else if (date.isAfter(fajrStartTime!)) {
      return PrayerType.sunrise;
    } else {
      return PrayerType.fajr;
    }
  }
}
