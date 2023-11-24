# prayers_times

![Flutter Platform](https://img.shields.io/badge/platform-flutter-yellow)
[![pub package](https://img.shields.io/pub/v/prayers_times.svg)](https://pub.dev/packages/prayers_times)

## بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ 

Prayers Times is a Flutter package that provides utilities for calculating and displaying Islamic prayer times (Namaz times), as well as related insights like Qibla direction. It's a comprehensive solution for handling prayer timings in your Flutter applications.

## Features

- Calculate accurate Islamic prayer times (Namaz times) based on various calculation methods.
- Determine Qibla direction based on geographical coordinates.
- Calculate middle of the night and last third of the night times.
- Conversion utilities for different Islamic time formats.

# Namaz_times

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

## Calculate Prayer Times
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

## Prayer Times With Specific Date

To calculate prayer times for a specific date, you can create an instance of the `PrayerTimes` class and provide a custom `DateTime` object using the `dateTime` parameter.

```dart
PrayerTimes prayerTimes = PrayerTimes(
  coordinates: Coordinates(latitude, longitude),
  calculationParameters: CalculationMethod.karachi(),
  locationName: 'Your Location',
  dateTime: DateTime(2023, 8, 15), // Specify the desired date
);
```

## Prayer Times
Display prayer times or Calculate accurate Islamic prayer times (Namaz times) based on various calculation methods.

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
```

## Tahajjud & Sehri End Time

```dart
print('Isha End Time:\t${prayerTimes.ishaEndTime!}');
print('Tahajjud End Time:\t${prayerTimes.tahajjudEndTime!}');
```

## Convenience Utilities
The `PrayerTimes` instance provides convenience utilities to determine the current and next prayer times, making it easy to display relevant information to users.

```dart
// Convenience Utilities
String current = prayerTimes.currentPrayer();
String next = prayerTimes.nextPrayer();
print('Current Prayer: $current ${prayerTimes.timeForPrayer(current)}');
print('Next Prayer: $next ${prayerTimes.timeForPrayer(next)}');
```

## Sunnah Times
Utilize the `SunnahInsights` class to calculate and display Sunnah times, such as the middle of the night and the last third of the night.

```dart
// Sunnah Times
SunnahInsights sunnahInsights = SunnahInsights(prayerTimes);
print('Middle of the Night: ${sunnahInsights.middleOfTheNight}');
print('Last Third of the Night: ${sunnahInsights.lastThirdOfTheNight}');
```

## Qibla and Madina Directions

The `Qibla` class provides methods to calculate the Qibla direction (direction of the Kaaba in Makkah) and the madina direction (direction of Al-Masjid an-Nabawi) from a given location. These calculations are based on the geographic coordinates (latitude and longitude) of the specified location and the coordinates of Makkah and Al-Masjid an-Nabawi. The calculations use spherical trigonometry to determine the angle between the specified location and the respective directions.

## Calculate Qibla Direction

The `qibla` method calculates the Qibla direction based on the geographic coordinates of the specified location and the coordinates of Makkah (the Holy Kaaba). The result is the clockwise angle from the North direction.

```dart
double qiblaDirection = Qibla.qibla(coordinates);
```

## Calculate Madina Direction

The `madina` method calculates the madina direction based on the geographic coordinates of the specified location and the coordinates of Al-Masjid an-Nabawi. The result is the clockwise angle from the North direction.

```dart
double madinaDirection = Qibla.madina(coordinates);
```

## Customization

The package offers customization options for various properties and calculations. Refer to the documentation for detailed information on customization options.

---

## Documentation

For detailed usage instructions and API documentation, please refer to the [documentation](https://pub.dev/documentation/prayers_times/latest/).

---

## Changelog

See the [CHANGELOG](https://github.com/MohamedAshraf701/prayers_times/blob/main/CHANGELOG.md) for a history of changes in the package.

---

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/MohamedAshraf701/prayers_times/blob/main/LICENSE) file for details.

---

## Get in touch

If you have any questions, feel free to reach out:

- Email: ashrafchauhan567@gmail.com
- GitHub: [@MohamedAshraf701](https://github.com/MohamedAshraf701)

---

## Contributing

Contributions to the `prayers_times` package are welcome! Please read the [contribution guidelines](CONTRIBUTING.md) before submitting a pull request.

---

# Support
<p><a href="https://www.buymeacoffee.com/ashraf704"> <img align="left" src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="50" width="210" alt="ashraf704" /></a></p><br><br>

---

Feel free to explore the features of the `prayers_times` package and customize it to suit your needs. If you have any questions or feedback, don't hesitate to reach out. Happy coding!