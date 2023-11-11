import 'package:dartz/dartz.dart';
import 'package:weather_app/features/location/data/models/city_response.dart';
import 'package:weather_app/features/location/domain/repositories/city_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/weather_usecase/weather_usecase.dart';

class GetLatLong implements WeatherUseCase<List<CityInfoResponse>, String> {
  final CityRepository repository;

  GetLatLong(this.repository);
  @override
  Future<Either<Failure, List<CityInfoResponse>>> call(String cityName) async {
    return await repository.getLatLong(cityName);
  }
}
