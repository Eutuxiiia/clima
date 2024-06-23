import 'package:clima/screens/detailed_weather.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CityCard extends StatelessWidget {
  const CityCard({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.condition,
  });

  const CityCard.loading({
    super.key,
    required this.cityName,
  })  : condition = '',
        temperature = 0;

  final String cityName;
  final double temperature;
  final String condition;

  @override
  Widget build(BuildContext context) {
    WeatherModel weather = WeatherModel.defaultConstructor();

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedWeatherScreen(name: cityName),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            cityName,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${temperature.toInt()}°C',
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(width: 10.0),
              SizedBox(
                width: condition == '' ? 15 : 40,
                height: condition == '' ? 15 : 40,
                child: condition == ''
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : Lottie.asset(
                        weather.getWeatherDescriptionIcon(condition),
                        fit: BoxFit.fill,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
