/// The `CelestialMath` class provides various CelestialMath calculations and utilities,
/// including calculations related to celestial positions, angles, time adjustments, and more.
///
/// This class contains static methods that allow you to perform calculations for celestial bodies,
/// angles, coordinate transformations, and other CelestialMath phenomena.
///
/// The calculations in this class are based on established CelestialMath algorithms and formulas.
/// Please refer to authoritative sources for detailed explanations and references for the calculations.
import 'dart:math';

import 'package:prayers_times/src/calculation/celestial_calculation.dart';
import 'package:prayers_times/src/calculation/celestial_time_calculation.dart';
import 'package:prayers_times/src/utils/coordinates.dart';

class CelestialMath {
  /// Calculate the geometric mean longitude of the sun in degrees.
  ///
  /// This method calculates the geometric mean longitude of the sun for a given
  /// Julian century using the CelestialMath Algorithms formula. The result is
  /// unwound to the range [0, 360) degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms
  /// (Jean Meeus) and can be found on page 163.
  ///
  /// - Parameter julianCentury: The Julian century for which to calculate the mean solar longitude.
  /// - Returns: The calculated geometric mean longitude of the sun in degrees.
  static double meanSolarLongitude(double julianCentury) {
    /// The Julian century used in calculations.
    double T = julianCentury;

    /// Constant term from the CelestialMath Algorithms formula.
    const term1 = 280.4664567;

    /// Term with a linear coefficient from the CelestialMath Algorithms formula.
    double term2 = 36000.76983 * T;

    /// Term with a quadratic coefficient from the CelestialMath Algorithms formula.
    double term3 = 0.0003032 * pow(T, 2);

    /// Calculate the geometric mean longitude of the sun (L0) using terms.
    double l0 = term1 + term2 + term3;

    /// Unwind the angle to the range [0, 360) degrees.
    return CelestialUtils.sereneFlex(l0);
  }

  /// Calculate the geometric mean longitude of the moon in degrees.
  ///
  /// This method calculates the geometric mean longitude of the moon for a given
  /// Julian century using the CelestialMath Algorithms formula. The result is
  /// unwound to the range [0, 360) degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms
  /// (Jean Meeus) and can be found on page 144.
  ///
  /// - Parameter julianCentury: The Julian century for which to calculate the mean lunar longitude.
  /// - Returns: The calculated geometric mean longitude of the moon in degrees.
  static double meanLunarLongitude(double julianCentury) {
    /// The Julian century used in calculations.
    double T = julianCentury;

    /// Constant term from the CelestialMath Algorithms formula.
    const term1 = 218.3165;

    /// Term with a linear coefficient from the CelestialMath Algorithms formula.
    double term2 = 481267.8813 * T;

    /// Calculate the geometric mean longitude of the moon (lp) using terms.
    double lp = term1 + term2;

    /// Unwind the angle to the range [0, 360) degrees.
    return CelestialUtils.sereneFlex(lp);
  }

  /// Calculate the longitude of the ascending lunar node in degrees.
  ///
  /// This method calculates the longitude of the ascending lunar node, also known
  /// as the "Dragon's Head," for a given Julian century using the CelestialMath
  /// Algorithms formula. The result is unwound to the range [0, 360) degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms
  /// (Jean Meeus) and can be found on page 144.
  ///
  /// - Parameter julianCentury: The Julian century for which to calculate the ascending lunar node longitude.
  /// - Returns: The calculated longitude of the ascending lunar node in degrees.
  static double ascendingLunarNodeLongitude(double julianCentury) {
    /// The Julian century used in calculations.
    double T = julianCentury;

    /// Constant term from the CelestialMath Algorithms formula.
    const term1 = 125.04452;

    /// Term with a linear coefficient from the CelestialMath Algorithms formula.
    double term2 = 1934.136261 * T;

    /// Term with a quadratic coefficient from the CelestialMath Algorithms formula.
    double term3 = 0.0020708 * pow(T, 2);

    /// Term with a cubic coefficient from the CelestialMath Algorithms formula.
    double term4 = pow(T, 3) / 450000;

    /// Calculate the longitude of the ascending lunar node (Omega) using terms.
    double omega = term1 - term2 + term3 + term4;

    /// Unwind the angle to the range [0, 360) degrees.
    return CelestialUtils.sereneFlex(omega);
  }

