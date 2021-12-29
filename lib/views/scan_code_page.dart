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
    return Container(
      height: 200,
      width: double.infinity,
      child: QRView(
          key: qrKey,
          onQRViewCreated: (QRViewController controller) {
            setState(() {
              _qrViewController = controller;
            });
          }),
    );
  }
}
