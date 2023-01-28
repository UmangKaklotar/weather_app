import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/utils/api_string.dart';


class HttpService {
  Future getWeatherResponse() async {
    Response res = await get(Uri.parse(ApiUtils.BASE_URL + ApiUtils.city + ApiUtils.appId + ApiUtils.key));
    if(res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(data);
      return data;
    } else {
      print(res.statusCode);
    }
  }
}