  /// Calculate the mean anomaly of the sun in degrees.
  ///
  /// This method calculates the mean anomaly of the sun for a given Julian century
  /// using the CelestialMath Algorithms formula. The result is unwound to the range [0, 360) degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms and can be found
  /// on page 163.
  ///
  /// - Parameter julianCentury: The Julian century for which to calculate the mean solar anomaly.
  /// - Returns: The calculated mean anomaly of the sun in degrees.
  static double meanSolarAnomaly(double julianCentury) {
    /// The Julian century used in calculations.
    double T = julianCentury;

    /// Constant term from the CelestialMath Algorithms formula.
    const term1 = 357.52911;

    /// Term with a linear coefficient from the CelestialMath Algorithms formula.
    double term2 = 35999.05029 * T;

    /// Term with a quadratic coefficient from the CelestialMath Algorithms formula.
    double term3 = 0.0001537 * pow(T, 2);

    /// Calculate the mean anomaly of the sun (M) using terms.
    double M = term1 + term2 - term3;

    /// Unwind the angle to the range [0, 360) degrees using CelestialUtils method.
    return CelestialUtils.sereneFlex(M);
  }

  /// Calculate the Sun's equation of the center in degrees.
  ///
  /// This method calculates the equation of the center of the Sun for a given Julian century and mean anomaly
  /// using the CelestialMath Algorithms formula. The result is the equation of the center in degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms and can be found
  /// on page 164.
  ///
  /// - Parameter julianCentury: The Julian century for which to calculate the equation of the center.
  /// - Parameter meanAnomaly: The mean anomaly of the sun in degrees.
  /// - Returns: The calculated equation of the center of the Sun in degrees.
  static double solarEquationOfTheCenter(
      double julianCentury, double meanAnomaly) {
    /// The Julian century used in calculations.
    double T = julianCentury;

    /// Convert mean anomaly from degrees to radians.
    double mrad = CelestialUtils.degreesToRadians(meanAnomaly);

    /// Term1 with coefficients from the CelestialMath Algorithms formula.
    double term1 =
        (1.914602 - (0.004817 * T) - (0.000014 * pow(T, 2))) * sin(mrad);

    /// Term2 with coefficients from the CelestialMath Algorithms formula.
    double term2 = (0.019993 - (0.000101 * T)) * sin(2 * mrad);

    /// Term3 with coefficient from the CelestialMath Algorithms formula.
    double term3 = 0.000289 * sin(3 * mrad);

    /// Calculate the Sun's equation of the center using the summed terms.
    return term1 + term2 + term3;
  }

  /// Calculate the apparent longitude of the Sun, referred to the true equinox of the date.
  ///
  /// This method calculates the apparent longitude of the Sun for a given Julian century and mean longitude
  /// using the CelestialMath Algorithms formula. The result is the apparent longitude of the Sun in degrees,
  /// referred to the true equinox of the date.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms and can be found
  /// on page 164.
  ///
  /// - Parameter julianCentury: The Julian century for which to calculate the apparent solar longitude.
  /// - Parameter meanLongitude: The mean longitude of the Sun in degrees.
  /// - Returns: The calculated apparent longitude of the Sun in degrees.
  static double apparentSolarLongitude(
      double julianCentury, double meanLongitude) {
    /// The Julian century used in calculations.
    double T = julianCentury;

    /// Mean longitude of the Sun.
    double l0 = meanLongitude;

    /// Calculate the Sun's equation of the center using the CelestialMath.solarEquationOfTheCenter method.
    double equationOfTheCenter = CelestialMath.solarEquationOfTheCenter(
        T, CelestialMath.meanSolarAnomaly(T));

    /// Calculate the apparent longitude of the Sun using the mean longitude, equation of the center, and corrections.
    double longitude = l0 + equationOfTheCenter;

    /// Calculate Omega using coefficients and formula from CelestialMath Algorithms.
    double omega = 125.04 - (1934.136 * T);

    /// Calculate Lambda with corrections using longitude, omega, and coefficients.
    double lambda = longitude -
        0.00569 -
        (0.00478 * sin(CelestialUtils.degreesToRadians(omega)));

    /// Unwind the angle to ensure it is within the valid range.
    return CelestialUtils.sereneFlex(lambda);
  }

