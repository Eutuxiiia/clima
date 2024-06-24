import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    try {
      var weatherData =
          await WeatherModel.defaultConstructor().getLocationWeather();

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationScreen(
              weatherData: weatherData,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error fetching location data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;

    double spinnerSize = orientation == Orientation.portrait
        ? screenSize.width * 0.1
        : screenSize.height * 0.1;

    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.black,
          size: spinnerSize,
        ),
      ),
    );
  }
}
