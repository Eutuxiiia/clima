import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  WeatherModel.defaultConstructor();
  WeatherModel(this.name);
  String? name;

  String apiKey = '31716e27eb2545efae592708242306';

  Future<dynamic> getLocationWeather() async {
    Locations location = Locations.defaultConstructor();
    await location.getCurrentLocation();

    Networking networking = Networking(
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=${location.latitude},${location.longitude}&aqi=no&current_fields=temp_c,condition');

    var weatherData = await networking.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather2() async {
    Locations location = Locations.defaultConstructor();
    await location.getCurrentLocation();

    Networking networking = Networking(
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=51.50853,-0.12574&aqi=no&current_fields=temp_c,condition');

    var weatherData = await networking.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeatherByName() async {
    try {
      Locations location = Locations.defaultConstructor();
      await location.getCurrentLocation();

      Networking networking = Networking(
          'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$name&aqi=no&current_fields=temp_c,condition');

      var weatherData = await networking.getData();
      return weatherData;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getWeatherByCityName(String cityName) async {
    String url =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$cityName&aqi=no&current_fields=temp_c,condition';
    Networking networking = Networking(url);
    var weatherData = await networking.getData();

    return weatherData;
  }

  Future<dynamic> getWeatherByCityDay(String cityName) async {
    String url =
        'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$cityName&days=3&aqi=no&alerts=no';
    Networking networking = Networking(url);
    var weatherData = await networking.getData();
    return weatherData;
  }

  String getWeatherDescriptionIcon(String condition) {
    condition = condition.toLowerCase();

    if (condition.contains('sunny')) {
      return 'assets/sunny.json';
    } else if (condition.contains('clear')) {
      return 'assets/clear.json';
    } else if (condition.contains('partly cloudy')) {
      return 'assets/partly_cloudy.json';
    } else if (condition.contains('cloudy') || condition.contains('overcast')) {
      return 'assets/cloud.json';
    } else if (condition.contains('mist')) {
      return 'assets/mist.json';
    } else if (condition.contains('rain')) {
      return 'assets/rain.json';
    } else if (condition.contains('snow')) {
      return 'assets/snow.json';
    } else if (condition.contains('sleet')) {
      return 'assets/snow.json';
    } else if (condition.contains('freezing drizzle')) {
      return 'assets/snow.json';
    } else if (condition.contains('thunder')) {
      return 'assets/thunder.json';
    } else if (condition.contains('blowing snow') ||
        condition.contains('blizzard')) {
      return 'assets/snow.json';
    } else if (condition.contains('fog')) {
      return 'assets/mist.json';
    } else if (condition.contains('drizzle')) {
      return 'assets/rain.json';
    } else if (condition.contains('ice pellets')) {
      return 'assets/snow.json';
    } else {
      return '🤷‍';
    }
  }
}
