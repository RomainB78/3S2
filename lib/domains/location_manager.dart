import 'package:swipezone/repositories/models/location.dart';

class LocationManager {
  static final LocationManager _instance = LocationManager._internal();

  factory LocationManager() {
    return _instance;
  }

  LocationManager._internal();

  List<Location> _locations = [];
  int currentIndex = 0;
  Map<Location, bool> filters = {};
  List<Location> unwantedLocations = [];
  List<Location> _itinerary = [];

  // Getter for locations
  List<Location> get locations => _locations;

  // Setter for locations
  set locations(List<Location> value) {
    _locations = value;
  }

  void Iwant() {
    if (currentIndex < _locations.length) {
      filters[_locations[currentIndex]] = true;
      currentIndex++;
    }
  }

  void Idontwant() {
    if (currentIndex < _locations.length) {
      unwantedLocations.add(_locations[currentIndex]);
      currentIndex++;
    }
  }

  void setItinerary(List<Location> locations) {
    _itinerary = locations;
  }

  List<Location> get itinerary => _itinerary;

  void addToItinerary(Location location) {
    if (!_itinerary.contains(location)) {
      _itinerary.add(location);
    }
  }

  void removeFromItinerary(Location location) {
    _itinerary.remove(location);
  }

  void reorderItinerary(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Location item = _itinerary.removeAt(oldIndex);
    _itinerary.insert(newIndex, item);
  }
}

