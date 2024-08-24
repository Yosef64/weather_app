import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';

class HomePage extends StatelessWidget {
  final Weather? weather;
  // final String cityName = widget.cityName;
  const HomePage({super.key, required this.weather});

  String getWeatherAnimation(String condition) {
    String currentConditon = condition.toLowerCase();
    List<String> cloude = ["clouds", "mist", "smoke", "haze", "dust", "fog"];
    List<String> rainy = ["rain", "drizzle", "shower rain"];
    List<String> thunder = ["thunderstorm"];
    if (cloude.contains(currentConditon)) {
      return "assets/cloudy.json";
    }
    if (rainy.contains(currentConditon)) return "assets/rainy.json";
    if (thunder.contains(currentConditon)) return "assets/thunder.json";
    return "assets/sunny.json";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(getWeatherAnimation(weather?.condition ?? "")),
        Expanded(
          child: Column(
            children: [
              Text(
                "${weather?.temprature.round()} °C" ?? "°C",
                style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                weather?.condition ?? "",
                style: GoogleFonts.sora(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Text(
            weather?.cityName ?? "City name ...",
            style: GoogleFonts.sora(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
