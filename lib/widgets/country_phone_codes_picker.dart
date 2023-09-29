import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/country_phone_codes.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';

class CountryPhoneCodesPicker extends StatefulWidget {
  final ValueNotifier<CountryPhoneCode> current_phone_code;
  final Color text_color;
  final Function setState;

  const CountryPhoneCodesPicker({super.key, 
    required this.current_phone_code,
    required this.text_color,
    required this.setState,
  });

  @override
  _CountryPhoneCodesPickerState createState() =>
      _CountryPhoneCodesPickerState();
}

class _CountryPhoneCodesPickerState extends State<CountryPhoneCodesPicker> {
  ScrollController scroll_controller = ScrollController();
  double item_height = 36;
  double alert_height = 0;

  show_alert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool portrait = is_portrait(context);
        double screen_height = MediaQuery.of(context).size.height;
        double screen_width = MediaQuery.of(context).size.width;

        alert_height = screen_height * (portrait ? 0.7 : 0.5);

        return AlertDialog(
          title: const Text("Choose phone country code"),
          content: Container(
            height: alert_height,
            width: screen_width * (portrait ? 1 : 0.3),
            child: ListView.builder(
              controller: scroll_controller,
              shrinkWrap: true,
              itemCount: country_phone_code_list.length,
              cacheExtent: 100,
              itemBuilder: (context, index) {
                return Container(
                  height: item_height,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: widget.current_phone_code.value ==
                                country_phone_code_list[index]
                            ? widget.text_color
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      widget.current_phone_code.value =
                          country_phone_code_list[index];

                      double inital_offset =
                          (item_height * index) - alert_height / 2;

                      scroll_controller =
                          ScrollController(initialScrollOffset: inital_offset);

                      widget.setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text(
                      country_phone_code_list[index].name.split(',').first +
                          ' ' +
                          country_phone_code_list[index].dial_code,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: widget.text_color,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: show_alert,
      child: Text(
        widget.current_phone_code.value.name.split(',').first +
            ' ' +
            widget.current_phone_code.value.dial_code,
        style: TextStyle(
          color: widget.text_color,
        ),
      ),
    );
  }
}
