import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/helper/string_helper.dart';
import 'package:weather_app/core/utils/find_icon.dart';
import 'package:weather_app/core/utils/lat_long.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_item.dart';
import 'package:weather_app/injection_container.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/utils/size_config.dart';
import '../blocs/weather_bloc.dart';
import '../widgets/loading_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key, required this.location, required this.latLong})
      : super(key: key);
  final String location;
  final LatLong latLong;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherBloc bloc;
  String imageUrl = '';
  @override
  void initState() {
    super.initState();
    bloc = sl.get<WeatherBloc>();
    bloc.add(GetWeatherForLatLong(widget.latLong));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[AppColors.bgColor, AppColors.bgCard2, AppColors.text],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey,
                        )),
                    const Text(
                      'Current Weather',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/pin.png',
                      width: 20,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async => bloc.add(GetWeatherForLatLong(widget.latLong)),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is Loading) {
                return const LoadingWidget();
              } else if (state is Error) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is Loaded) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.location,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      Text(
                        StringHelper.convertDateTime(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(.5),
                                offset: const Offset(0, 25),
                                blurRadius: 10,
                                spreadRadius: -12,
                              )
                            ]),
                        child: Stack(
                          children: [
                            UnconstrainedBox(
                              child: SizedBox(
                                width: 150,
                                height: 100,
                                child: Image.asset(
                                  findIcon(
                                      state.weather.weather.first.main ?? '',
                                      true),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              left: 20,
                              child: Text(
                                state.weather.weather.first.main ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      StringHelper.convertTemp(
                                          state.weather.main.temp?.round() ??
                                              0),
                                      style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = linearGradient,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'o',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = linearGradient,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherItem(
                            text: 'Wind Speed',
                            value: state.weather.wind.speed?.toInt() ?? 0,
                            unit: 'km/h',
                            imageUrl: 'assets/images/windspeed.png',
                          ),
                          WeatherItem(
                              text: 'Humidity',
                              value:
                                  state.weather.main.humidity?.toInt() ?? 0,
                              unit: '',
                              imageUrl: 'assets/images/humidity.png'),
                          WeatherItem(
                            text: 'Max Temp',
                            isTemp: true,
                            value:
                                state.weather.main.temp?.round().toInt() ??
                                    0,
                            unit: 'C',
                            imageUrl: 'assets/images/max-temp.png',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
