import 'package:flutter/cupertino.dart';
import 'package:weather_app/widget/weather_style.dart';

import '../utils/weather_color.dart';

Widget containerWidget({required String title, required String ans}) {
  return Expanded(
    child: Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        color: WeatherColor.black38,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title,
            textAlign: TextAlign.center,
            style: textStyle(size: 23),
          ),
          Text(ans,
            textAlign: TextAlign.center,
            style: textStyle(size: 25),
          ),
        ],
      ),
    ),
  );
}