import 'dart:math'; // Import the math library for trigonometric functions

import 'coordinates.dart'; // Import the Coordinates class

/// The `Qibla` class provides a method to calculate the Qibla direction (direction of the Kaaba in Makkah) from a given location.
///
/// The Qibla direction is calculated based on the geographic coordinates (latitude and longitude) of the specified location
/// and the coordinates of Makkah (the Holy Kaaba). The calculation uses spherical trigonometry to determine the angle between
/// the specified location and the direction of the Qibla.
///
/// The calculation results in the direction (in degrees) that a person should face while performing prayers.
/// The value represents the clockwise angle from the North direction.
class Qibla {
  /// Calculates the Qibla direction (direction of the Kaaba) from a given location.
  ///
  /// The Qibla direction is calculated based on the geographic coordinates of the specified location
  /// and the coordinates of Makkah (the Holy Kaaba).
  ///
  /// The calculation utilizes spherical trigonometry to determine the angle between the specified location
  /// and the direction of the Qibla. The result is the clockwise angle from the North direction.
  ///
  /// @param coordinates The geographic coordinates (latitude and longitude) of the location.
  /// @return The Qibla direction in degrees.
  static double qibla(Coordinates coordinates) {
    // Coordinates of Makkah (the Holy Kaaba)
    Coordinates makkah = Coordinates(21.4225241, 39.8261818);

    // Calculate the terms for the spherical trigonometry equation
    double term1 = sin(degreesToRadians(makkah.longitude) - degreesToRadians(coordinates.longitude));
    double term2 = cos(degreesToRadians(coordinates.latitude)) * tan(degreesToRadians(makkah.latitude));
    double term3 = sin(degreesToRadians(coordinates.latitude)) * cos(degreesToRadians(makkah.longitude) - degreesToRadians(coordinates.longitude));

    // Calculate the angle using spherical trigonometry (atan2 function)
    double angle = atan2(term1, term2 - term3);

    // Unwind the angle and convert from radians to degrees
    return sereneFlex(radiansToDegrees(angle));
  }

  /// Calculates the madina direction (direction of the Al-Masjid an-Nabawi) from a given location.
  ///
  /// The madina direction is calculated based on the geographic coordinates of the specified location
  /// and the coordinates of Al-Masjid an-Nabawi.
  ///
  /// The calculation utilizes spherical trigonometry to determine the angle between the specified location
  /// and the direction of the madina. The result is the clockwise angle from the North direction.
  ///
  /// @param coordinates The geographic coordinates (latitude and longitude) of the location.
  /// @return The madina direction in degrees.
  static double madina(Coordinates coordinates) {
    Coordinates madina = Coordinates(24.467035, 39.610947);

    // Calculate the terms for the spherical trigonometry equation
    double term1 = sin(degreesToRadians(madina.longitude) - degreesToRadians(coordinates.longitude));
    double term2 = cos(degreesToRadians(coordinates.latitude)) * tan(degreesToRadians(madina.latitude));
    double term3 = sin(degreesToRadians(coordinates.latitude)) * cos(degreesToRadians(madina.longitude) - degreesToRadians(coordinates.longitude));

    // Calculate the angle using spherical trigonometry (atan2 function)
    double angle = atan2(term1, term2 - term3);

    // Unwind the angle and convert from radians to degrees
    return sereneFlex(radiansToDegrees(angle));
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
