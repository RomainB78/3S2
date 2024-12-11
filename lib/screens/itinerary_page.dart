import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/repositories/models/location.dart';

class ItineraryPage extends StatefulWidget {
  final String title;

  const ItineraryPage({Key? key, required this.title}) : super(key: key);

  @override
  _ItineraryPageState createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  final MapController _mapController = MapController();
  double _currentZoom = 13.0;

  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _recenterToParis();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Location> itinerary = LocationManager().itinerary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 200,
              child: ListView.builder(
                itemCount: itinerary.length,
                itemBuilder: (context, index) {
                  Location location = itinerary[index];
                  return ListTile(
                    leading: Text('${index + 1}.'),
                    title: Text(location.nom),
                    subtitle: Text(location.localization.adress ?? "No address provided"),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                FlutterMapView(
                  locations: itinerary,
                  mapController: _mapController,
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: "zoomIn",
                        child: Icon(Icons.add),
                        onPressed: () => _zoom(true),
                      ),
                      SizedBox(height: 8),
                      FloatingActionButton(
                        heroTag: "zoomOut",
                        child: Icon(Icons.remove),
                        onPressed: () => _zoom(false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.my_location),
                  onPressed: _recenterToParis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _recenterToParis() {
    _mapController.move(LatLng(48.870215, 2.328324), 12.5);
    setState(() {
      _currentZoom = 12.5;
    });
  }

  void _zoom(bool zoomIn) {
    double newZoom = zoomIn ? _currentZoom + 1 : _currentZoom - 1;
    newZoom = newZoom.clamp(1.0, 18.0); // Limiter le zoom entre 1 et 18
    setState(() {
      _currentZoom = newZoom;
    });
    _mapController.move(_mapController.camera.center, newZoom);
  }
}

class FlutterMapView extends StatelessWidget {
  final List<Location> locations;
  final MapController mapController;

  const FlutterMapView({Key? key, required this.locations, required this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: LatLng(48.85944, 2.326048),
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.example.app',
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: locations.map((location) => LatLng(
                location.localization.lat ?? 0.0,
                location.localization.lng ?? 0.0,
              )).toList(),
              strokeWidth: 4.0,
              color: Colors.blue,
            ),
          ],
        ),
        MarkerLayer(
          markers: locations.asMap().entries.map((entry) {
            int index = entry.key;
            Location location = entry.value;

            return Marker(
              point: LatLng(
                location.localization.lat ?? 0.0,
                location.localization.lng ?? 0.0,
              ),
              width: 80.0,
              height: 80.0,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
