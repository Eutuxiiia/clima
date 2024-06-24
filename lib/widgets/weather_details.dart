import 'package:flutter/material.dart';

class WeatherDetailsPopup extends StatelessWidget {
  final Map<String, dynamic> hour;

  const WeatherDetailsPopup({super.key, required this.hour});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: const Center(child: Text('Weather Details')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildWeatherDetailRow('Wind', '${hour['wind_kph']} km/h  💨'),
            const Divider(thickness: 1),
            buildWeatherDetailRow('Humidity', '${hour['humidity']}%  💦'),
            const Divider(thickness: 1),
            buildWeatherDetailRow('Feels Like', '${hour['feelslike_c']}°C  🌡'),
            const Divider(thickness: 1),
            buildWeatherDetailRow('Visibility', '${hour['vis_km']} km  👁'),
            const Divider(thickness: 1),
            buildWeatherDetailRow('Pressure', '${hour['pressure_mb']} mb  🌡️'),
            const Divider(thickness: 1),
            buildWeatherDetailRow('Dew Point', '${hour['dewpoint_c']}°C  🌡'),
            const Divider(thickness: 1),
            buildWeatherDetailRow('Heat Index', '${hour['heatindex_c']}°C  🌡'),
            const Divider(thickness: 1),
            buildWeatherDetailRow('Cloud Cover', '${hour['cloud']}%  ☁️'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget buildWeatherDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
