# prayers_times

![Flutter Platform](https://img.shields.io/badge/platform-flutter-yellow)
[![pub package](https://img.shields.io/pub/v/prayers_times.svg)](https://pub.dev/packages/prayers_times)

Prayers Times is a Flutter package that provides utilities for calculating and displaying Islamic prayer times, as well as related insights like Qibla direction. It's a comprehensive solution for handling prayer timings in your Flutter applications.

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
To calculate and display prayer times for a specific location, follow these steps:

1. Define the geographical coordinates for the location.
2. Specify the calculation parameters for prayer times, such as the calculation method and madhab.
3. Create a `PrayerTimes` instance using the provided coordinates and parameters.
4. Use the provided methods to access various prayer times and convenience utilities.

```dart
// Define the geographical coordinates for the location
Coordinates coordinates = Coordinates(21.1959, 72.7933);

// Specify the calculation parameters for prayer times
PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
params.madhab = PrayerMadhab.hanafi;

// Create a PrayerTimes instance for the specified location
PrayerTimes prayerTimes = PrayerTimes(
  coordinates: coordinates,
  calculationParameters: params,
  precision: true,
  locationName: 'Asia/Kolkata',
);
```

### Prayer Times
Display prayer times and convenience utilities as needed

```dart
print('Fajr Start Time:\t${prayerTimes.fajrStartTime!}');
print('Fajr End Time:\t${prayerTimes.fajrEndTime!}');
print('Sunrise Time:\t${prayerTimes.sunrise!}');
print('Dhuhr Start Time:\t${prayerTimes.dhuhrStartTime!}');
print('Dhuhr End Time:\t${prayerTimes.dhuhrEndTime!}');
print('Asr Start Time:\t${prayerTimes.asrStartTime!}');
print('Asr End Time:\t${prayerTimes.asrEndTime!}');
print('Maghrib Start Time:\t${prayerTimes.maghribStartTime!}');
print('Maghrib End Time:\t${prayerTimes.maghribEndTime!}');
print('Isha Start Time:\t${prayerTimes.ishaStartTime!}');
print('Isha End Time:\t${prayerTimes.ishaEndTime!}');
print('Tahajjud End Time:\t${prayerTimes.tahajjudEndTime!}');
```

### Convenience Utilities
The `PrayerTimes` instance provides convenience utilities to determine the current and next prayer times, making it easy to display relevant information to users.

```dart
// Convenience Utilities
String current = prayerTimes.currentPrayer();
String next = prayerTimes.nextPrayer();
print('Current Prayer: $current ${prayerTimes.timeForPrayer(current)}');
print('Next Prayer: $next ${prayerTimes.timeForPrayer(next)}');
```

### Sunnah Times
Utilize the `SunnahInsights` class to calculate and display Sunnah times, such as the middle of the night and the last third of the night.

```dart
// Sunnah Times
SunnahInsights sunnahInsights = SunnahInsights(prayerTimes);
print('Middle of the Night: ${sunnahInsights.middleOfTheNight}');
print('Last Third of the Night: ${sunnahInsights.lastThirdOfTheNight}');
```

### Qibla Direction
Use the `Qibla` class to calculate and display the Qibla direction in degrees based on the provided geographical coordinates.

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
