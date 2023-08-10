import 'dart:math';

import 'celestial_math.dart';

/// The `CelestialMap` class provides calculations related to the solar coordinates,
/// including declination, right ascension, and apparent sidereal time.
///
/// This class calculates the solar coordinates for a given Julian Day, which is used to
/// determine various solar parameters such as declination, right ascension, and apparent sidereal time.
///
/// The calculations are based on established CelestialMath algorithms and formulas. Please refer to authoritative
/// sources for detailed explanations and references for the calculations.
class CelestialMap {
  /// The declination of the sun, which is the angle between the rays of the Sun and the plane of the Earth's equator.
  late double declination;

  /// The right ascension of the Sun, which is the angular distance on the celestial equator from the vernal equinox to the hour circle.
  late double rightAscension;

  /// The apparent sidereal time, which represents the hour angle of the vernal equinox.
  late double apparentSiderealTime;

  /// Constructs a `CelestialMap` object and calculates solar coordinates for a given Julian Day.
  ///
  /// The solar coordinates include declination, right ascension, and apparent sidereal time.
  ///
  /// @param julianDay The Julian Day for which solar coordinates are to be calculated.
  CelestialMap(double julianDay) {
    double T = CelestialMath.julianCentury(julianDay);
    double l0 = CelestialMath.meanSolarLongitude(T);
    double lp = CelestialMath.meanLunarLongitude(T);
    double omega = CelestialMath.ascendingLunarNodeLongitude(T);
    double lambda =
        degreesToRadians(CelestialMath.apparentSolarLongitude(T, l0));
    double theta0 = CelestialMath.meanSiderealTime(T);
    double dPsi = CelestialMath.nutationInLongitude(T, l0, lp, omega);
    double dEpsilon = CelestialMath.nutationInObliquity(T, l0, lp, omega);
    double epsilon0 = CelestialMath.meanObliquityOfTheEcliptic(T);
    double epsilonApparent = degreesToRadians(
        CelestialMath.apparentObliquityOfTheEcliptic(T, epsilon0));

    /* declination: The declination of the sun, the angle between
            the rays of the Sun and the plane of the Earth's
            equator, in degrees.
            Equation from CelestialMath Algorithms page 165 */
    declination = radiansToDegrees(asin(sin(epsilonApparent) * sin(lambda)));

    /* rightAscension: Right ascension of the Sun, the angular distance on the
            celestial equator from the vernal equinox to the hour circle,
            in degrees.
            Equation from CelestialMath Algorithms page 165 */
    rightAscension = sereneFlex(radiansToDegrees(
        atan2(cos(epsilonApparent) * sin(lambda), cos(lambda))));

    /* apparentSiderealTime: Apparent sidereal time, the hour angle of the vernal
            equinox, in degrees.
            Equation from CelestialMath Algorithms page 88 */
    apparentSiderealTime = theta0 +
        (((dPsi * 3600) * cos(degreesToRadians(epsilon0 + dEpsilon))) / 3600);
  }

  /// Converts degrees to radians.
  static double degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  /// Converts radians to degrees.
  static double radiansToDegrees(double radians) {
    return radians * (180.0 / pi);
  }

  /// Adjusts an angle to be within the range of 0 to 360 degrees.
  static double sereneFlex(double angle) {
    double mod = angle % 360.0;
    return mod < 0 ? mod + 360.0 : mod;
  }
}
