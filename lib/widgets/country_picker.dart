import 'package:flutter/material.dart';
import 'package:xapptor_ui/values/country/country.dart';
import 'package:xapptor_ui/utils/is_portrait.dart';

enum CountryPickerType {
  name,
  phone,
}

class CountryPicker extends StatefulWidget {
  final CountryPickerType country_picker_type;
  final ValueNotifier<Country> current_phone_code;
  final Color text_color;
  final Function setState;

  const CountryPicker({
    super.key,
    required this.country_picker_type,
    required this.current_phone_code,
    required this.text_color,
    required this.setState,
  });

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  ScrollController scroll_controller = ScrollController();
  double item_height = 36;
  double alert_height = 0;

  show_alert() {
    String alert_title =
        widget.country_picker_type == CountryPickerType.name ? 'Choose country' : 'Choose phone country code';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool portrait = is_portrait(context);
        double screen_height = MediaQuery.of(context).size.height;
        double screen_width = MediaQuery.of(context).size.width;

        alert_height = screen_height * (portrait ? 0.7 : 0.5);

        return AlertDialog(
          title: Text(alert_title),
          content: SizedBox(
            height: alert_height,
            width: screen_width * (portrait ? 1 : 0.3),
            child: ListView.builder(
              controller: scroll_controller,
              shrinkWrap: true,
              itemCount: countries_list.length,
              cacheExtent: 100,
              itemBuilder: (context, index) {
                String text_button_label = widget.country_picker_type == CountryPickerType.name
                    ? countries_list[index].name
                    : '${countries_list[index].name.split(',').first} ${countries_list[index].dial_code}';

                return Container(
                  height: item_height,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: widget.current_phone_code.value == countries_list[index]
                            ? widget.text_color
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      widget.current_phone_code.value = countries_list[index];

                      double inital_offset = (item_height * index) - alert_height / 2;

                      scroll_controller = ScrollController(initialScrollOffset: inital_offset);

                      widget.setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text(
                      text_button_label,
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
    String text_button_label = widget.country_picker_type == CountryPickerType.name
        ? widget.current_phone_code.value.name
        : '${widget.current_phone_code.value.name.split(',').first} ${widget.current_phone_code.value.dial_code}';

    return TextButton(
      onPressed: show_alert,
      child: Text(
        text_button_label,
        style: TextStyle(
          color: widget.text_color,
        ),
      ),
    );
  }
}
