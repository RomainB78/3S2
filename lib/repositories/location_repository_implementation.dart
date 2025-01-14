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
        "assets/tour_eiffel.jpg",
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
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Louvre_Museum_Wikimedia_Commons.jpg/2560px-Louvre_Museum_Wikimedia_Commons.jpg",
        Categories.Museum,
        null,
        Localization("Rue de Rivoli, 75001 Paris", 48.8606, 2.3376),
      ),
      Location(
        "Cathédrale Notre-Dame",
        "La cathédrale gothique Notre-Dame est située sur l'île de la Cité.",
        null,
        null,
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Notre-Dame_de_Paris_2013-07-24.jpg/560px-Notre-Dame_de_Paris_2013-07-24.jpg",
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
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Arc_de_Triomphe%2C_Paris_21_October_2010.jpg/560px-Arc_de_Triomphe%2C_Paris_21_October_2010.jpg",
        Categories.HistoricalSite,
        null,
        Localization("Place Charles de Gaulle, 75008 Paris", 48.8738, 2.295),
      ),
      Location(
        "Sacré-Cœur",
        "La basilique du Sacré-Cœur est un symbole religieux de Montmartre.",
        null,
        null,
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Sacr%C3%A9_Coeur_Fa%C3%A7ade_1.jpg/560px-Sacr%C3%A9_Coeur_Fa%C3%A7ade_1.jpg",
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
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Jielbeaumadier_pantheon_paris_2008.jpg/440px-Jielbeaumadier_pantheon_paris_2008.jpg",
        Categories.HistoricalSite,
        null,
        Localization("Place du Panthéon, 75005 Paris", 48.8462, 2.3449),
      ),
      Location(
        "Place de la Concorde",
        "La plus grande place de Paris, connue pour son obélisque et ses fontaines.",
        null,
        null,
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Place_de_la_Concorde_from_the_Eiffel_Tower%2C_Paris_April_2011.jpg/560px-Place_de_la_Concorde_from_the_Eiffel_Tower%2C_Paris_April_2011.jpg",
        Categories.HistoricalSite,
        null,
        Localization("Place de la Concorde, 75008 Paris", 48.8656, 2.3212),
      ),
      Location(
        "Palais Garnier",
        "L'Opéra Garnier est une somptueuse salle de spectacle datant du XIXe siècle.",
        null,
        null,
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Paris_Palais_Garnier_2010-04-06_16.55.07.jpg/620px-Paris_Palais_Garnier_2010-04-06_16.55.07.jpg",
        Categories.Museum,
        null,
        Localization("Place de l'Opéra, 75009 Paris", 48.8719, 2.3316),
      ),
      Location(
        "Jardin des Tuileries",
        "Le jardin des Tuileries est un jardin public historique situé près du Louvre.",
        null,
        null,
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Jardin_des_Tuileries_-_panoramio_-_Javier_B.jpg/560px-Jardin_des_Tuileries_-_panoramio_-_Javier_B.jpg",
        Categories.Park,
        null,
        Localization("113 Rue de Rivoli, 75001 Paris", 48.8636, 2.3276),
      ),
      Location(
        "Pont Alexandre III",
        "Ce pont richement orné relie les Champs-Élysées et les Invalides.",
        null,
        null,
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Alexandre_III%2C_bridge%2C_Exposition_Universal%2C_1900%2C_Paris%2C_France.jpg/660px-Alexandre_III%2C_bridge%2C_Exposition_Universal%2C_1900%2C_Paris%2C_France.jpg",
        Categories.HistoricalSite,
        null,
        Localization("Pont Alexandre III, 75008 Paris", 48.8654, 2.3131),
      ),
    ]);
  }
}
