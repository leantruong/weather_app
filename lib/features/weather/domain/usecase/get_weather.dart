import 'package:dartz/dartz.dart';

import '../../../../core/usecase/weather_usecase/weather_param.dart';
import '../../../../core/usecase/weather_usecase/weather_usecase.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/current_weather_model.dart';
import '../repositories/weather_repository.dart';

class GetWeather implements WeatherUseCase<CurrentWeatherModel, WeatherParams> {
  final WeatherRepository repository;

  GetWeather(this.repository);
  @override
  Future<Either<Failure, CurrentWeatherModel>> call(WeatherParams params) async {
    return await repository.getWeather(params.latLong);
  }
}