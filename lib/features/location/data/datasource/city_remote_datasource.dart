import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/constant/constant.dart';
import 'package:weather_app/features/location/data/models/city_response.dart';

import '../../../../core/error/exceptions.dart';

abstract class CityRemoteDataSource {
  Future<List<CityInfoResponse>> getCity(String cityName);
}

class CityRemoteDataSourceImpl implements CityRemoteDataSource {
  final http.Client client;

  CityRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CityInfoResponse>> getCity(String cityName) async {
    final response = await client.get(
      Uri.parse(
          "https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=${Constant.apiKey}"),
      headers: {'content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final dataRaw = json.decode(response.body) as List;
      return dataRaw.map((e) => CityInfoResponse.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
