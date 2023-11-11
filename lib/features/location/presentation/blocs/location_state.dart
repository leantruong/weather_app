part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class Empty extends LocationState {}

class Loading extends LocationState {}

class Loaded extends LocationState {
  final List<CityModel> city;
  final String? cityName;
  final LatLong? latLong;
  

  const Loaded({required this.city, this.cityName, this.latLong});

  @override
  List<Object> get props => [city];
}

class Error extends LocationState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
