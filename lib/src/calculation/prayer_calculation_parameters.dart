import 'package:prayers_times/src/utils/constant.dart';

/// The `PrayerCalculationParameters` class represents parameters used for calculating Islamic prayer times.
///
/// This class provides a convenient way to store various parameters and adjustments
/// required for calculating prayer times based on different methods and rules.
class PrayerCalculationParameters {
  /// The calculation method name.
  String? method;

  /// The angle for Fajr (pre-dawn) prayer in degrees.
  late double fajrAngle;

  /// The angle for Isha (nightfall) prayer in degrees.
  late double ishaAngle;

  /// The interval between sunset and Isha prayer in minutes.
  double? ishaInterval;

  /// The angle for Maghrib (sunset) prayer in degrees.
  double? maghribAngle;

  /// The chosen madhab (school of thought) for the prayer time calculation.
  String? madhab;

  /// The rule for calculating high latitude prayer times.
  String? highLatitudeRule;

  /// Adjustments for various prayer times.
  late Map<String, double> adjustments;

  /// Method-specific adjustments for various prayer times.
  late Map<String, double> methodAdjustments;

  /// Creates a new `PrayerCalculationParameters` object with the specified parameters.
  ///
  /// - Parameters:
  ///   - methodName: The calculation method name.
  ///   - fajrAngle: The angle for Fajr (pre-dawn) prayer in degrees.
  ///   - ishaAngle: The angle for Isha (nightfall) prayer in degrees.
  ///   - ishaInterval: The interval between sunset and Isha prayer in minutes (optional).
  ///   - maghribAngle: The angle for Maghrib (sunset) prayer in degrees (optional).
  PrayerCalculationParameters(String methodName, this.fajrAngle, this.ishaAngle,
      {double? ishaInterval, this.maghribAngle}) {
    method = methodName;
    this.ishaInterval = ishaInterval ?? 0.0;
    madhab = PrayerMadhab.hanafi;
    highLatitudeRule = HighLatitudeRule.middleOfTheNight;
    adjustments = {
      'fajr': 0,
      'sunrise': 0,
      'dhuhr': 0,
      'asr': 0,
      'maghrib': 0,
      'isha': 0
    };
    methodAdjustments = {
      'fajr': 0,
      'sunrise': 0,
      'dhuhr': 0,
      'asr': 0,
      'maghrib': 0,
      'isha': 0
    };
  }

  /// Determines the portions of the night for Fajr and Isha prayers based on the chosen high latitude rule.
  ///
  /// Returns a map containing the portions of the night allocated for Fajr and Isha prayers.
  Map<String, double> nightPortions() {
    switch (highLatitudeRule) {
      case HighLatitudeRule.middleOfTheNight:
        return {'fajr': 1 / 2, 'isha': 1 / 2};
      case HighLatitudeRule.seventhOfTheNight:
        return {'fajr': 1 / 7, 'isha': 1 / 7};
      case HighLatitudeRule.twilightAngle:
        return {'fajr': fajrAngle / 60, 'isha': ishaAngle / 60};
      default:
        throw ('Invalid high latitude rule found when attempting to compute night portions: $highLatitudeRule');
    }
  }
}