  /// Calculate the mean obliquity of the ecliptic, formula adopted by the International CelestialMath Union.
  ///
  /// This method calculates the mean obliquity of the ecliptic for a given Julian century using
  /// the CelestialMath Algorithms formula. The result is the mean obliquity of the ecliptic represented
  /// in degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms and can be found
  /// on page 147.
  ///
  /// - Parameter julianCentury: The Julian century for which to calculate the mean obliquity of the ecliptic.
  /// - Returns: The calculated mean obliquity of the ecliptic in degrees.
  static double meanObliquityOfTheEcliptic(double julianCentury) {
    /// The Julian century used in calculations.
    double T = julianCentury;

    /// Coefficients and terms for the calculation.
    const term1 = 23.439291;
    double term2 = 0.013004167 * T;
    double term3 = 0.0000001639 * pow(T, 2);
    double term4 = 0.0000005036 * pow(T, 3);

    /// Calculate the mean obliquity of the ecliptic using the formula and coefficients.
    return term1 - term2 - term3 + term4;
  }

  /// Calculate the apparent obliquity of the ecliptic, corrected for calculating the apparent position of the sun.
  ///
  /// This method calculates the apparent obliquity of the ecliptic for a given Julian century and mean obliquity of the ecliptic,
  /// using the CelestialMath Algorithms formula. The result is the apparent obliquity of the ecliptic corrected for calculating
  /// the apparent position of the sun, represented in degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms and can be found on page 165.
  ///
  /// - Parameter julianCentury: The Julian century for which to calculate the apparent obliquity of the ecliptic.
  /// - Parameter meanObliquityOfTheEcliptic: The mean obliquity of the ecliptic for the given Julian century.
  /// - Returns: The calculated apparent obliquity of the ecliptic in degrees.
  static double apparentObliquityOfTheEcliptic(
      double julianCentury, double meanObliquityOfTheEcliptic) {
    /// The Julian century used in calculations.
    double T = julianCentury;

    /// The mean obliquity of the ecliptic.
    double epsilon0 = meanObliquityOfTheEcliptic;

    /// Coefficient for the calculation.
    double O = 125.04 - (1934.136 * T);

    /// Calculate the apparent obliquity of the ecliptic using the formula and coefficients.
    return epsilon0 + (0.00256 * cos(CelestialUtils.degreesToRadians(O)));
  }

  /// Calculate the mean sidereal time, which represents the hour angle of the vernal equinox, in degrees.
  ///
  /// This method calculates the mean sidereal time for a given Julian century, using the CelestialMath Algorithms formula.
  /// The result is the hour angle of the vernal equinox, which indicates the angle of the Earth's rotation relative to the vernal equinox,
  /// measured in degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms and can be found on page 165.
  ///
  /// - Parameter julianCentury: The Julian century for which to calculate the mean sidereal time.
  /// - Returns: The calculated mean sidereal time in degrees.
  static double meanSiderealTime(double julianCentury) {
    /// The Julian century used in calculations.
    double T = julianCentury;

    /// Calculate the Julian Day for the given Julian century.
    double jd = (T * 36525) + 2451545.0;

    /// Coefficients for the calculation.
    const term1 = 280.46061837;
    double term2 = 360.98564736629 * (jd - 2451545);
    double term3 = 0.000387933 * pow(T, 2);
    double term4 = pow(T, 3) / 38710000;

    /// Calculate the mean sidereal time using the formula and coefficients.
    double theta = term1 + term2 + term3 - term4;

    /// Unwind the angle to ensure it falls within the valid range.
    return CelestialUtils.sereneFlex(theta);
  }

