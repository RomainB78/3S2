import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/repositories/models/location.dart';

class PlanningPage extends StatefulWidget {
  final String title;

  const PlanningPage({super.key, required this.title});

  @override
  State<PlanningPage> createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  @override
  Widget build(BuildContext context) {
    // Utilisez une méthode pour obtenir l'itinéraire
    List<Location> itinerary = LocationManager().itinerary;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: itinerary.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(itinerary[index].photoUrl ?? "", width: 50, height: 50),
            title: Text(itinerary[index].nom),
            subtitle: Text(itinerary[index].localization.adress ?? "No address communicated"),
          );
        },
      ),
    );
  }
}