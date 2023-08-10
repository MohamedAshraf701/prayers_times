/// A utility class for converting decimal time values into UTC date and time for prayer times.
class PrayerTimeConverter {
  late int hours;
  late int minutes;
  late int seconds;

  /// Creates a [PrayerTimeConverter] instance from a decimal number representing time.
  PrayerTimeConverter(double decimalTime) {
    hours = decimalTime.floor();
    minutes = ((decimalTime - hours) * 60).floor();
    seconds = ((decimalTime - (hours + minutes / 60)) * 60 * 60).floor();
  }

  /// Constructs a [DateTime] object in UTC using the stored time components and provided date information.
  ///
  /// - [year]: The year.
  /// - [month]: The month (1-12).
  /// - [day]: The day of the month (1-31).
  DateTime utcDate(int year, int month, int day) {
    return DateTime.utc(year, month, day, hours, minutes, seconds);
  }
}