  /// Calculate the nutation in longitude, which represents the variation in the apparent position of a celestial body due to the gravitational influences of the sun and moon.
  ///
  /// This method calculates the nutation in longitude for a given Julian century, solar longitude, lunar longitude, and ascending node.
  /// The result indicates the variation in the apparent position of a celestial body caused by the gravitational forces of the sun and moon,
  /// measured in degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms and can be found on page 144.
  ///
  /// - Parameters:
  ///   - julianCentury: The Julian century for which to calculate the nutation in longitude.
  ///   - solarLongitude: The geometric mean longitude of the sun in degrees.
  ///   - lunarLongitude: The geometric mean longitude of the moon in degrees.
  ///   - ascendingNode: The ascending lunar node longitude in degrees.
  /// - Returns: The calculated nutation in longitude in degrees.
  static double nutationInLongitude(double julianCentury, double solarLongitude,
      double lunarLongitude, double ascendingNode) {
    /// Geometric mean longitude of the sun.
    double l0 = solarLongitude;

    /// Geometric mean longitude of the moon.
    double lp = lunarLongitude;

    /// Ascending lunar node longitude.
    double omega = ascendingNode;

    /// Coefficients for the calculation.
    double term1 = (-17.2 / 3600) * sin(CelestialUtils.degreesToRadians(omega));
    double term2 = (1.32 / 3600) * sin(2 * CelestialUtils.degreesToRadians(l0));
    double term3 = (0.23 / 3600) * sin(2 * CelestialUtils.degreesToRadians(lp));
    double term4 =
        (0.21 / 3600) * sin(2 * CelestialUtils.degreesToRadians(omega));

    /// Calculate the nutation in longitude using the formula and coefficients.
    return term1 - term2 - term3 + term4;
  }

  /// Calculate the nutation in obliquity, which represents the variation in the tilt of the Earth's axis due to the gravitational influences of the sun and moon.
  ///
  /// This method calculates the nutation in obliquity for a given Julian century, solar longitude, lunar longitude, and ascending node.
  /// The result indicates the variation in the tilt of the Earth's axis caused by the gravitational forces of the sun and moon,
  /// measured in degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms and can be found on page 144.
  ///
  /// - Parameters:
  ///   - julianCentury: The Julian century for which to calculate the nutation in obliquity.
  ///   - solarLongitude: The geometric mean longitude of the sun in degrees.
  ///   - lunarLongitude: The geometric mean longitude of the moon in degrees.
  ///   - ascendingNode: The ascending lunar node longitude in degrees.
  /// - Returns: The calculated nutation in obliquity in degrees.
  static double nutationInObliquity(double julianCentury, double solarLongitude,
      double lunarLongitude, double ascendingNode) {
    /// Geometric mean longitude of the sun.
    double l0 = solarLongitude;

    /// Geometric mean longitude of the moon.
    double lp = lunarLongitude;

    /// Ascending lunar node longitude.
    double omega = ascendingNode;

    /// Coefficients for the calculation.
    double term1 = (9.2 / 3600) * cos(CelestialUtils.degreesToRadians(omega));
    double term2 = (0.57 / 3600) * cos(2 * CelestialUtils.degreesToRadians(l0));
    double term3 = (0.10 / 3600) * cos(2 * CelestialUtils.degreesToRadians(lp));
    double term4 =
        (0.09 / 3600) * cos(2 * CelestialUtils.degreesToRadians(omega));

    /// Calculate the nutation in obliquity using the formula and coefficients.
    return term1 + term2 + term3 - term4;
  }

  /// Calculate the altitude of a celestial body above the horizon for a given observer.
  ///
  /// This method calculates the altitude of a celestial body above the horizon, taking into account the observer's latitude, celestial body's declination, and local hour angle.
  /// The result indicates the angle between the observer's horizontal plane and a line drawn from the observer to the celestial body, measured in degrees.
  ///
  /// The formula used in this calculation is based on CelestialMath Algorithms and can be found on page 93.
  ///
  /// - Parameters:
  ///   - observerLatitude: The latitude of the observer in degrees.
  ///   - declination: The declination of the celestial body in degrees.
  ///   - localHourAngle: The local hour angle of the celestial body in degrees.
  /// - Returns: The calculated altitude of the celestial body above the horizon in degrees.
  static double altitudeOfCelestialBody(
      double observerLatitude, double declination, double localHourAngle) {
    /// Latitude of the observer.
    double phi = observerLatitude;

    /// Declination of the celestial body.
    double delta = declination;

    /// Local hour angle of the celestial body.
    double H = localHourAngle;

    /// Calculate the sine and cosine terms for the altitude calculation.
    double term1 = sin(CelestialUtils.degreesToRadians(phi)) *
        sin(CelestialUtils.degreesToRadians(delta));
    double term2 = cos(CelestialUtils.degreesToRadians(phi)) *
        cos(CelestialUtils.degreesToRadians(delta)) *
        cos(CelestialUtils.degreesToRadians(H));

    /// Calculate the altitude of the celestial body using the asin function.
    return CelestialUtils.radiansToDegrees(asin(term1 + term2));
  }

