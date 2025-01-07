import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCScanner extends StatefulWidget {
  final String title;
  const NFCScanner({super.key,required this.title});

  @override
  _NFCScannerState createState() => _NFCScannerState();
}

class _NFCScannerState extends State<NFCScanner> {
  bool _isNFCAvailable = false;
  String _nfcData = 'No NFC tag detected';
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _checkNFCAvailability();
  }

  Future<void> _checkNFCAvailability() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    setState(() {
      _isNFCAvailable = isAvailable;
    });
  }

  void _startNFCScan() {
    setState(() {
      _isScanning = true;
      _nfcData = 'Scanning for NFC tags...';
    });

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      Map<String, dynamic> tagData = {};

      // Get tag ID
      if (tag.data.containsKey('nfca')) {
        final nfca = tag.data['nfca'];
        if (nfca != null && nfca['identifier'] != null) {
          final id = nfca['identifier'] as List<int>;
          tagData['ID'] = id.map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');
        }
      }

      // Get NDEF data if available
      if (tag.data.containsKey('ndef')) {
        final ndef = tag.data['ndef'];
        if (ndef != null && ndef['cachedMessage'] != null) {
          final message = ndef['cachedMessage'];
          if (message['records'] != null) {
            final records = message['records'] as List;
            tagData['NDEF Records'] = records.length.toString();

            List<String> recordData = [];
            for (var record in records) {
              if (record['payload'] != null) {
                String payload = String.fromCharCodes(record['payload']);
                recordData.add(payload);
              }
            }
            tagData['NDEF Content'] = recordData.join('\n');
          }
        }
      }

      setState(() {
        _nfcData = tagData.entries.map((e) => '${e.key}: ${e.value}').join('\n');
        _isScanning = false;
      });

      // Stop session after reading
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
        title: const Text('NFC Scanner'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_isNFCAvailable)
                const Text(
                  'NFC is not available on this device',
                  style: TextStyle(color: Colors.red),
                )
              else
                Column(
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