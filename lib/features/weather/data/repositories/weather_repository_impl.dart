import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/lat_long.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasource/weather_remote_data_source.dart';
import '../models/current_weather_model.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CurrentWeatherModel>> getWeather(
      LatLong latLong) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await weatherRemoteDataSource.getWeather(latLong);

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
