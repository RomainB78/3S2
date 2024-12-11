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
    WidgetsBinding.instance.addPostFrameCallback((_) => _recenterToParis());
  }

  @override
  Widget build(BuildContext context) {
    final List<Location> itinerary = LocationManager().itinerary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
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
          RecenterButton(onPressed: _recenterToParis),
        ],
      ),
    );
  }

  void _recenterToParis() {
    _mapController.move(LatLng(48.870215, 2.328324), 12.5);
    setState(() => _currentZoom = 12.5);
  }

  void _zoom(bool zoomIn) {
    double newZoom = (zoomIn ? _currentZoom + 1 : _currentZoom - 1).clamp(1.0, 18.0);
    setState(() => _currentZoom = newZoom);
    _mapController.move(_mapController.camera.center, newZoom);
  }
}

class ItineraryListView extends StatelessWidget {
  final List<Location> itinerary;

  const ItineraryListView({Key? key, required this.itinerary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemCount: itinerary.length,
      separatorBuilder: (context, index) => Divider(height: 1),
      itemBuilder: (context, index) {
        Location location = itinerary[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text('${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(location.nom, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(location.localization.adress ?? "Adresse non disponible"),
        );
      },
    );
  }
}

class EnhancedFlutterMapView extends StatelessWidget {
  final List<Location> locations;
  final MapController mapController;

  const EnhancedFlutterMapView({Key? key, required this.locations, required this.mapController}) : super(key: key);

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
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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

  const ZoomControls({Key? key, required this.onZoomIn, required this.onZoomOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: "zoomIn",
          child: Icon(Icons.add),
          onPressed: onZoomIn,
          mini: true,
        ),
        SizedBox(height: 8),
        FloatingActionButton(
          heroTag: "zoomOut",
          child: Icon(Icons.remove),
          onPressed: onZoomOut,
          mini: true,
        ),
      ],
    );
  }
}

class RecenterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RecenterButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        icon: Icon(Icons.my_location),
        label: Text('Recentrer sur Paris'),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
