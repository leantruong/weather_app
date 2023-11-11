import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_app/features/location/data/datasource/city_remote_datasource.dart';
import 'package:weather_app/features/location/data/repositories/city_repositories_impl.dart';
import 'package:weather_app/features/location/domain/repositories/city_repository.dart';
import 'package:weather_app/features/location/domain/usecase/get_lat_long.dart';
import 'package:weather_app/features/location/presentation/blocs/location_bloc.dart';

import 'core/network/network_info.dart';
import 'features/weather/data/datasource/weather_remote_data_source.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/repositories/weather_repository.dart';
import 'features/weather/domain/usecase/get_weather.dart';
import 'features/weather/presentation/blocs/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => WeatherBloc(
        getWeather: sl(),
      ));
  sl.registerFactory(() => LocationBloc(getLatLong: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetWeather(sl()));
  sl.registerLazySingleton(() => GetLatLong(sl()));
  // Repository

  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(
      cityRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CityRemoteDataSource>(
      () => CityRemoteDataSourceImpl(client: sl()));

  // Core-
  // sl.registerLazySingleton<GetLatLong>(() => GetLatLongImpl());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
