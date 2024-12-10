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
            child: ListView.builder(
              itemCount: plans.length,
              itemBuilder: (context, index) {
                Location location = plans.keys.elementAt(index);
                bool isSelected = itinerary.contains(location);
                return ListTile(
                  title: Text(location.nom),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          LocationManager().addToItinerary(location);
                        } else {
                          LocationManager().removeFromItinerary(location);
                        }
                        itinerary = LocationManager().itinerary;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  LocationManager().reorderItinerary(oldIndex, newIndex);
                  itinerary = LocationManager().itinerary;
                });
              },
              children: itinerary.map((location) => ListTile(
                key: ValueKey(location),
                title: Text(location.nom),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() {
                      LocationManager().removeFromItinerary(location);
                      itinerary = LocationManager().itinerary;
                    });
                  },
                ),
              )).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push('/itinerarypage');
        },
        tooltip: 'View Itinerary',
        child: const Icon(Icons.map),
      ),
    );
  }
}

