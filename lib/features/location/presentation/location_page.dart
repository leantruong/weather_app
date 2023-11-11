import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/core/styles/app_color.dart';
import 'package:weather_app/core/utils/lat_long.dart';
import 'package:weather_app/features/location/data/models/city_model.dart';
import 'package:weather_app/features/location/presentation/blocs/location_bloc.dart';
import 'package:weather_app/features/location/presentation/widgets/search_select_child_widget.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';
import 'package:weather_app/injection_container.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late LocationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = sl.get<LocationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.text,
          title: const Text('Location'),
        ),
        body: Column(children: [
          Expanded(
            child: SearchSelectionChild(
              CityModel.citiesList,
              title: 'city',
              showSearchBox: true,
              onChanged: (value) {},
              onSelected: (CityModel model) {
                bloc.add(GetLatLongEvent(model.city));
              },
            ),
          ),
          BlocConsumer<LocationBloc, LocationState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: state is Loaded
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherPage(
                                location: (state).cityName ?? '',
                                latLong: (state).latLong ??
                                    const LatLong(lat: 0, long: 0),
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: state is Loaded || state is Loading
                          ? AppColors.bgCard
                          : Colors.grey,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: state is Loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          )
                        : const Center(
                            child: Text(
                              'Show weather',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                  ),
                ),
              );
            },
            listener: (BuildContext context, LocationState state) {
              if (state is Error) {
                Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }
}
