class Weather {
  final String cityName;
  final double temperature;
  final String weatherCondition;
  Weather(
      {required this.cityName,
      required this.temperature,
      required this.weatherCondition});
  factory Weather.fromJson(Map<String, dynamic> json) {
    final main = json["main"];
    final weather = json["weather"][0];
    return Weather(
        cityName: json["name"],
        temperature: main["temp"].toDouble(),
        weatherCondition: weather["Description"]);
  }
}
