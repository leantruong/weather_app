import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/constant/constant.dart';
import 'package:weather_app/features/weather/data/models/current_weather_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/lat_long.dart';

abstract class WeatherRemoteDataSource {
  Future<CurrentWeatherModel> getWeather(LatLong latLong);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<CurrentWeatherModel> getWeather(LatLong latLong) async {
    
    final response = await client.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${latLong.lat}&lon=${latLong.long}&appid=${Constant.apiKey}"),
      headers: {'content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
