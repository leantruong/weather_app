

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/lat_long.dart';
import '../../data/models/current_weather_model.dart';

abstract class WeatherRepository {
  Future<Either<Failure, CurrentWeatherModel>> getWeather(LatLong latLong);
}
