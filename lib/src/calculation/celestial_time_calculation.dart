/// The `CelestialTimeUtils` class provides various date and time calculations related to celestial phenomena.
///
/// This utility class contains static methods that allow you to perform calculations for date and time adjustments,
/// rounding, and day of the year calculations.
///
/// The calculations in this class are designed to support celestial calculations and are based on established algorithms.
/// Please refer to authoritative sources for detailed explanations and references for the calculations.
class CelestialTimeUtils {
  /// Adds a specified number of days to the given date and returns the resulting date.
  ///
  /// - Parameters:
  ///   - date: The initial date.
  ///   - days: The number of days to add.
  /// - Returns: The resulting date after adding the specified number of days.
  static DateTime dateByAddingDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// Adds a specified number of minutes to the given date and returns the resulting date.
  ///
  /// - Parameters:
  ///   - date: The initial date.
  ///   - minutes: The number of minutes to add.
  /// - Returns: The resulting date after adding the specified number of minutes.
  static DateTime dateByAddingMinutes(DateTime date, double minutes) {
    return dateByAddingSeconds(date, minutes.toInt() * 60);
  }

  /// Adds a specified number of seconds to the given date and returns the resulting date.
  ///
  /// - Parameters:
  ///   - date: The initial date.
  ///   - seconds: The number of seconds to add.
  /// - Returns: The resulting date after adding the specified number of seconds.
  static DateTime dateByAddingSeconds(DateTime date, int seconds) {
    return date.add(Duration(seconds: seconds));
  }

  /// Rounds the given date to the nearest minute and returns the resulting date.
  ///
  /// - Parameters:
  ///   - date: The date to be rounded.
  ///   - precision: If true, the rounded date will have minute precision; if false, the original date will be returned.
  /// - Returns: The rounded date.
  static DateTime roundedMinute(DateTime date, {bool precision = true}) {
    int seconds = date.toUtc().second % 60;
    int offset = seconds >= 30 ? 60 - seconds : -1 * seconds;
    if (precision) return date;

    return dateByAddingSeconds(date, offset);
  }

  /// Calculates the day of the year for the given date.
  ///
  /// - Parameter date: The date for which to calculate the day of the year.
  /// - Returns: The day of the year (1-366).
  static int dayOfYear(DateTime date) {
    Duration diff = date.difference(DateTime(date.year, 1, 1, 0, 0));
    int returnedDayOfYear = diff.inDays + 1; // 1st Jan should be day 1
    return returnedDayOfYear;
  }
}
