# prayers_times

![Flutter Platform](https://img.shields.io/badge/platform-flutter-yellow)
[![pub package](https://img.shields.io/pub/v/prayers_times.svg)](https://pub.dev/packages/prayers_times)

`prayers_times` is a Flutter package that provides utilities and calculations for Islamic prayer times, celestial insights, and more.

## Features

- Calculate accurate Islamic prayer times based on various calculation methods.
- Determine Qibla direction based on geographical coordinates.
- Calculate middle of the night and last third of the night times.
- Conversion utilities for different Islamic time formats.

## Installation

Add `prayers_times` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  prayers_times: <latest_version>
```

## Usage

Import the package in your Dart file:

```dart
import 'package:prayers_times/prayers_times.dart';
```

### Calculate Prayer Times

```dart
// Definitions
Coordinates coordinates = Coordinates(21.1959, 72.7933);

// Parameters
PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
params.madhab = PrayerMadhab.hanafi;

// Calculate prayer times
PrayerTimes prayerTimes = PrayerTimes(
  coordinates: coordinates,
  calculationParameters: params,
  precision: true,
  locationName: 'Asia/Kolkata',
);
```

#### Print Prayer Times

```dart
print('Fajr Start Time:- ${prayerTimes.fajrStartTime!}');
print('fajrEndTime:- ${prayerTimes.fajrEndTime!}');
print('sunriseTime:- ${prayerTimes.sunrise!}');
print('dhuhrStartTime:- ${prayerTimes.dhuhrStartTime!}');
print('dhuhrEndTime:- ${prayerTimes.dhuhrEndTime!}');
print('asrStartTime:- ${prayerTimes.asrStartTime!}');
print('asrEndTime:- ${prayerTimes.asrEndTime!}');
print('maghribStartTime:- ${prayerTimes.maghribStartTime!}');
print('maghribEndTime:- ${prayerTimes.maghribEndTime!}');
print('ishaStartTime:- ${prayerTimes.ishaStartTime!}');
print('ishaEndTime:- ${prayerTimes.ishaEndTime!}');
print('tahajjudEndTime:- ${prayerTimes.tahajjudEndTime!}');
```

#### Convenience Utilities

```dart
// Convenience Utilities
String current = prayerTimes.currentPrayer();
String next = prayerTimes.nextPrayer();
print('Current Prayer: $current ${prayerTimes.timeForPrayer(current)}');
print('Next Prayer: $next ${prayerTimes.timeForPrayer(next)}');
```

### Sunnah Times

```dart
// Sunnah Times
SunnahInsights sunnahInsights = SunnahInsights(prayerTimes);
print('Middle of the Night: ${sunnahInsights.middleOfTheNight}');
print('Last Third of the Night: ${sunnahInsights.lastThirdOfTheNight}');
```

### Qibla Direction

```dart
// Qibla Direction
print('Qibla Direction: ${Qibla.qibla(coordinates)}');
```

## Customization

The package offers customization options for various properties and calculations. Refer to the documentation for detailed information on customization options.

## Documentation

For detailed usage instructions and API documentation, please refer to the [documentation](https://your-package-docs-link-here).

## Changelog

See the [CHANGELOG](https://github.com/your-username/prayers_times/blob/main/CHANGELOG.md) for a history of changes in the package.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/your-username/prayers_times/blob/main/LICENSE) file for details.

## Contributing

Contributions to the `prayers_times` package are welcome! Please read the [contribution guidelines](CONTRIBUTING.md) before submitting a pull request.

---

Feel free to explore the features of the `prayers_times` package and customize it to suit your needs. If you have any questions or feedback, don't hesitate to reach out. Happy coding!
