class Weather {
  final String cityName;
  final double temprature;
  final String condition;

  Weather(
      {required this.cityName,
      required this.temprature,
      required this.condition});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json["name"],
        temprature: json["main"]["temp"].toDouble(),
        condition: json['weather'][0]['main']);
  }
}
