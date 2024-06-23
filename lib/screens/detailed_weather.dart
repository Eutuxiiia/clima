import 'package:clima/services/weather.dart';
import 'package:clima/widgets/day_forecast.dart';
import 'package:flutter/material.dart';

class DetailedWeatherScreen extends StatefulWidget {
  final String name;

  const DetailedWeatherScreen({super.key, required this.name});

  @override
  State<DetailedWeatherScreen> createState() {
    return _DetailedWeatherScreenState();
  }
}

class _DetailedWeatherScreenState extends State<DetailedWeatherScreen> {
  WeatherModel weather = WeatherModel.defaultConstructor();
  late String cityName;
  late List<dynamic> forecastData = [];

  @override
  void initState() {
    super.initState();
    cityName = widget.name;
    fetchWeatherData();
  }

  void fetchWeatherData() async {
    try {
      var weatherData = await weather.getWeatherByCityDay(cityName);
      if (mounted) {
        setState(() {
          forecastData = weatherData['forecast']['forecastday'];
        });
      }
    } catch (e) {
      print('Error fetching weather for $cityName: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            widget.name,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, top: 15, right: 25),
        child: forecastData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  DayForecast(
                    date: forecastData[0]['date'],
                    hourlyData: forecastData[0]['hour'],
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  DayForecast(
                    date: forecastData[1]['date'],
                    hourlyData: forecastData[1]['hour'],
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  DayForecast(
                    date: forecastData[2]['date'],
                    hourlyData: forecastData[2]['hour'],
                  ),
                ],
              ),
      ),
    );
  }
}
