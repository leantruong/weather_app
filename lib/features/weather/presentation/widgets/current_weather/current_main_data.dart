import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/find_icon.dart';

import '../../../../../core/utils/size_config.dart';
import '../../../data/models/current_weather_model.dart';
import '../../../domain/entities/current_weather/current_weather.dart';

class CurrentMainData extends StatelessWidget {
  const CurrentMainData(this.currentWeather, {Key? key}) : super(key: key);
  final CurrentWeatherModel currentWeather;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        Image(
          image: AssetImage(findIcon(currentWeather.weather.first.main??'', true)),
          width: getProportionateScreenWidth(250),
          height: getProportionateScreenHeight(250),
          fit: BoxFit.fill,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Center(
              child: Column(
            children: [
              // text(120, currentWeather..toString()),

              text(25, currentWeather.name),
              // text(18, currentWeather.day),
            ],
          )),
        )
      ],
    );
  }

  Widget text(double height, String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontSize: getProportionateScreenHeight(height),
      ),
    );
  }
}
