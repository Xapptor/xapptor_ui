import 'package:intl/intl.dart';

enum TimeFrame {
  Day,
  Week,
  Month,
  Year,
  Beginning,
}

double get_max_x({
  required TimeFrame timeframe,
}) {
  switch (timeframe) {
    case TimeFrame.Day:
      return 6;
    case TimeFrame.Week:
      return 7;
    case TimeFrame.Month:
      return 4;
    case TimeFrame.Year:
      return 6;
    case TimeFrame.Beginning:
      return 12;
  }
}

DateTime get_timeframe_date({
  required TimeFrame timeframe,
}) {
  DateTime date_now = DateTime.now();
  switch (timeframe) {
    case TimeFrame.Day:
      return DateTime(
        date_now.year,
        date_now.month,
        date_now.day,
        date_now.hour - 24,
      );
    case TimeFrame.Week:
      return DateTime(
        date_now.year,
        date_now.month,
        date_now.day - 7,
      );
    case TimeFrame.Month:
      return DateTime(
        date_now.year,
        date_now.month,
        date_now.day - 30,
      );
    case TimeFrame.Year:
      return DateTime(
        date_now.year,
        date_now.month - 12,
      );

    case TimeFrame.Beginning:
      return DateTime(
        date_now.year - 20,
      );
  }
}

List<String> get_bottom_labels({
  required double max_x,
  required TimeFrame timeframe,
}) {
  DateTime date_now = DateTime.now();
  List<String> bottom_labels = [];

  for (var i = 0; i < max_x; i++) {
    DateTime current_date = date_now;
    String current_label = "";

    switch (timeframe) {
      case TimeFrame.Day:
        current_date = DateTime(
          date_now.year,
          date_now.month,
          date_now.day,
          date_now.hour - (i * 4),
        );
        current_label = DateFormat("h a").format(current_date);
        break;
      case TimeFrame.Week:
        current_date = DateTime(
          date_now.year,
          date_now.month,
          date_now.day - i,
        );
        current_label = DateFormat("d").format(current_date);
        break;
      case TimeFrame.Month:
        current_date = DateTime(
          date_now.year,
          date_now.month,
          date_now.day - (i * 7),
        );
        current_label = DateFormat("d").format(current_date);
        break;
      case TimeFrame.Year:
        current_date = DateTime(
          date_now.year,
          date_now.month - (i * 2),
        );
        current_label = DateFormat("MMM").format(current_date);
        break;
      case TimeFrame.Beginning:
        current_date = DateTime(
          date_now.year - i,
        );
        current_label = DateFormat("YY").format(current_date);
        break;
    }

    bottom_labels.add(current_label);
    print("current_label $current_label");
  }
  return List.from(bottom_labels.reversed);
}

int last_day_of_month(DateTime month) {
  var beginning_next_month = (month.month < 12)
      ? new DateTime(month.year, month.month + 1, 1)
      : new DateTime(month.year + 1, 1, 1);
  return beginning_next_month.subtract(new Duration(days: 1)).day;
}
