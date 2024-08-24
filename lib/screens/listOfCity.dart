import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class Listofcity extends StatelessWidget {
  const Listofcity({super.key});

  final List<String> cities = const [
    "Addis Ababa",
    "Dire Dawa",
    "Mekelle",
    "Gondar",
    "Bahir Dar",
    "Awassa",
    "Jimma",
    "Jijiga",
    "Dessie",
    "Harar",
    "Adama",
    "Nazret",
    "Wolaita Sodo",
    "Dila",
    "Shashemene",
    "Gambela",
    "Arbaminch",
    "Keren",
    "Sebeta",
    "Debre Markos"
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor("#000050"),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Background blur effect
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                            child:
                                Container(color: Colors.white.withOpacity(0.3)
                                    // Semi-transparent overlay
                                    ),
                          ),
                        ),
                        // Content on top of the blur effect
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              final cityName = cities[index];
                              context.go(
                                Uri(
                                        path: "/city",
                                        queryParameters: {"cityName": cityName})
                                    .toString(),
                              );
                            },
                            child: ListTile(
                              iconColor: Colors.white,
                              leading: CircleAvatar(
                                child: Text("$index"),
                              ),
                              title: Text(
                                cities[index],
                                style: GoogleFonts.sora(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: const Icon(Iconsax.arrow_right),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: cities.length,
          ),
        ),
      ],
    );
  }
}
