import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
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
  @override
  void initState() {
    super.initState();
  }

  void createDatabase() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: LocationUseCase().getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            if (data == null || data.isEmpty) {
              return const Center(
                child: Text(
                  "No data",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              );
            }

            LocationManager().locations = data;

            return ListView(
              children: [
                LocationCard(location: data[LocationManager().currentIndex]),
                const SizedBox(height: 30), // Ajouter de l'espace au-dessus des boutons
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            LocationManager().Idontwant();
                          });
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD0EFFF), // Bleu pâle
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/x.png',
                              fit: BoxFit.cover, // Prend tout l'espace du rond
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 70),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            LocationManager().Iwant();
                          });
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFC1CC), // Rose pâle
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/heart.jpg',
                              fit: BoxFit.cover, // Prend tout l'espace du rond
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Liked: ${LocationManager().filters.length}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold, // Texte en gras
                          color: Color.fromARGB(255, 255, 255, 255), // Couleur principale
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0), // Décalage de l'ombre
                              blurRadius: 3.0, // Flou de l'ombre
                              color: Colors.black54, // Couleur de l'ombre
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: FilledButton(
                    onPressed: () {
                      GoRouter.of(context).go('/selectpage');
                    },
                    child: const Text(
                      "Create plan",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
