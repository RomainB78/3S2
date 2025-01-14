import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/domains/locations_usecase.dart';
import 'package:swipezone/screens/widgets/location_card.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationManager _locationManager = LocationManager();
  bool _noMoreLocations = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: LocationUseCase().getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            if (data == null || data.isEmpty) {
              return const Text("No data");
            }
            _locationManager.locations = data;
            return ListView(children: [
              if (_noMoreLocations)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Il n'y a plus de lieux touristiques à afficher.",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              else
                LocationCard(location: _locationManager.locations[_locationManager.currentIndex]),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _noMoreLocations
                          ? null
                          : () {
                        setState(() {
                          _locationManager.Idontwant();
                          _checkForMoreLocations();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: ClipOval(
                        child: Image.asset('assets/x.png', width: 70, height: 70),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _noMoreLocations
                          ? null
                          : () {
                        setState(() {
                          _locationManager.Iwant();
                          _checkForMoreLocations();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: ClipOval(
                        child: Image.asset('assets/heart.png', width: 70, height: 70),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_locationManager.unwantedLocations.length}",
                    style: const TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "${_locationManager.filters.length}",
                    style: const TextStyle(color: Colors.green, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.go('/selectpage');
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.map_outlined, // Icône de carte par défaut dans Flutter
                          size: 40,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "     Créer un plan",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 25),
                  GestureDetector(
                    onTap: () {
                      context.go('/NFCScanner');
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.nfc, // Icône de carte par défaut dans Flutter
                          size: 40,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "NFC Détection",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 25),
                  GestureDetector(
                    onTap: () {
                      context.go('/VisitedPlacesPage');
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.place, // Icône de carte par défaut dans Flutter
                          size: 40,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "Lieux Visités",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),// Espacement entre les options

                ],
              ),
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _checkForMoreLocations() {
    if (_locationManager.currentIndex >= _locationManager.locations.length) {
      setState(() {
        _noMoreLocations = true;
      });
    }
  }
}
