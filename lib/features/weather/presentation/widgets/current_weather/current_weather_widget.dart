import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/data/models/current_weather_model.dart';

import '../../../../../core/utils/size_config.dart';
import '../../../domain/entities/current_weather/current_weather.dart';
import '../../../domain/entities/current_weather/current_weather_data.dart';
import 'current_extra_data.dart';
import 'current_main_data.dart';

class CurrentWeatherWidget extends StatelessWidget {
  CurrentWeatherModel currentWeather;
  CurrentWeatherWidget(this.currentWeather, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: getProportionateScreenHeight(550),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(getProportionateScreenWidth(50)),
              bottomRight: Radius.circular(getProportionateScreenWidth(50)))),
      child: Column(
        children: [
          CurrentMainData(currentWeather),
          const Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          CurrentExtraData(currentWeather),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
        ],
      ),
    );
  }
}
