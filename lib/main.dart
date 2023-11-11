import 'package:flutter/material.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}
