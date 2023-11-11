part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent([List properties = const <dynamic>[]]);
}

class GetWeatherForLatLong extends WeatherEvent {
  final LatLong latLong;
  bool isLoading;
  GetWeatherForLatLong(this.latLong, {this.isLoading = true}) : super([]);

  @override
  List<Object?> get props => [];
}