  /// Calculate the approximate time of the celestial body's transit.
  ///
  /// This method estimates the time at which a celestial body transits the meridian of a specific longitude.
  /// It uses the approximate transit equation based on CelestialMath Algorithms, as described on page 102.
  ///
  /// - Parameters:
  ///   - longitude: The longitude of the observer in degrees.
  ///   - siderealTime: The mean sidereal time at Greenwich in degrees.
  ///   - rightAscension: The right ascension of the celestial body in degrees.
  /// - Returns: The estimated time of the celestial body's transit as a fraction of a day.
  static double approximateTransit(
      double longitude, double siderealTime, double rightAscension) {
    /// Longitude of the observer.
    double L = longitude;

    /// Mean sidereal time at Greenwich.
    double theta0 = siderealTime;

    /// Right ascension of the celestial body.
    double a2 = rightAscension;

    /// Calculate the longitude factor and normalize to the scale of 1 day.
    double lw = L * -1;
    return CelestialUtils.normalizeToScale((a2 + lw - theta0) / 360, 1);
  }

  /// Calculate the corrected time of the celestial body's transit.
  ///
  /// This method calculates the time at which a celestial body transits the meridian of a specific longitude,
  /// taking into account corrections based on CelestialMath Algorithms, as described on page 102.
  ///
  /// - Parameters:
  ///   - approximateTransit: The estimated time of the celestial body's transit as a fraction of a day.
  ///   - longitude: The longitude of the observer in degrees.
  ///   - siderealTime: The mean sidereal time at Greenwich in degrees.
  ///   - rightAscension: The right ascension of the celestial body in degrees.
  ///   - previousRightAscension: The right ascension of the celestial body at the previous transit.
  ///   - nextRightAscension: The right ascension of the celestial body at the next transit.
  /// - Returns: The corrected time of the celestial body's transit in universal time.
  static double correctedTransit(
      double approximateTransit,
      double longitude,
      double siderealTime,
      double rightAscension,
      double previousRightAscension,
      double nextRightAscension) {
    /// Estimated time of the celestial body's transit.
    double m0 = approximateTransit;

    /// Longitude of the observer.
    double L = longitude;

    /// Mean sidereal time at Greenwich.
    double theta0 = siderealTime;

    /// Right ascension of the celestial body.
    double a2 = rightAscension;

    /// Right ascension of the celestial body at the previous transit.
    double a1 = previousRightAscension;

    /// Right ascension of the celestial body at the next transit.
    double a3 = nextRightAscension;

    /// Calculate longitude factor and mean sidereal time.
    double lw = L * -1;
    double theta = CelestialUtils.sereneFlex((theta0 + (360.985647 * m0)));

    /// Interpolate right ascension and calculate hour angle.
    double a = CelestialUtils.sereneFlex(
        CelestialMath.interpolateAngles(a2, a1, a3, m0)!);
    double H = CelestialUtils.quadrantShiftAngle(theta - lw - a);

    /// Calculate the time correction factor and corrected transit time.
    double dm = H / -360;
    return (m0 + dm) * 24;
  }

