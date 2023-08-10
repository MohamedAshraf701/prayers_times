/// The `HighLatitudeRule` class provides predefined rules for handling high latitudes
/// when calculating Islamic prayer times.
///
/// This class defines constants representing different strategies for determining
/// the portions of the night used for calculating prayer times in high-latitude regions.
class HighLatitudeRule {
  /// Middle of the night rule, where Fajr and Isha are set to half the duration of the night.
  static const String middleOfTheNight = 'middleofthenight';

  /// Seventh of the night rule, where Fajr and Isha are set to one-seventh of the duration of the night.
  static const String seventhOfTheNight = 'seventhofthenight';

  /// Twilight angle rule, where Fajr and Isha are determined based on specified twilight angles.
  static const String twilightAngle = 'twilightangle';
}

/// The `PrayerMadhab` class provides predefined madhabs (schools of thought) for Islamic prayer time calculations.
///
/// This class defines constants representing different madhabs that can be used for adjusting prayer times.
class PrayerMadhab {
  /// The Shafi madhab for Islamic prayer time calculations.
  static const String shafi = 'shafi';

  /// The Hanafi madhab for Islamic prayer time calculations.
  static const String hanafi = 'hanafi';
}

/// The `PrayerTimeCalculator` class provides utilities for calculating shadow length based on a specified madhab.
///
/// This class contains methods for determining the shadow length used for calculating Asr prayer time
/// based on the chosen madhab (school of thought).
class PrayerTimeCalculator {
  /// Calculates the shadow length for Asr prayer time based on the specified madhab.
  ///
  /// The `madhab` parameter should be a valid madhab constant from the `PrayerMadhab` class.
  ///
  /// Returns the shadow length in terms of times the object's height.
  static double shadowLength(String? madhab) {
    const shafi = PrayerMadhab.shafi;
    const hanafi = PrayerMadhab.hanafi;

    switch (madhab) {
      case shafi:
        return 1;
      case hanafi:
        return 2;
      default:
        throw "Invalid Madhab";
    }
  }
}
