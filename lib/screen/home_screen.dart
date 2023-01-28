import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/http_service.dart';
import 'package:weather_app/utils/api_string.dart';
import 'package:weather_app/utils/weather_color.dart';
import 'package:weather_app/widget/weather_widget.dart';

import '../utils/weather_int.dart';
import '../widget/weather_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime now = DateTime.now();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Image.network(ApiUtils.bgImage,
                fit: BoxFit.cover,
                height: height,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Weather App",
                    style: textStyle(size: 22),
                  ),
                  const SizedBox(height: 15),
                  CupertinoSearchTextField(
                    controller: textEditingController,
                    backgroundColor: WeatherColor.white,
                    onSuffixTap: (){
                      setState(() {
                        ApiUtils.city = "Surat";
                        textEditingController.clear();
                      });
                    },
                    onChanged: (val){
                      setState(() {
                        ApiUtils.city = val;
                        HttpService().getWeatherResponse();
                        print(ApiUtils.city);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: FutureBuilder(
                      future: HttpService().getWeatherResponse(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          WeatherInt.temp = snapshot.data['main']['temp'] - 273;
                          WeatherInt.press = snapshot.data['main']['pressure'];
                          WeatherInt.hum = snapshot.data['main']['humidity'];
                          WeatherInt.lon = snapshot.data['coord']['lon'];
                          WeatherInt.lat = snapshot.data['coord']['lat'];
                          WeatherInt.speed = snapshot.data['wind']['speed'];
                          WeatherInt.visibility = snapshot.data['visibility'];
                          ApiUtils.city = snapshot.data['name'];
                          ApiUtils.des = snapshot.data['weather'][0]['description'];
                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Text(ApiUtils.city,
                                  style: textStyle(size: 28),
                                ),
                                Text(DateFormat.yMMMMd().format(now),
                                  style: textStyle(size: 18),
                                ),
                                Container(
                                  height: 200,
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  margin: const EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(
                                    color: WeatherColor.black38,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Lat\n${WeatherInt.lat}", textAlign: TextAlign.center, style: textStyle(size: 18),),
                                      Icon(CupertinoIcons.cloud_sun_bolt_fill, color: WeatherColor.white, size: 130,),
                                      Text("Lon\n${WeatherInt.lon}", textAlign: TextAlign.center, style: textStyle(size: 18),),
                                    ],
                                  ),
                                ),
                                Text("${WeatherInt.temp.toInt()} °C",
                                  style: textStyle(size: 40),
                                ),
                                Text(ApiUtils.des,
                                  style: textStyle(size: 25),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    children: [
                                      containerWidget(title: "Speed", ans: "${WeatherInt.speed}"),
                                      const SizedBox(width: 20,),
                                      containerWidget(title: "Pressure", ans: "${WeatherInt.press}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    containerWidget(title: "Humbidity", ans: "${WeatherInt.hum}"),
                                    const SizedBox(width: 20,),
                                    containerWidget(title: "Visibility", ans: "${WeatherInt.visibility}"),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator(),);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
