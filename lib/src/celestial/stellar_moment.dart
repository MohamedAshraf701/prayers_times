import 'dart:math';

import 'package:prayers_times/src/calculation/celestial_calculation.dart';
import 'package:prayers_times/src/celestial/celestial_map.dart';
import 'package:prayers_times/src/utils/coordinates.dart';

import 'celestial_math.dart';

/// The `StellarMoment` class provides calculations related to solar time,
/// including sunrise, sunset, and solar transit times.
///
/// This class calculates solar times based on provided date and coordinates.
/// It uses the CelestialMath and CelestialMap classes from the CelestialMath library.
///
/// The calculations are based on established CelestialMath algorithms and formulas.
/// Please refer to authoritative sources for detailed explanations and references for the calculations.
class StellarMoment {
  /// The geographical coordinates of the observer.
  late Coordinates observer;

  /// Solar coordinates for the current date.
  late CelestialMap solar;

  /// Solar coordinates for the previous day.
  late CelestialMap prevSolar;

  /// Solar coordinates for the next day.
  late CelestialMap nextSolar;

  /// The approximate transit time of the sun (in universal time).
  double? approxTransit;

  /// The solar transit time (in universal time).
  late double transit;

  /// The sunrise time (in universal time).
  late double sunrise;

  /// The sunset time (in universal time).
  late double sunset;

  /// Constructs a `StellarMoment` object and calculates solar times for the given date and observer coordinates.
  ///
  /// The solar times include approximate transit, transit, sunrise, and sunset.
  ///
  /// @param date The date for which solar times are to be calculated.
  /// @param coordinates The geographical coordinates of the observer.
  StellarMoment(DateTime date, Coordinates coordinates) {
    double julianDay =
        CelestialMath.julianDay(date.year, date.month, date.day, 0);

    observer = coordinates;
    solar = CelestialMap(julianDay);

    prevSolar = CelestialMap(julianDay - 1);
    nextSolar = CelestialMap(julianDay + 1);

    double m0 = CelestialMath.approximateTransit(coordinates.longitude,
        solar.apparentSiderealTime, solar.rightAscension);
    const solarAltitude = -50.0 / 60.0;

    approxTransit = m0;

    transit = CelestialMath.correctedTransit(
        m0,
        coordinates.longitude,
        solar.apparentSiderealTime,
        solar.rightAscension,
        prevSolar.rightAscension,
        nextSolar.rightAscension);

    sunrise = CelestialMath.correctedHourAngle(
        m0,
        solarAltitude,
        coordinates,
        false,
        solar.apparentSiderealTime,
        solar.rightAscension,
        prevSolar.rightAscension,
        nextSolar.rightAscension,
        solar.declination,
        prevSolar.declination,
        nextSolar.declination);

    sunset = CelestialMath.correctedHourAngle(
        m0,
        solarAltitude,
        coordinates,
        true,
        solar.apparentSiderealTime,
        solar.rightAscension,
        prevSolar.rightAscension,
        nextSolar.rightAscension,
        solar.declination,
        prevSolar.declination,
        nextSolar.declination);
  }

  /// Calculate the hour angle based on the provided angle and whether it's after transit.
  double hourAngle(double angle, bool afterTransit) {
    return CelestialMath.correctedHourAngle(
        approxTransit,
        angle,
        observer,
        afterTransit,
        solar.apparentSiderealTime,
        solar.rightAscension,
        prevSolar.rightAscension,
        nextSolar.rightAscension,
        solar.declination,
        prevSolar.declination,
        nextSolar.declination);
  }

  /// Calculate the afternoon time based on the provided shadow length.
  double afternoon(double shadowLength) {
    double tangent = (observer.latitude - solar.declination).abs();
    double inverse =
        shadowLength + tan(CelestialUtils.degreesToRadians(tangent));
    double angle = CelestialUtils.radiansToDegrees(atan(1.0 / inverse));
    return hourAngle(angle, true);
  }
}
