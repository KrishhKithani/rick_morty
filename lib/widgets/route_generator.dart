import 'package:flutter/material.dart';
import 'package:rickandmorty_app/screens/character_details.dart';
import 'package:rickandmorty_app/screens/error_screen.dart';
import 'package:rickandmorty_app/screens/home_screen.dart';
import 'package:rickandmorty_app/screens/location_details_screen.dart';

class RouteGenerator {
  static Route generateRoute(settings) {
    print(settings.name);
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case '/charDetails':
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => CharacterDetails(url: args),
        );
      case '/locationDetails':
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => LocationDetailsScreen(url: args),
        );
      default:
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
    }
  }
}