  /// Calculate the corrected hour angle for a celestial body.
  ///
  /// This method calculates the corrected hour angle of a celestial body,
  /// taking into account corrections based on CelestialMath Algorithms, as described on page 102.
  ///
  /// - Parameters:
  ///   - approximateTransit: The estimated time of the celestial body's transit as a fraction of a day.
  ///   - angle: The desired angle, such as the altitude of the celestial body above the horizon.
  ///   - coordinates: The observer's geographic coordinates (latitude and longitude) in degrees.
  ///   - afterTransit: A flag indicating whether the calculation is for after the transit (true) or before (false).
  ///   - siderealTime: The mean sidereal time at Greenwich in degrees.
  ///   - rightAscension: The right ascension of the celestial body in degrees.
  ///   - previousRightAscension: The right ascension of the celestial body at the previous transit.
  ///   - nextRightAscension: The right ascension of the celestial body at the next transit.
  ///   - declination: The declination of the celestial body in degrees.
  ///   - previousDeclination: The declination of the celestial body at the previous transit.
  ///   - nextDeclination: The declination of the celestial body at the next transit.
  /// - Returns: The corrected hour angle of the celestial body in universal time.
  static double correctedHourAngle(
      double? approximateTransit,
      double angle,
      Coordinates coordinates,
      bool afterTransit,
      double siderealTime,
      double rightAscension,
      double previousRightAscension,
      double nextRightAscension,
      double declination,
      double previousDeclination,
      double nextDeclination) {
    /// Estimated time of the celestial body's transit.
    double? m0 = approximateTransit;

    /// Desired angle (e.g., altitude) of the celestial body above the horizon.
    double h0 = angle;

    /// Mean sidereal time at Greenwich.
    double theta0 = siderealTime;

    /// Right ascension of the celestial body.
    double a2 = rightAscension;

    /// Right ascension of the celestial body at the previous transit.
    double? a1 = previousRightAscension;

    /// Right ascension of the celestial body at the next transit.
    double a3 = nextRightAscension;

    /// Declination of the celestial body.
    double d2 = declination;

    /// Declination of the celestial body at the previous transit.
    double d1 = previousDeclination;

    /// Declination of the celestial body at the next transit.
    double d3 = nextDeclination;

    /// Calculate longitude factor and mean sidereal time.
    double lw = coordinates.longitude * -1;
    double term1 = sin(CelestialUtils.degreesToRadians(h0)) -
        (sin(CelestialUtils.degreesToRadians(coordinates.latitude)) *
            sin(CelestialUtils.degreesToRadians(d2)));
    double term2 = cos(CelestialUtils.degreesToRadians(coordinates.latitude)) *
        cos(CelestialUtils.degreesToRadians(d2));

    /// Calculate corrected hour angle.
    double h1 = (term1 / term2).abs() > 1
        ? 1.0
        : CelestialUtils.radiansToDegrees(acos(term1 / term2));
    double m = afterTransit ? m0! + (h1 / 360) : m0! - (h1 / 360);
    double theta = CelestialUtils.sereneFlex((theta0 + (360.985647 * m)));
    double a = CelestialUtils.sereneFlex(
        CelestialMath.interpolateAngles(a2, a1, a3, m)!);
    double delta = CelestialMath.interpolate(d2, d1, d3, m)!;
    double H = (theta - lw - a);
    double h =
        CelestialMath.altitudeOfCelestialBody(coordinates.latitude, delta, H);
    double term3 = h - h0;
    double term4 = 360 *
        cos(CelestialUtils.degreesToRadians(delta)) *
        cos(CelestialUtils.degreesToRadians(coordinates.latitude)) *
        sin(CelestialUtils.degreesToRadians(H));
    double dm = term3 / term4;
    return (m + dm) * 24;
  }

  /// Interpolate a value given equidistant previous and next values and a factor.
  ///
  /// This method calculates the interpolation of a value using equidistant previous and next values
  /// and a factor equal to the fraction of the interpolated point's time over the time between values.
  ///
  /// - Parameters:
  ///   - y2: The value at the current point of interest.
  ///   - y1: The value at the previous point.
  ///   - y3: The value at the next point.
  ///   - n: The factor equal to the fraction of the interpolated point's time over the time between values.
  /// - Returns: The interpolated value.
  static double? interpolate(double y2, double y1, double y3, double n) {
    /// Difference between the current and previous values.
    double a = y2 - y1;

    /// Difference between the next and current values.
    double b = y3 - y2;

    /// Difference between the next and previous values.
    double c = b - a;

    /// Calculate the interpolated value.
    return y2 + ((n / 2) * (a + b + (n * c)));
  }

