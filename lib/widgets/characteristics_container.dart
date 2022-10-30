import 'package:flutter/material.dart';
import 'characteristics_container_item.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';

class CharacteristicsContainer extends StatefulWidget {
  const CharacteristicsContainer({
    required this.texts,
  });

  final List<String> texts;

  @override
  _CharacteristicsContainerState createState() =>
      _CharacteristicsContainerState();
}

class _CharacteristicsContainerState extends State<CharacteristicsContainer> {
  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);
    double fractional_Factor = 0.5;

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Flex(
        direction: portrait ? Axis.vertical : Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).primaryColor,
                    child: FractionallySizedBox(
                      heightFactor: fractional_Factor,
                      widthFactor: fractional_Factor,
                      child: CharacteristicsContainerItem(
                        title: widget.texts[0],
                        description: widget.texts[1],
                        icon: Icons.show_chart,
                        color: Theme.of(context).primaryColor,
                        title_color: Colors.white,
                        subtitle_color: Colors.white,
                        icon_color: Colors.orange.shade300,
                        side_icon: false,
                        large_description: false,
                        align_to_left_description: false,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).primaryColor,
                    child: FractionallySizedBox(
                      heightFactor: 0.5,
                      widthFactor: 0.5,
                      child: CharacteristicsContainerItem(
                        title: widget.texts[2],
                        description: widget.texts[3],
                        icon: Icons.hourglass_empty,
                        color: Theme.of(context).primaryColor,
                        title_color: Colors.white,
                        subtitle_color: Colors.white,
                        icon_color: Colors.orange.shade300,
                        side_icon: false,
                        large_description: false,
                        align_to_left_description: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.lightBlueAccent,
                    child: FractionallySizedBox(
                      heightFactor: 0.5,
                      widthFactor: 0.5,
                      child: CharacteristicsContainerItem(
                        title: widget.texts[4],
                        description: widget.texts[5],
                        icon: Icons.people,
                        color: Colors.lightBlueAccent,
                        title_color: Colors.white,
                        subtitle_color: Colors.white,
                        icon_color: Colors.orange.shade300,
                        side_icon: false,
                        large_description: false,
                        align_to_left_description: false,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).primaryColor,
                    child: FractionallySizedBox(
                      heightFactor: 0.5,
                      widthFactor: 0.5,
                      child: CharacteristicsContainerItem(
                        title: widget.texts[6],
                        description: widget.texts[7],
                        icon: Icons.record_voice_over,
                        color: Theme.of(context).primaryColor,
                        title_color: Colors.white,
                        subtitle_color: Colors.white,
                        icon_color: Colors.orange.shade300,
                        side_icon: false,
                        large_description: false,
                        align_to_left_description: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
