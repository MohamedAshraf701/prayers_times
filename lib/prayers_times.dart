/// The `prayers_times` library provides a collection of utilities and calculations
/// related to prayer times, celestial calculations, and other Islamic insights.
///
/// The library includes various modules for calculating prayer times, handling celestial calculations,
/// defining prayer calculation methods and parameters, converting prayer times, determining qibla direction,
/// and more.
///
/// The calculations and utilities in this library are based on established algorithms and formulas.
/// Please refer to authoritative sources for detailed explanations and references for the calculations.
library prayers_times;

export 'package:prayers_times/src/calculation/celestial_calculation.dart';
export 'package:prayers_times/src/calculation/celestial_time_calculation.dart';
export 'package:prayers_times/src/calculation/prayer_calculation_method.dart';
export 'package:prayers_times/src/calculation/prayer_calculation_parameters.dart';
export 'package:prayers_times/src/celestial/celestial_map.dart';
export 'package:prayers_times/src/celestial/celestial_math.dart';
export 'package:prayers_times/src/celestial/stellar_moment.dart';
export 'package:prayers_times/src/prayers/prayer_time.dart';
export 'package:prayers_times/src/prayers/prayer_time_converter.dart';
export 'package:prayers_times/src/prayers/prayer_types.dart';
export 'package:prayers_times/src/utils/constant.dart';
export 'package:prayers_times/src/utils/coordinates.dart';
export 'package:prayers_times/src/utils/qibla_direction.dart';
export 'package:prayers_times/src/utils/sunnah_insights.dart';
