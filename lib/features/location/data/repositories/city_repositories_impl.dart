import 'package:dartz/dartz.dart';
import 'package:weather_app/features/location/data/datasource/city_remote_datasource.dart';
import 'package:weather_app/features/location/data/models/city_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/city_repository.dart';

class CityRepositoryImpl extends CityRepository {
  final CityRemoteDataSource cityRemoteDataSource;
  final NetworkInfo networkInfo;

  CityRepositoryImpl({
    required this.cityRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CityInfoResponse>>> getLatLong(
      String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await cityRemoteDataSource.getCity(cityName);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
