import 'package:swipezone/repositories/location_repository.dart';
import 'package:swipezone/repositories/models/categories.dart';
import 'package:swipezone/repositories/models/localization.dart';
import 'package:swipezone/repositories/models/location.dart';
import 'dart:ui';
import 'package:isar/isar.dart';
class ILocationRepository implements LocationRepository {
  @override
  Future<List<Location>> getLocations() {
    return Future.value([
      Location(
        "Tour Eiffel",
        "La Tour Eiffel est un monument emblématique de Paris, construit en 1889.",
        null,
        null,
        "assets/images/tour_eiffel.jpg",
        null,
        Categories.Tower,
        null,
        Localization("Champ de Mars, 5 Avenue Anatole France, 75007 Paris",
            48.8584, 2.2945),
      ),
      Location(
        "Louvre",
        "Le Louvre est le plus grand musée d'art du monde, abritant la Joconde.",
        null,
        null,
        "assets/images/louvre.jpg",
        null,
        Categories.Museum,
        null,
        Localization("Rue de Rivoli, 75001 Paris", 48.8606, 2.3376),
      ),
      Location(
        "Cathédrale Notre-Dame",
        "La cathédrale gothique Notre-Dame est située sur l'île de la Cité.",
        null,
        null,
        "assets/images/notredame.jpg",
        null,
        Categories.Church,
        null,
        Localization("6 Parvis Notre-Dame - Pl. Jean-Paul II, 75004 Paris",
            48.8529, 2.3508),
      ),
      Location(
        "Arc de Triomphe",
        "Construit pour honorer les victoires de Napoléon, il est situé sur la place de l'Étoile.",
        null,
        null,
        "assets/images/arc.jpg",
        null,
        Categories.HistoricalSite,
        null,
        Localization("Place Charles de Gaulle, 75008 Paris", 48.8738, 2.295),
      ),
      Location(
        "Sacré-Cœur",
        "La basilique du Sacré-Cœur est un symbole religieux de Montmartre.",
        null,
        null,
        "assets/images/sacre.jpg",
        null,
        Categories.Church,
        null,
        Localization(
            "35 Rue du Chevalier de la Barre, 75018 Paris", 48.8867, 2.3431),
      ),
      Location(
        "Panthéon",
        "Le Panthéon est un mausolée pour les grandes figures françaises.",
        null,
        null,
        "assets/images/pantheon.jpg",
        null,
        Categories.HistoricalSite,
        null,
        Localization("Place du Panthéon, 75005 Paris", 48.8462, 2.3449),
      ),
      Location(
        "Place de la Concorde",
        "La plus grande place de Paris, connue pour son obélisque et ses fontaines.",
        null,
        null,
        "assets/images/concorde.jpg",
        null,
        Categories.HistoricalSite,
        null,
        Localization("Place de la Concorde, 75008 Paris", 48.8656, 2.3212),
      ),
      Location(
        "Palais Garnier",
        "L'Opéra Garnier est une somptueuse salle de spectacle datant du XIXe siècle.",
        null,
        null,
        'assets/images/garnier.jpg', // Utilisation d'un chemin d'image
        null, // Pas de widget Image directement
        Categories.Museum,
        null,
        Localization("Place de l'Opéra, 75009 Paris", 48.8719, 2.3316),
      ),

      Location(
        "Jardin des Tuileries",
        "Le jardin des Tuileries est un jardin public historique situé près du Louvre.",
        null,
        null,
        "assets/images/tuilerie.jpg",
        null,
        Categories.Park,
        null,
        Localization("113 Rue de Rivoli, 75001 Paris", 48.8636, 2.3276),
      ),
      Location(
        "Pont Alexandre III",
        "Ce pont richement orné relie les Champs-Élysées et les Invalides.",
        null,
        null,
        "assets/images/alexandre.jpg",
        null,
        Categories.HistoricalSite,
        null,
        Localization("Pont Alexandre III, 75008 Paris", 48.8654, 2.3131),
      ),
    ]);
  }
}
