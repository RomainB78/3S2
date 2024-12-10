import 'package:flutter/material.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/repositories/models/location.dart';

class ItineraryPage extends StatelessWidget {
  final String title;

  const ItineraryPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    List<Location> itinerary = LocationManager().itinerary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: itinerary.length,
        itemBuilder: (context, index) {
          Location location = itinerary[index];
          return ListTile(
            leading: Text('${index + 1}.'),
            title: Text(location.nom),
            subtitle: Text(location.localization.adress ?? "No address provided"),
          );
        },
      ),
    );
  }
}

