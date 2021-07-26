import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({
    required this.descriptive_text,
    required this.update_qr_value,
    required this.border_color,
    required this.border_radius,
    required this.border_length,
    required this.border_width,
    required this.cut_out_size,
  });

  final String descriptive_text;
  final Function(String new_qr_value) update_qr_value;
  final Color border_color;
  final double border_radius;
  final double border_length;
  final double border_width;
  final double cut_out_size;

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode? result;
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: (QRViewController controller) {
              setState(() {
                this.controller = controller;
              });
              controller.scannedDataStream.listen((scan_data) {
                setState(() {
                  result = scan_data;
                  widget.update_qr_value(result!.code);
                });
              });
            },
            overlay: QrScannerOverlayShape(
              borderColor: widget.border_color,
              borderRadius: widget.border_radius,
              borderLength: widget.border_length,
              borderWidth: widget.border_width,
              cutOutSize: widget.cut_out_size,
            ),
          ),
          Container(
            child: Column(
              children: [
                Spacer(flex: 1),
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.descriptive_text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 18,
                    ),
                  ),
                ),
                Spacer(flex: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
