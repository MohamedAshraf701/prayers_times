// ignore_for_file: avoid_print

import 'package:prayers_times/prayers_times.dart';

main() {
  // Definitions
  Coordinates coordinates = Coordinates(21.1959, 72.7933);
  // Parameters
  PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
  params.madhab = PrayerMadhab.hanafi;
  PrayerTimes prayerTimes = PrayerTimes(coordinates: coordinates, calculationParameters: params, precision: true, locationName: 'Asia/Kolkata');

  // Prayer times
  print('\n***** Prayer Times');
  print('fajrStartTime:\t${prayerTimes.fajrStartTime!}');
  print('fajrEndTime:\t${prayerTimes.fajrEndTime!}');
  print('sunriseTime:\t${prayerTimes.sunrise!}');
  print('dhuhrStartTime:\t${prayerTimes.dhuhrStartTime!}');
  print('dhuhrEndTime:\t${prayerTimes.dhuhrEndTime!}');
  print('asrStartTime:\t${prayerTimes.asrStartTime!}');
  print('asrEndTime:\t${prayerTimes.asrEndTime!}');
  print('maghribStartTime:\t${prayerTimes.maghribStartTime!}');
  print('maghribEndTime:\t${prayerTimes.maghribEndTime!}');
  print('ishaStartTime:\t${prayerTimes.ishaStartTime!}');
  print('ishaEndTime:\t${prayerTimes.ishaEndTime!}');

  print('tahajjudEndTime:\t${prayerTimes.tahajjudEndTime!}');

  // Convenience Utilities
  String current = prayerTimes.currentPrayer(); // date: date
  String next = prayerTimes.nextPrayer();
  print('\n***** Convenience Utilities');
  print('current:\t$current\t${prayerTimes.timeForPrayer(current)}');
  print('next:   \t$next\t${prayerTimes.timeForPrayer(next)}');
  // Sunnah Times
  SunnahInsights sunnahInsights = SunnahInsights(prayerTimes);
  print('\n***** Sunnah Times');
  print('middleOfTheNight:  \t${sunnahInsights.middleOfTheNight}');
  print('lastThirdOfTheNight:  \t${sunnahInsights.lastThirdOfTheNight}');

  // Qibla Direction
  print('\n***** Qibla Direction');
  print('qibla:  \t${Qibla.qibla(coordinates)}');
}
