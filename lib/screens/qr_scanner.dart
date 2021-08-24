import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({
    required this.descriptive_text,
    required this.update_qr_value,
    required this.border_color,
    required this.border_radius,
    required this.border_length,
    required this.border_width,
    required this.cut_out_size,
    required this.button_linear_gradient,
  });

  final String descriptive_text;
  final Function(String new_qr_value) update_qr_value;
  final Color border_color;
  final double border_radius;
  final double border_length;
  final double border_width;
  final double cut_out_size;
  final LinearGradient? button_linear_gradient;

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode? result;
  late QRViewController controller;
  final GlobalKey qr_key = GlobalKey(debugLabel: 'QR');
  TextEditingController _controller_vending_machine_id =
      TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    _controller_vending_machine_id.dispose();
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
  void initState() {
    super.initState();
    check_camera_permission();
  }

  check_camera_permission() async {
    if (!UniversalPlatform.isWeb) {
      if (await Permission.camera.request().isDenied ||
          await Permission.camera.request().isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: UniversalPlatform.isWeb
          ? Center(
              child: FractionallySizedBox(
                widthFactor: 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      onTap: () {
                        //
                      },
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: color_lum_green,
                        fontSize: 18,
                      ),
                      controller: _controller_vending_machine_id,
                      decoration: InputDecoration(
                        hintText: "Vending Machine ID",
                        hintStyle: TextStyle(
                          color: color_lum_green,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sized_box_space * 2,
                    ),
                    Container(
                      height: 50,
                      width: screen_width / (portrait ? 2 : 8),
                      child: CustomCard(
                        child: Text(
                          "Validar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        elevation: null,
                        border_radius: MediaQuery.of(context).size.width,
                        on_pressed: () {
                          if (_controller_vending_machine_id.text != "") {
                            setState(() {
                              widget.update_qr_value(
                                  _controller_vending_machine_id.text);
                            });
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text("Debes ingresar un código"),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        linear_gradient: widget.button_linear_gradient,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                QRView(
                  key: qr_key,
                  onQRViewCreated: (QRViewController controller) {
                    setState(() {
                      this.controller = controller;
                    });
                    controller.scannedDataStream.listen((data_scanned) {
                      setState(() {
                        widget.update_qr_value(data_scanned.code);
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
