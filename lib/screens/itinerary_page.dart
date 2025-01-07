import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/repositories/models/location.dart';
import 'package:url_launcher/url_launcher.dart';

class ItineraryPage extends StatefulWidget {
  final String title;

  const ItineraryPage({super.key, required this.title});

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _recenterToParis());
  }

  @override
  Widget build(BuildContext context) {
    final List<Location> itinerary = LocationManager().itinerary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ItineraryListView(itinerary: itinerary),
          ),
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                EnhancedFlutterMapView(
                  locations: itinerary,
                  mapController: _mapController,
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: ZoomControls(
                    onZoomIn: () => _zoom(true),
                    onZoomOut: () => _zoom(false),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RecenterButton(onPressed: _recenterToParis),
                ElevatedButton(
                  onPressed: _launchURL,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Google Maps'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _recenterToParis() {
    _mapController.move(const LatLng(48.870215, 2.328324), 12.5);
    setState(() => _currentZoom = 12.5);
  }

  void _zoom(bool zoomIn) {
    double newZoom = (zoomIn ? _currentZoom + 1 : _currentZoom - 1).clamp(1.0, 18.0);
    setState(() => _currentZoom = newZoom);
    _mapController.move(_mapController.camera.center, newZoom);
  }

  _launchURL() async {
    const String baseUrl = 'https://www.google.com/maps/dir/';
    final List<Location> itinerary = LocationManager().itinerary;
    String url = '$baseUrl${itinerary
        .map((location) =>
    '${Uri.encodeComponent(location.localization.lat.toString())},${Uri.encodeComponent(location.localization.lng.toString())}')
        .join('/')}/data=!4m2!4m1!3e2';
    if (await launch(url)) {
      await canLaunch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ItineraryListView extends StatelessWidget {
  final List<Location> itinerary;

  const ItineraryListView({super.key, required this.itinerary});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: itinerary.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        Location location = itinerary[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              '${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          title: Text(
            location.nom,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location.localization.adress ?? "Adresse non disponible",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EnhancedFlutterMapView extends StatelessWidget {
  final List<Location> locations;
  final MapController mapController;

  const EnhancedFlutterMapView({super.key, required this.locations, required this.mapController});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: const MapOptions(
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
              width: 40.0,
              height: 40.0,
              child: CustomPaint(
                painter: MarkerPainter(index + 1),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class MarkerPainter extends CustomPainter {
  final int number;

  MarkerPainter(this.number);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: number.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ZoomControls extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const ZoomControls({super.key, required this.onZoomIn, required this.onZoomOut});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: "zoomIn",
          mini: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: onZoomIn,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: "zoomOut",
          mini: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: onZoomOut,
          child: const Icon(Icons.remove, color: Colors.white),
        ),
      ],
    );
  }
}

class RecenterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RecenterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.my_location),
      label: const Text('Recentrer sur Paris'),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
