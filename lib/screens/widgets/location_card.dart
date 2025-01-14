import 'package:flutter/material.dart';
import 'package:swipezone/repositories/models/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  const LocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/1.7,
      width: MediaQuery.of(context).size.width/1.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color.fromARGB(255, 203, 150, 221), const Color.fromARGB(255, 203, 130, 221)], // Dégradé de vert
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16), // Coins arrondis
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Ombre légère
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Coins arrondis pour l'image
                  child: AspectRatio(
                    aspectRatio: 2/2, // Ajustez le ratio selon vos besoins
                    child: Image.network(
                      location.assetPath ?? "",
                      fit: BoxFit.cover, // Ajuste l'image pour couvrir l'espace
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Nom du monument
                Text(
                  location.nom,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                // Adresse
                Text(
                  location.localization.adress ?? "Aucune adresse disponible",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
