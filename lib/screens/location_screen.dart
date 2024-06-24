import 'package:clima/models/cities.dart';
import 'package:clima/screens/search_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/widgets/city_card.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final dynamic weatherData;

  const LocationScreen({super.key, required this.weatherData});

  @override
  State<LocationScreen> createState() {
    return _LocationScreenState();
  }
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel.defaultConstructor();
  ScrollController _scrollController = ScrollController();
  late double temp;
  late String name;
  late String condition;

  Map<String, double> cityTemperatures = {};
  Map<String, String> cityConditions = {};

  @override
  void initState() {
    super.initState();
    updateUi(widget.weatherData);
    updateCityTemperatures();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      updateCityTemperatures();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void updateUi(dynamic weatherData) {
    setState(() {
      temp = weatherData['current']['temp_c'];
      name = weatherData['location']['name'];
      condition = weatherData['current']['condition']['text'];
    });
  }

  int _page = 0;
  int _pageSize = 10;
  bool _isLoading = false;
  bool _hasMore = true;

  void updateCityTemperatures() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      int startIndex = _page * _pageSize;
      int endIndex = startIndex + _pageSize;
      List<String> currentBatch = cities.sublist(
          startIndex, endIndex > cities.length ? cities.length : endIndex);

      List<Future> futures = currentBatch.map((city) async {
        var weatherData = await weather.getWeatherByCityName(city);
        if (mounted) {
          setState(() {
            cityTemperatures[city] = weatherData['current']['temp_c'];
            cityConditions[city] = weatherData['current']['condition']['text'];
          });
        }
      }).toList();

      await Future.wait(futures);

      setState(() {
        _page++;
        _hasMore = endIndex < cities.length;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () async {
            var weatherData = await weather.getLocationWeather2();
            if (mounted) {
              updateUi(weatherData);
            }
          },
          child: const Icon(
            Icons.location_on,
            size: 30.0,
            color: Colors.black,
          ),
        ),
        title: const Center(
          child: Text(
            'Weather',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.search,
              size: 30.0,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth > 600;
          return Container(
            padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25.0),
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Current Location:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CityCard(
                      cityName: name, temperature: temp, condition: condition),
                  const SizedBox(height: 20),
                  const Text(
                    "Cities:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: cityTemperatures.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == cityTemperatures.length) {
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        }
                        String city = cities[index];
                        double? temp = cityTemperatures[city];
                        String? condition = cityConditions[city];
                        if (temp != null && condition != null) {
                          return CityCard(
                            cityName: city,
                            temperature: temp,
                            condition: condition,
                          );
                        } else {
                          return const CityCard.loading(
                            cityName: 'Loading...',
                          );
                        }
                      },
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
