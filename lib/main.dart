import 'package:flutter/material.dart';
import 'package:rickandmorty_app/widgets/route_generator.dart';
import 'package:rickandmorty_app/screens/character_details.dart';
import 'package:rickandmorty_app/screens/error_screen.dart';
import 'package:rickandmorty_app/screens/location_details_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute:
      RouteGenerator.generateRoute,

      //     (settings) {
      //   if (settings.name == '/home') {
      //     return MaterialPageRoute(
      //       builder: (context) =>const HomeScreen(),
      //     );
      //   }
      //
      //   else if (settings.name == '/charDetails') {
      //     final args = settings.arguments as Map;
      //     return MaterialPageRoute(
      //       builder: (context) => CharacterDetails(url: args['charUrl']),
      //     );
      //   }
      //
      //   else if (settings.name == '/locationDetails') {
      //     final args = settings.arguments as Map;
      //     return MaterialPageRoute(
      //       builder: (context) => LocationDetailsScreen(url: args['locationUrl']),
      //     );
      //   }
      //   else{
      //     return MaterialPageRoute(
      //         builder: (context) => const ErrorScreen());
      //   }
      // }
      // ,

      initialRoute: '/',

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
