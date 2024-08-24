import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/screens/homeScreen.dart';
import 'package:weather_app/services/weather_services.dart';

class Citypage extends StatefulWidget {
  final String? cityName;

  const Citypage({super.key, required this.cityName});

  @override
  State<Citypage> createState() => _CitypageState();
}

class _CitypageState extends State<Citypage> {
  final _weather_service =
      WeatherServices(apikey: dotenv.env['API_KEY']);
  Weather? _weather;

  fetchWeather() async {
    if (widget.cityName != null) {
      // Ensure cityName is not null
      try {
        final weather = await _weather_service.getWeather(widget.cityName);
        setState(() {
          _weather = weather;
        });
      } catch (e) {
        print(e);
      }
    } else {
      print('cityName is null');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: HexColor("#000050"),
        title: Text(_weather?.cityName ?? "Adama"),
        leading: IconButton(
            onPressed: () => {
                  context.pop(),
                },
            icon: const Icon(Iconsax.arrow_square_left)),
      ),
      backgroundColor: HexColor("#000050"),
      body: Stack(children: [
        Positioned(
            left: -50,
            top: 200,
            child: SvgPicture.asset(
              "assets/cloud_outline.svg",
              width: 150,
              height: 150,
              color: Colors.white.withOpacity(0.3),
              colorBlendMode: BlendMode.srcIn,
            )),
        HomePage(weather: _weather)
      ]),
    );
  }
}
