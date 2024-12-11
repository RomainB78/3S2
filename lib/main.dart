import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/screens/home_page.dart';
import 'package:swipezone/screens/planning_page.dart';
import 'package:swipezone/screens/select_page.dart';
import 'package:swipezone/screens/itinerary_page.dart';

void main() {
  runApp(MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(title: 'HomePage'),
      routes: [
        GoRoute(
          path: 'planningpage',
          builder: (context, state) => const PlanningPage(title: 'Page de Planning'),
        ),
        GoRoute(
          path: 'selectpage',
          builder: (context, state) => const SelectPage(title: 'Page de sélection'),
        ),
        GoRoute(
          path: 'itinerarypage',
          builder: (context, state) => const ItineraryPage(title: 'Votre Itinéraire'),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '3S2_SWIPEZONE',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

