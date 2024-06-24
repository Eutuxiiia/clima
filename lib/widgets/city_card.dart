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
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth > 600;
          double fontSize = isTablet ? 24.0 : 20.0;
          double iconSize = isTablet ? 50.0 : 40.0;
          double padding = isTablet ? 20.0 : 10.0;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: padding / 2,
              ),
              title: Text(
                cityName,
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${temperature.toInt()}°C',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  SizedBox(
                    width: condition == '' ? iconSize / 2 : iconSize,
                    height: condition == '' ? iconSize / 2 : iconSize,
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
          );
        },
      ),
    );
  }
}
