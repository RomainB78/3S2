import 'package:flutter/material.dart';

class VisitedPlacesPage extends StatelessWidget {
  final String title;
  final List<String> visitedPlaces;

  const VisitedPlacesPage({
    super.key,
    required this.title,
    required this.visitedPlaces,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: visitedPlaces.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(visitedPlaces[index]),
          );
        },
      ),
    );
  }
}