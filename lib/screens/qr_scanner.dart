// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';
import 'package:xapptor_ui/widgets/check_permission.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:xapptor_ui/utils/get_platform_name.dart';
import 'package:xapptor_ui/utils/get_browser_name.dart';

class QRScanner extends StatefulWidget {
  final String descriptive_text;
  final Function(String new_qr_value) update_qr_value;
  final Color border_color;
  final double border_radius;
  final double border_length;
  final double border_width;
  final double cut_out_size;
  final LinearGradient button_linear_gradient;
  final String permission_title;
  final String permission_label_no;
  final String permission_label_yes;
  final String enter_code_text;
  final String validate_button_text;
  final String fail_message;
  final Color textfield_color;
  final bool show_main_button;
  final String main_button_text;
  final Function main_button_function;
  final bool use_manual_mode;

  const QRScanner({
    super.key,
    required this.descriptive_text,
    required this.update_qr_value,
    required this.border_color,
    required this.border_radius,
    required this.border_length,
    required this.border_width,
    required this.cut_out_size,
    required this.button_linear_gradient,
    required this.permission_title,
    required this.permission_label_no,
    required this.permission_label_yes,
    required this.enter_code_text,
    required this.validate_button_text,
    required this.fail_message,
    required this.textfield_color,
    required this.show_main_button,
    required this.main_button_text,
    required this.main_button_function,
    this.use_manual_mode = false,
  });

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  late MobileScannerController mobile_scanner_controller = MobileScannerController();
  final TextEditingController _controller_code_id = TextEditingController();

  @override
  void dispose() {
    mobile_scanner_controller.dispose();
    _controller_code_id.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _call_check_permission();
  }

  _call_check_permission() async {
    check_permission(
      platform_name: get_platform_name(),
      browser_name: await get_browser_name(),
      context: context,
      title: widget.permission_title,
      label_no: widget.permission_label_no,
      label_yes: widget.permission_label_yes,
      permission_type: Permission.camera,
    );
  }

  Widget main_button() {
    return TextButton(
      onPressed: () => widget.main_button_function(),
      child: Text(
        widget.main_button_text,
        style: TextStyle(
          color: widget.border_color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);
    double screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: widget.use_manual_mode
          ? Center(
              child: FractionallySizedBox(
                widthFactor: portrait ? 0.7 : 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.textfield_color,
                        fontSize: 18,
                      ),
                      controller: _controller_code_id,
                      decoration: InputDecoration(
                        hintText: widget.enter_code_text,
                        hintStyle: TextStyle(
                          color: widget.textfield_color,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sized_box_space * 2,
                    ),
                    SizedBox(
                      height: 50,
                      width: screen_width / (portrait ? 2 : 8),
                      child: CustomCard(
                        border_radius: MediaQuery.of(context).size.width,
                        on_pressed: () {
                          if (_controller_code_id.text != "") {
                            setState(() {
                              widget.update_qr_value(_controller_code_id.text);
                            });
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text(widget.fail_message),
                              duration: const Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        linear_gradient: widget.button_linear_gradient,
                        child: Center(
                          child: Text(
                            widget.validate_button_text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    widget.show_main_button
                        ? SizedBox(
                            height: 50,
                            child: main_button(),
                          )
                        : Container(),
                  ],
                ),
              ),
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(
                  controller: mobile_scanner_controller,
                  onDetect: (BarcodeCapture barcodes) {
                    //debugPrint(barcodes.raw.toString());

                    if (barcodes.raw == null) {
                      debugPrint('Failed to scan Barcode');
                    } else {
                      String? code = "";

                      if (UniversalPlatform.isWeb) {
                        code = barcodes.barcodes.firstOrNull?.rawValue;
                      } else {
                        code = barcodes.barcodes.firstOrNull?.displayValue;
                      }
                      setState(() {
                        mobile_scanner_controller = mobile_scanner_controller;
                      });
                      widget.update_qr_value(code ?? "");
                    }
                  },
                  overlayBuilder: (context, constraints) {
                    return Container(
                      height: widget.cut_out_size,
                      width: widget.cut_out_size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.border_radius),
                        border: Border.all(
                          color: widget.border_color,
                          width: widget.border_width,
                        ),
                      ),
                    );
                  },
                ),
                Column(
                  children: [
                    const Spacer(flex: 1),
                    Text(
                      widget.descriptive_text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(flex: 6),
                    widget.show_main_button ? main_button() : Container(),
                    const Spacer(flex: 1),
                  ],
                ),
              ],
            ),
    );
  }
}
