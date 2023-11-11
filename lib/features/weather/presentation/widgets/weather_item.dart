
import 'package:flutter/material.dart';
import 'package:weather_app/core/helper/string_helper.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    Key? key,
    required this.value, required this.text, required this.unit, required this.imageUrl,
    this.isTemp = false,
  }) : super(key: key);

  final int value;
  final String text;
  final String unit;
  final String imageUrl;
  final bool isTemp;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 90,
          child: Column(
            children: [
              Text(text, style: const TextStyle(
                color: Colors.black54,
              ),),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  color: Color(0xffE0E8FB),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Image.asset(imageUrl),
              ),
              const SizedBox(
                height: 8,
              ),
             isTemp? Text(StringHelper.convertTemp(value) + unit, style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),):Text(value.toString() + unit, style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}