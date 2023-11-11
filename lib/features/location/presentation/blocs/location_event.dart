part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent([List properties = const <dynamic>[]]);
}

class GetLatLongEvent extends LocationEvent {
  String cityName;

  GetLatLongEvent(this.cityName) : super([]);

  @override
  List<Object?> get props => [];
}
