import 'package:flutter/cupertino.dart';

import '../utils/weather_color.dart';

TextStyle textStyle({required double size}) {
  return TextStyle(
    color: WeatherColor.white,
    fontSize: size,
    fontWeight: FontWeight.w600,
  );
}