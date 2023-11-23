// ignore_for_file: avoid_print

import 'package:prayers_times/prayers_times.dart';

void main() {
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
  final now = DateTime.now();
  DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
  PrayerTimes prayerTimes1 = PrayerTimes(
    coordinates: coordinates,
    calculationParameters: params,
    dateTime: tomorrow,
    precision: true,
    locationName: 'Asia/Kolkata',
  );

  // Display prayer times for the current date
  print('\n***** Prayer Times');
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
  print('Next Day Fajr Time:\t${prayerTimes1.fajrStartTime!}');
  print('Tahajjud End Time:\t${prayerTimes.tahajjudEndTime!}');
  print('Sehri End Time:\t${prayerTimes.sehri!}');

  // Display convenience utilities for prayer times
  String current = prayerTimes.currentPrayer();
  String next = prayerTimes.nextPrayer();
  print('\n***** Convenience Utilities');
  print('Current Prayer:\t$current\t${prayerTimes.timeForPrayer(current)}');
  print('Next Prayer:\t$next\t${prayerTimes.timeForPrayer(next)}');

  // Calculate and display Sunnah times
  SunnahInsights sunnahInsights = SunnahInsights(prayerTimes);
  print('\n***** Sunnah Times');
  print('Middle of the Night:\t${sunnahInsights.middleOfTheNight}');
  print('Last Third of the Night:\t${sunnahInsights.lastThirdOfTheNight}');

  // Determine and display Qibla direction
  print('\n***** Qibla Direction');
  double qiblaDirection = Qibla.qibla(coordinates);
  print('Qibla Direction:\t$qiblaDirection degrees');
}
