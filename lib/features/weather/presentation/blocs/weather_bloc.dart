import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constant/constant.dart';
import 'package:weather_app/core/utils/lat_long.dart';
import 'package:weather_app/features/weather/data/models/current_weather_model.dart';

import '../../../../core/usecase/weather_usecase/weather_param.dart';

import '../../domain/usecase/get_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherState get initialState => Empty();

  WeatherBloc({
    required this.getWeather,
  }) : super(Empty()) {
    on<WeatherEvent>((event, emit) {});
    on<GetWeatherForLatLong>((event, emit) async {
       if(event.isLoading){
            emit(Loading());
       } 
      final result = await getWeather(
        WeatherParams(
          latLong: event.latLong,
        ),
      );
      result.fold((failure) {
        emit(const Error(message: Constant.localFailureMessage));
      }, (weather) {
        emit(Loaded(weather: weather));
      });
    });
  }
}
