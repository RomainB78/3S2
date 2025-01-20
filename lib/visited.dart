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
        title: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 211, 188, 253),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: visitedPlaces.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text(
                    'Aucun lieu visité',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: visitedPlaces.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.location_on, color: Colors.blue),
                    title: Text(
                      visitedPlaces[index],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                  ),
                );
              },
            ),
    );
  }
}
