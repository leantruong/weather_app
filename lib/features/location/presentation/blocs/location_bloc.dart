import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/lat_long.dart';

import '../../data/models/city_model.dart';
import '../../domain/usecase/get_lat_long.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLatLong getLatLong;

  LocationState get initialState => Empty();

  LocationBloc({
    required this.getLatLong,
  }) : super(Empty()) {
    on<GetLatLongEvent>((event, emit) async {
      emit(Loading());
      final result = await getLatLong(event.cityName);

      result.fold((failure) {
        emit(const Error(message: 'Unable to get lat long'));
      }, (weather) {
        emit(Loaded(
            city: [],
            cityName: event.cityName,
            latLong: LatLong(lat: weather.first.lat, long: weather.first.lon)));
      });
    });
  }
}
