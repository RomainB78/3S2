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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else
                LocationCard(
                  location: _locationManager.locations[_locationManager.currentIndex],
                ),
              if (!_noMoreLocations)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _locationManager.Idontwant();
                            _checkForMoreLocations();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 3, // Légère translation vers le bas
                              left: 3, // Légère translation vers la droite
                              child: Icon(
                                Icons.close, 
                                size: 70,  
                                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),  // Ombre légère en noir
                              ),
                            ),
                            Icon(
                              Icons.close, 
                              size: 70,  
                              color: const Color.fromARGB(255, 22, 63, 138),  // Couleur principale
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _locationManager.Iwant();
                            _checkForMoreLocations();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 3, // Légère translation vers le bas
                              right: 3, // Légère translation vers la gauche
                              child: Icon(
                                Icons.favorite, 
                                size: 70,  
                                color: Colors.black.withOpacity(0.2),  // Ombre légère en noir
                              ),
                            ),
                            Icon(
                              Icons.favorite, 
                              size: 70,  
                              color: const Color.fromARGB(255, 255, 114, 161),  // Couleur rose
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (!_noMoreLocations)
                const SizedBox(height: 10),
              if (!_noMoreLocations)
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
              Center(
                child :Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go('/selectpage');
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.map_outlined,
                            size: 40,
                            color: Color.fromARGB(255, 169, 2, 215),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Create plan",
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
                      child: const Column(
                        children: [
                          Icon(
                            Icons.nfc,
                            size: 40,
                            color: Color.fromARGB(255, 169, 2, 215),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "NFC Detection",
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
                      child: const Column(
                        children: [
                          Icon(
                            Icons.place,
                            size: 40,
                            color: Color.fromARGB(255, 169, 2, 215),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Visited Places",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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