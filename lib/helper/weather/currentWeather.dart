import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_api/helper/AppBar.dart';
import 'dart:convert';
import 'package:news_app_api/helper/weather/weather.dart';

class CurrentWeatherPage extends StatefulWidget {
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  Weather _weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.grey,
        appBar: MyAppBar(),
        body: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot != null) {
                this._weather = snapshot.data;
                if (this._weather == null) {
                  return Text("Error getting weather :(");
                } else {
                  return weatherBox(_weather);
                }
              } else {
                return CircularProgressIndicator();
              }
            },
            future: getCurrentWeather(),
          ),
        ));
  }
}

Widget weatherBox(Weather _weather) {
  return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    // Container(
    //   child: Text(
    //     '${_weather.country}',
    //     style: TextStyle(
    //         fontWeight: FontWeight.bold, fontSize: 65, color: Colors.white),
    //   ),
    // ),
    Container(
        margin: const EdgeInsets.all(10.0),
        child: Text(
          "${_weather.temp}°C",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 55, color: Colors.black),
        )),
    Container(
        //margin: const EdgeInsets.all(5.0),
        child: Text("Feels:${_weather.feelsLike}°C")),
    Container(
        //margin: const EdgeInsets.all(5.0),
        child: Text("there are ${_weather.description}")),
    Container(
      child: Text("Humidity:${_weather.humidity}"),
    ),

    /*
    Container(
        margin: const EdgeInsets.all(5.0),
        child: Text("H:${_weather.high}°C L:${_weather.low}°C")),*/
  ]);
}

Future getCurrentWeather() async {
  Weather weather;
  String location = "ankara";
  String apiKey = "354b3ecbd6751e33e9efccfbfd2eaf13";
  var url =
      //"https://api.openweathermap.org/data/2.0/onecall?lat=33.44&lon=-94.04&exclude=hourly,daily&appid={354b3ecbd6751e33e9efccfbfd2eaf13}";
      "https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKey";
  final response = await http.get(url);
  print(response.body);

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  }

  return weather;
}
