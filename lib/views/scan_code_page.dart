import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRCodePage extends StatefulWidget {
  const ScanQRCodePage({Key? key}) : super(key: key);

  @override
  _ScanQRCodePageState createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage> {
  final qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? _qrViewController;

  Barcode? barcode;

  @override
  void dispose() {
    _qrViewController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCameraPermission();
  }

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderColor: Colors.white,
                borderWidth: 5,
              ),
              onQRViewCreated: (QRViewController controller) {
                setState(() {
                  _qrViewController = controller;
                });
                controller.scannedDataStream.listen((barcode) {
                  setState(() {
                    this.barcode = barcode;
                  });
                });
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            barcode == null ? "Scan a code!" : barcode!.code.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
