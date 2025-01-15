import 'package:swipezone/repositories/location_repository.dart';
import 'package:swipezone/repositories/models/categories.dart';
import 'package:swipezone/repositories/models/localization.dart';
import 'package:swipezone/repositories/models/location.dart';
class ILocationRepository implements LocationRepository {
  @override
  Future<List<Location>> getLocations() {
    return Future.value([
      Location(
        "Tour Eiffel",
        "La Tour Eiffel est un monument emblématique de Paris, construit en 1889.",
        null,
        null,
        "https://cdn.pixabay.com/photo/2015/10/06/18/26/eiffel-tower-975004_1280.jpg",
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
        "https://api-www.louvre.fr/sites/default/files/2021-01/cour-napoleon-et-pyramide_1.jpg",
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
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Notre-Dame_de_Paris_2013-07-24.jpg/280px-Notre-Dame_de_Paris_2013-07-24.jpg",
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
        "https://www.shutterstock.com/image-photo/arch-triumph-arc-de-triomphe-600nw-2227745545.jpg",
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
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Sacr%C3%A9_Coeur_Fa%C3%A7ade_1.jpg/1200px-Sacr%C3%A9_Coeur_Fa%C3%A7ade_1.jpg",
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
        "https://cdn.sortiraparis.com/images/80/103638/962775-le-pantheon-a-paris-les-photos-interieur-a7c9541.jpg",
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
        "https://cdn.sortiraparis.com/images/80/77153/375986-histoire-de-la-place-de-la-concorde.jpg",
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
        'https://t4.ftcdn.net/jpg/02/23/96/01/360_F_223960113_AmVDB3xetvbxzIm1pEo1pWw4LlKT3Q93.jpg', // Utilisation d'un chemin d'image
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
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Jardin_des_Tuileries_-_panoramio_-_Javier_B.jpg/1200px-Jardin_des_Tuileries_-_panoramio_-_Javier_B.jpg",
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
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Alexandre_III_bridge_at_sunrise%2C_Paris_21_September_2015.jpg/617px-Alexandre_III_bridge_at_sunrise%2C_Paris_21_September_2015.jpg",
        null,
        Categories.HistoricalSite,
        null,
        Localization("Pont Alexandre III, 75008 Paris", 48.8654, 2.3131),
      ),
    ]);
  }
}
