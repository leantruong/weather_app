import 'package:equatable/equatable.dart';

import 'current_weather.dart';

class CurrentWeatherData extends Equatable {
  final CurrentWeather data;

  const CurrentWeatherData({required this.data});

  @override
  List<Object?> get props => [data];
}
