import 'package:prayers_times/src/calculation/celestial_time_calculation.dart';
import 'package:prayers_times/src/prayers/prayer_time.dart';

/// The `SunnahInsights` class provides calculations for middle of the night and last third of the night times.
///
/// This class calculates middle of the night and last third of the night times based on provided PrayerTimes.
/// It uses the PrayerTimes and CelestialMath classes for calculations.
///
/// The calculations are based on established CelestialMath algorithms and formulas.
/// Please refer to authoritative sources for detailed explanations and references for the calculations.
class SunnahInsights {
  /// The time representing the middle of the night.
  late DateTime middleOfTheNight;

  /// The time representing the last third of the night.
  late DateTime lastThirdOfTheNight;

  /// Constructs a `SunnahInsights` object and calculates middle of the night and last third of the night times.
  ///
  /// The calculated times are based on the provided PrayerTimes.
  ///
  /// @param prayerTimes The PrayerTimes for which Sunnah times are to be calculated.
  /// @param precision Specifies whether to round the calculated times to the nearest minute (default: true).
  SunnahInsights(PrayerTimes prayerTimes, {bool precision = true}) {
    PrayerTimes nextDayPrayerTimes = PrayerTimes(
      coordinates: prayerTimes.coordinates,
      calculationParameters: prayerTimes.calculationParameters,
      precision: precision,
      locationName: prayerTimes.locationName,
    );

    Duration nightDuration = (nextDayPrayerTimes.fajrStartTime!
        .difference(prayerTimes.maghribStartTime!));

    middleOfTheNight = CelestialTimeUtils.roundedMinute(
        CelestialTimeUtils.dateByAddingSeconds(prayerTimes.maghribStartTime!,
            (nightDuration.inSeconds / 2).floor()),
        precision: precision);

    lastThirdOfTheNight = CelestialTimeUtils.roundedMinute(
        CelestialTimeUtils.dateByAddingSeconds(prayerTimes.maghribStartTime!,
            ((nightDuration.inSeconds / 3) * 2).floor()),
        precision: precision);
  }
}
