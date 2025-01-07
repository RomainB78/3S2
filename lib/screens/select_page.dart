import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/repositories/models/location.dart';

class SelectPage extends StatefulWidget {
  final String title;

  const SelectPage({super.key, required this.title});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  Map<Location, bool> plans = {};
  List<Location> itinerary = [];

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    Map<Location, bool> fetchedPlans = LocationManager().filters;
    setState(() {
      plans = fetchedPlans;
      itinerary = LocationManager().itinerary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: AvailableLocationsList(
              plans: plans,
              itinerary: itinerary,
              onLocationToggled: _toggleLocation,
            ),
          ),
          Divider(height: 2, thickness: 2, color: Theme.of(context).colorScheme.secondary),
          Expanded(
            child: SelectedLocationsList(
              itinerary: itinerary,
              onReorder: _reorderItinerary,
              onRemove: _removeFromItinerary,
            ),
          ),
        ],
      ),
      floatingActionButton: const ViewItineraryButton(),
    );
  }

  void _toggleLocation(Location location, bool? isSelected) {
    setState(() {
      if (isSelected == true) {
        LocationManager().addToItinerary(location);
      } else {
        LocationManager().removeFromItinerary(location);
      }
      itinerary = LocationManager().itinerary;
    });
  }

  void _reorderItinerary(int oldIndex, int newIndex) {
    setState(() {
      LocationManager().reorderItinerary(oldIndex, newIndex);
      itinerary = LocationManager().itinerary;
    });
  }

  void _removeFromItinerary(Location location) {
    setState(() {
      LocationManager().removeFromItinerary(location);
      itinerary = LocationManager().itinerary;
    });
  }
}

class AvailableLocationsList extends StatelessWidget {
  final Map<Location, bool> plans;
  final List<Location> itinerary;
  final Function(Location, bool?) onLocationToggled;

  const AvailableLocationsList({
    super.key,
    required this.plans,
    required this.itinerary,
    required this.onLocationToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Lieux disponibles',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: plans.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              Location location = plans.keys.elementAt(index);
              bool isSelected = itinerary.contains(location);
              return ListTile(
                title: Text(location.nom, style: const TextStyle(fontWeight: FontWeight.w500)),
                trailing: Checkbox(
                  value: isSelected,
                  onChanged: (val) => onLocationToggled(location, val),
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SelectedLocationsList extends StatelessWidget {
  final List<Location> itinerary;
  final Function(int, int) onReorder;
  final Function(Location) onRemove;

  const SelectedLocationsList({
    super.key,
    required this.itinerary,
    required this.onReorder,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Itinéraire sélectionné',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: ReorderableListView(
            onReorder: onReorder,
            children: itinerary.asMap().entries.map((entry) {
              int index = entry.key;
              Location location = entry.value;
              return SelectedLocationItem(
                key: ValueKey(location),
                location: location,
                index: index,
                onRemove: () => onRemove(location),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SelectedLocationItem extends StatelessWidget {
  final Location location;
  final int index;
  final VoidCallback onRemove;

  const SelectedLocationItem({
    super.key,
    required this.location,
    required this.index,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Plus d'espace
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Coins arrondis
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary, // Couleur dynamique
          radius: 20, // Taille du cercle augmentée
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: Colors.white, // Texte contrastant
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          location.nom,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}

class ViewItineraryButton extends StatelessWidget {
  const ViewItineraryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => GoRouter.of(context).push('/itinerarypage'),
      tooltip: 'Voir l\'itinéraire',
      icon: const Icon(Icons.map, size: 28),
      label: const Text(
        'Voir l\'itinéraire',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 6,
    );
  }
}
