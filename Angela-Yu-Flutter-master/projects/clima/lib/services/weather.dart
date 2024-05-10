class WeatherModel {
  factory WeatherModel() => _singleton;

  WeatherModel._internal();

  static final WeatherModel _singleton = WeatherModel._internal();

  String getMessage(int temp) {
    String message;
    if (temp > 25) {
      message = 'It\'s 🍦 time';
    } else if (temp > 20) {
      message = 'Time for shorts and 👕';
    } else if (temp < 10) {
      message = 'You\'ll need 🧣 and 🧤';
    } else {
      message = 'Bring a 🧥 just in case';
    }
    return message;
  }

  String getWeatherIcon(int condition) {
    String icon;

    if (condition < 300) {
      icon = '🌩';
    } else if (condition < 400) {
      icon = '🌧';
    } else if (condition < 600) {
      icon = '☔️';
    } else if (condition < 700) {
      icon = '☃️';
    } else if (condition < 800) {
      icon = '🌫';
    } else if (condition == 800) {
      icon = '☀️';
    } else if (condition <= 804) {
      icon = '☁️';
    } else {
      icon = '🤷‍';
    }
    return icon;
  }
}
