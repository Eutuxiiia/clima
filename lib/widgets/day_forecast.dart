import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DayForecast extends StatelessWidget {
  final String date;
  final List<dynamic> hourlyData;

  const DayForecast({
    Key? key,
    required this.date,
    required this.hourlyData,
  }) : super(key: key);

  String extractTime(String dateTime) {
    return dateTime.split(' ')[1];
  }

  @override
  Widget build(BuildContext context) {
    WeatherModel weather = WeatherModel.defaultConstructor();
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            date,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hourlyData.length,
                itemBuilder: (context, index) {
                  var hour = hourlyData[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          extractTime(hour['time']),
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Lottie.asset(
                            weather.getWeatherDescriptionIcon(
                                hour['condition']['text']),
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${hour['temp_c']}°C',
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
