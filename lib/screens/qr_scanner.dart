import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';
import 'package:xapptor_ui/widgets/check_permission.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
    required this.permission_message,
    required this.permission_message_no,
    required this.permission_message_yes,
    required this.enter_code_text,
    required this.validate_button_text,
    required this.fail_message,
    required this.textfield_color,
    required this.show_main_button,
    required this.main_button_text,
    required this.main_button_function,
  });

  final String descriptive_text;
  final Function(String new_qr_value) update_qr_value;
  final Color border_color;
  final double border_radius;
  final double border_length;
  final double border_width;
  final double cut_out_size;
  final LinearGradient button_linear_gradient;
  final String permission_message;
  final String permission_message_no;
  final String permission_message_yes;
  final String enter_code_text;
  final String validate_button_text;
  final String fail_message;
  final Color textfield_color;
  final bool show_main_button;
  final String main_button_text;
  final Function main_button_function;

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  late MobileScannerController mobile_scanner_controller =
      MobileScannerController();
  TextEditingController _controller_code_id = TextEditingController();

  @override
  void dispose() {
    mobile_scanner_controller.dispose();
    _controller_code_id.dispose();
    super.dispose();
  }

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     mobile_scanner_controller.stop();
  //   } else if (Platform.isIOS) {
  //     mobile_scanner_controller.start();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    check_permission(
      context: context,
      message: widget.permission_message,
      message_no: widget.permission_message_no,
      message_yes: widget.permission_message_yes,
      permission_type: Permission.camera,
    );
  }

  // Show main button on QRScanner.

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
      body: UniversalPlatform.isWeb
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
                    Container(
                      height: 50,
                      width: screen_width / (portrait ? 2 : 8),
                      child: CustomCard(
                        child: Center(
                          child: Text(
                            widget.validate_button_text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        border_radius: MediaQuery.of(context).size.width,
                        on_pressed: () {
                          if (_controller_code_id.text != "") {
                            setState(() {
                              widget.update_qr_value(_controller_code_id.text);
                            });
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text(widget.fail_message),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        linear_gradient: widget.button_linear_gradient,
                      ),
                    ),
                    widget.show_main_button
                        ? Container(
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
                  allowDuplicates: false,
                  controller: mobile_scanner_controller,
                  onDetect: (barcode, args) {
                    if (barcode.rawValue == null) {
                      debugPrint('Failed to scan Barcode');
                    } else {
                      final String code = barcode.rawValue!;
                      setState(() {
                        this.mobile_scanner_controller =
                            mobile_scanner_controller;
                      });
                      widget.update_qr_value(barcode.rawValue!);
                    }
                  },

                  // overlay: QrScannerOverlayShape(
                  //   borderColor: widget.border_color,
                  //   borderRadius: widget.border_radius,
                  //   borderLength: widget.border_length,
                  //   borderWidth: widget.border_width,
                  //   cutOutSize: widget.cut_out_size,
                  // ),
                ),
                Container(
                  child: Column(
                    children: [
                      Spacer(flex: 1),
                      Text(
                        widget.descriptive_text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 18,
                        ),
                      ),
                      Spacer(flex: 6),
                      widget.show_main_button ? main_button() : Container(),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
