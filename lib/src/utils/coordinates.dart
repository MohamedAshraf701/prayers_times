/// The `Coordinates` class represents geographical coordinates on the Earth's surface.
///
/// This class provides a convenient way to store latitude and longitude values.
class Coordinates {
  /// The latitude value in degrees.
  late double latitude;

  /// The longitude value in degrees.
  late double longitude;

  /// Creates a new `Coordinates` object with the specified latitude and longitude.
  ///
  /// - Parameters:
  ///   - latitude: The latitude value in degrees.
  ///   - longitude: The longitude value in degrees.
  Coordinates(this.latitude, this.longitude);
}