  /// Interpolate three angles, accounting for angle unwinding.
  ///
  /// This method calculates the interpolation of three angles, taking into account angle unwinding.
  /// It ensures that the resulting angle remains within a valid range, unwinding it if necessary.
  ///
  /// - Parameters:
  ///   - y2: The angle at the current point of interest.
  ///   - y1: The angle at the previous point.
  ///   - y3: The angle at the next point.
  ///   - n: The factor equal to the fraction of the interpolated point's time over the time between values.
  /// - Returns: The interpolated angle.
  static double? interpolateAngles(double y2, double y1, double y3, double n) {
    /// Unwind the angle difference between the current and previous values.
    double a = CelestialUtils.sereneFlex(y2 - y1);

    /// Unwind the angle difference between the next and current values.
    double b = CelestialUtils.sereneFlex(y3 - y2);

    /// Difference between the next and previous angles.
    double c = b - a;

    /// Calculate the unwound and interpolated angle.
    return y2 + ((n / 2) * (a + b + (n * c)));
  }

  /// Calculate the Julian Day for the given Gregorian date components.
  ///
  /// This method calculates the Julian Day (jd) for the given Gregorian date components,
  /// including year, month, day, and optional hours. The Julian Day represents the number
  /// of days and fractions of a day since noon Universal Time on January 1, 4713 BCE.
  ///
  /// - Parameters:
  ///   - year: The Gregorian year.
  ///   - month: The Gregorian month (1-12).
  ///   - day: The day of the month.
  ///   - hours: The optional fractional hours of the day (default is 0).
  /// - Returns: The calculated Julian Day.
  static double julianDay(int year, int month, int day, [double hours = 0]) {
    /// Helper function to truncate a value.
    int trunc(double val) => val.truncate();

    /// Determine the year and month adjustments for the Julian Day calculation.
    int Y = trunc((month > 2 ? year : year - 1).toDouble());
    int M = trunc((month > 2 ? month : month + 12).toDouble());
    double D = day + (hours / 24);

    /// Calculate the A and B coefficients for the Julian Day formula.
    int A = trunc(Y / 100);
    int B = trunc((2 - A + trunc(A / 4)).toDouble());

    /// Calculate the integral parts of the Julian Day formula.
    int i0 = trunc(365.25 * (Y + 4716));
    int i1 = trunc(30.6001 * (M + 1));

    /// Calculate and return the Julian Day.
    return i0 + i1 + D + B - 1524.5;
  }

  /// Calculate the Julian Century from the given Julian Day.
  ///
  /// This method calculates the Julian Century (JC) corresponding to the given Julian Day,
  /// which represents the number of Julian centuries since the epoch (J2000.0, January 1, 2000, 12:00 TT).
  ///
  /// - Parameter julianDay: The Julian Day for which to calculate the Julian Century.
  /// - Returns: The calculated Julian Century.
  static double julianCentury(double julianDay) {
    /// Calculate the Julian Century using the Julian Day and the J2000.0 epoch.
    return (julianDay - 2451545.0) / 36525;
  }

  /// Determine whether a given year is a leap year (has 366 days).
  ///
  /// This method checks whether the provided year is a leap year based on the rules
  /// of the Gregorian calendar. A leap year occurs every 4 years, except for years
  /// that are divisible by 100 but not divisible by 400.
  ///
  /// - Parameter year: The year to be checked for leap year status.
  /// - Returns: `true` if the year is a leap year, `false` otherwise.
  static bool isLeapYear(int year) {
    /// Check if the provided year is divisible by 4.
    if (year % 4 != 0) {
      return false;
    }

    /// Check if the year is divisible by 100 but not by 400.
    if (year % 100 == 0 && year % 400 != 0) {
      return false;
    }

    /// If neither of the above conditions are met, it's a leap year.
    return true;
  }

