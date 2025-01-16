import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCScanner extends StatefulWidget {
  final String title;
  final Function(String) onAddVisitedPlace;
  const NFCScanner({
    super.key,
    required this.title,
    required this.onAddVisitedPlace,
  });

  @override
  _NFCScannerState createState() => _NFCScannerState();
}

class _NFCScannerState extends State<NFCScanner> {
  String _nfcData = 'No NFC tag detected';
  bool _isScanning = false;
  List<String> scannedIds = [];

  @override
  void initState() {
    super.initState();
    _checkNFCAvailability();
  }

  Future<void> _checkNFCAvailability() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      setState(() {
        _nfcData = 'NFC non disponible sur cet appareil';
      });
    }
  }

  void _showPopup(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          content: Text(content, style: const TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _startNFCScan() {
    setState(() {
      _isScanning = true;
      _nfcData = 'Scanning for NFC tags...';
    });

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      String? tagId;

      if (tag.data.containsKey('nfca')) {
        final nfca = tag.data['nfca'];
        if (nfca != null && nfca['identifier'] != null) {
          final id = nfca['identifier'] as List<int>;
          tagId = id.map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');
        }
      }

      if (tagId != null) {
        if (scannedIds.contains(tagId)) {
          _showPopup('NFC déjà scanné', 'Ce tag NFC a déjà été scanné.');
        } else {
          if (tagId == '04:94:83:72:2F:18:90') {
            scannedIds.add(tagId);
            widget.onAddVisitedPlace('Tour Eiffel');
            _showPopup('Bravo !', 'Vous venez de visiter la Tour Eiffel !');
          } else if (tagId == '14:D9:A4:95') {
            scannedIds.add(tagId);
            widget.onAddVisitedPlace('Panthéon');
            _showPopup('Bravo !', 'Vous venez de visiter le Panthéon !');
          } else {
            _showPopup('Inconnu', 'Tag NFC non reconnu.');
          }
        }
      }

      setState(() {
        _isScanning = false;
      });

      NfcManager.instance.stopSession();
    });
  }

  void _stopNFCScan() {
    NfcManager.instance.stopSession();
    setState(() {
      _isScanning = false;
      _nfcData = 'Scan stopped';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isScanning ? _stopNFCScan : _startNFCScan,
                child: Text(_isScanning ? 'Stop Scan' : 'Start Scan'),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Text(
                      'NFC Tag Information:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _nfcData,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }
}

