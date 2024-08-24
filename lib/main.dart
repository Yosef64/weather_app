import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/screens/cityPage.dart';
import 'package:weather_app/screens/homeScreen.dart';
import 'package:weather_app/screens/listOfCity.dart';
import 'package:weather_app/services/weather_services.dart';

Future<void> main() async {  
  // Load the environment variables  
  await dotenv.load(fileName: ".env");  
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // This widget is the root of your application.
  final _pageController = PageController();
  final _weather_service =
      WeatherServices(apikey: "6e38dbe5c8abf22d4fbb1d78b26c5470");
  int currentIndex = 0;

  Weather? _weather;
  List<Widget> _buildPages() {
    return [
      HomePage(weather: _weather),
      Listofcity(),
    ];
  }

  fetchWeather() async {
    String cityName = await _weather_service.getCurrentCity();
    try {
      final weather = await _weather_service.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#000050"),
      bottomNavigationBar: Container(
        color: HexColor("#000050"),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            selectedIndex: currentIndex,
            onTabChange: (int tab) {
              setState(() {
                currentIndex = tab;
              });
              _pageController.animateToPage(
                tab,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            gap: 10,
            color: Colors.white,
            activeColor: Colors.white,
            tabBorderRadius: 20,
            curve: Curves.easeOutExpo,
            tabBackgroundGradient: const LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            padding: const EdgeInsets.all(16),
            textStyle: GoogleFonts.sora(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18)),
            tabs: const [
              GButton(icon: Iconsax.home, text: "Home"),
              GButton(icon: Iconsax.filter, text: "Explore"),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: HexColor("#000050"),
        leading: const Icon(Icons.menu),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Today",
          style: GoogleFonts.sora(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Stack(children: [
        PageView(
          onPageChanged: (int ind) {
            setState(() {
              currentIndex = ind;
            });
          },
          controller: _pageController,
          children: _buildPages(),
        ),
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
      ]),
    );
  }
}

final _router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => FirstPage(),
      routes: [
        GoRoute(
          path: "city",
          builder: (context, state) {
            final cityName = state.uri.queryParameters["cityName"];
            return Citypage(cityName: cityName);
          },
        ),
      ],
    ),
  ],
);