  /// Calculate the time of season-adjusted morning twilight.
  ///
  /// This method calculates the time of morning twilight (when the sun is below the horizon)
  /// adjusted for the specific latitude, day of the year, year, and sunrise time. The adjustment
  /// accounts for the changing duration of twilight throughout the year and is based on the latitude.
  ///
  /// - Parameters:
  ///   - latitude: The latitude of the observer's location in degrees.
  ///   - dayOfYear: The day of the year (1-365) for which to calculate the adjusted twilight time.
  ///   - year: The year of the observation.
  ///   - sunrise: The time of sunrise for the specified day and location.
  /// - Returns: The adjusted time of morning twilight.
  static DateTime seasonAdjustedMorningTwilight(
      double latitude, int dayOfYear, int year, DateTime sunrise) {
    double a = 75 + ((28.65 / 55.0) * (latitude).abs());
    double b = 75 + ((19.44 / 55.0) * (latitude).abs());
    double c = 75 + ((32.74 / 55.0) * (latitude).abs());
    double d = 75 + ((48.10 / 55.0) * (latitude).abs());

    double adjustment() {
      int dyy = CelestialMath.daysSinceSolstice(dayOfYear, year, latitude);
      if (dyy < 91) {
        return a + (b - a) / 91.0 * dyy;
      } else if (dyy < 137) {
        return b + (c - b) / 46.0 * (dyy - 91);
      } else if (dyy < 183) {
        return c + (d - c) / 46.0 * (dyy - 137);
      } else if (dyy < 229) {
        return d + (c - d) / 46.0 * (dyy - 183);
      } else if (dyy < 275) {
        return c + (b - c) / 46.0 * (dyy - 229);
      } else {
        return b + (a - b) / 91.0 * (dyy - 275);
      }
    }

    return CelestialTimeUtils.dateByAddingSeconds(
        sunrise, (adjustment() * -60.0).round());
  }

  /// Calculate the time of season-adjusted evening twilight.
  ///
  /// This method calculates the time of evening twilight (when the sun is below the horizon)
  /// adjusted for the specific latitude, day of the year, year, and sunset time. The adjustment
  /// accounts for the changing duration of twilight throughout the year and is based on the latitude.
  ///
  /// - Parameters:
  ///   - latitude: The latitude of the observer's location in degrees.
  ///   - dayOfYear: The day of the year (1-365) for which to calculate the adjusted twilight time.
  ///   - year: The year of the observation.
  ///   - sunset: The time of sunset for the specified day and location.
  /// - Returns: The adjusted time of evening twilight.
  static DateTime seasonAdjustedEveningTwilight(
      double latitude, int dayOfYear, int year, DateTime sunset) {
    double a = 75 + ((25.60 / 55.0) * (latitude).abs());
    double b = 75 + ((2.050 / 55.0) * (latitude).abs());
    double c = 75 - ((9.210 / 55.0) * (latitude).abs());
    double d = 75 + ((6.140 / 55.0) * (latitude).abs());

    double adjustment() {
      int dyy = CelestialMath.daysSinceSolstice(dayOfYear, year, latitude);
      if (dyy < 91) {
        return a + (b - a) / 91.0 * dyy;
      } else if (dyy < 137) {
        return b + (c - b) / 46.0 * (dyy - 91);
      } else if (dyy < 183) {
        return c + (d - c) / 46.0 * (dyy - 137);
      } else if (dyy < 229) {
        return d + (c - d) / 46.0 * (dyy - 183);
      } else if (dyy < 275) {
        return c + (b - c) / 46.0 * (dyy - 229);
      } else {
        return b + (a - b) / 91.0 * (dyy - 275);
      }
    }

    return CelestialTimeUtils.dateByAddingSeconds(
        sunset, (adjustment() * 60.0).round());
  }

  /// Calculate the number of days since the solstice for a given day of the year and latitude.
  ///
  /// This method calculates the number of days since the nearest solstice (winter or summer)
  /// for a given day of the year and latitude. The calculation takes into account whether the
  /// latitude is in the northern or southern hemisphere.
  ///
  /// - Parameters:
  ///   - dayOfYear: The day of the year (1-365) for which to calculate the days since the solstice.
  ///   - year: The year of the observation.
  ///   - latitude: The latitude of the observer's location in degrees.
  /// - Returns: The number of days since the nearest solstice.
  static int daysSinceSolstice(int dayOfYear, int year, double latitude) {
    int daysSinceSolstice = 0;
    int northernOffset = 10;
    int southernOffset = CelestialMath.isLeapYear(year) ? 173 : 172;
    int daysInYear = CelestialMath.isLeapYear(year) ? 366 : 365;

    if (latitude >= 0) {
      daysSinceSolstice = dayOfYear + northernOffset;
      if (daysSinceSolstice >= daysInYear) {
        daysSinceSolstice = daysSinceSolstice - daysInYear;
      }
    } else {
      daysSinceSolstice = dayOfYear - southernOffset;
      if (daysSinceSolstice < 0) {
        daysSinceSolstice = daysSinceSolstice + daysInYear;
      }
    }

    return daysSinceSolstice;
  }
}
