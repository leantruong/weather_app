import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/lat_long.dart';
import '../../data/models/city_response.dart';

abstract class CityRepository {
  Future<Either<Failure, List<CityInfoResponse>>> getLatLong(String cityName);
}
