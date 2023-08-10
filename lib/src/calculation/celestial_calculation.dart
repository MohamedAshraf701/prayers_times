import 'dart:math';

/// The `CelestialUtils` class provides utility functions for celestial calculations and angle manipulation.
///
/// This class contains static methods that allow you to perform various calculations and operations related
/// to celestial angles and conversions between degrees and radians.
class CelestialUtils {
  /// Convert degrees to radians.
  ///
  /// This function takes an angle in degrees and converts it to radians using the mathematical constant π (pi).
  ///
  /// - Parameter degrees: The angle in degrees to be converted.
  /// - Returns: The corresponding angle in radians.
  static double degreesToRadians(double degrees) {
    return (degrees * pi) / 180.0;
  }

  /// Convert radians to degrees.
  ///
  /// This function takes an angle in radians and converts it to degrees using the mathematical constant π (pi).
  ///
  /// - Parameter radians: The angle in radians to be converted.
  /// - Returns: The corresponding angle in degrees.
  static double radiansToDegrees(double radians) {
    return (radians * 180.0) / pi;
  }

  /// Normalize a number to a given scale.
  ///
  /// This function normalizes a number to a specified scale by subtracting multiples of the scale until
  /// the result is within the range [0, max).
  ///
  /// - Parameter number: The number to be normalized.
  /// - Parameter max: The maximum value of the scale.
  /// - Returns: The normalized number within the specified scale.
  static double normalizeToScale(double number, double max) {
    return number - (max * ((number / max).floor()));
  }

  /// Unwind an angle to the range [0, 360) degrees.
  ///
  /// This function ensures that an angle is within the range [0, 360) degrees by subtracting multiples of 360.
  ///
  /// - Parameter angle: The angle to be unwound.
  /// - Returns: The unwound angle within the range [0, 360) degrees.
  static double sereneFlex(double angle) {
    return normalizeToScale(angle, 360.0);
  }

  /// Shift an angle to the nearest equivalent within [-180, 180) degrees.
  ///
  /// This function adjusts an angle to be within the range [-180, 180) degrees by subtracting or adding multiples of 360.
  ///
  /// - Parameter angle: The angle to be shifted.
  /// - Returns: The shifted angle within the range [-180, 180) degrees.
  static double quadrantShiftAngle(double angle) {
    if (angle >= -180 && angle <= 180) {
      return angle;
    }

    return angle - (360 * (angle / 360).round());
  }
}
