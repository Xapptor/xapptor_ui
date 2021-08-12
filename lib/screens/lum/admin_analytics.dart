import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xapptor_ui/models/lum/payments.dart';
import 'package:xapptor_ui/models/lum/product.dart';
import 'package:xapptor_ui/models/lum/vending_machine.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum TimeFrame {
  Day,
  Week,
  Month,
  Year,
  Beginning,
}

class AdminAnalytics extends StatefulWidget {
  @override
  _AdminAnalyticsState createState() => _AdminAnalyticsState();
}

class _AdminAnalyticsState extends State<AdminAnalytics> {
  String user_id = "";

  List<String> timeframe_values = [
    "Del último día",
    "De la última semana",
    "Del último mes",
    "Del último año",
    "Desde el inicio",
  ];

  String timeframe_value = "Del último día";

  TimeFrame current_timeframe = TimeFrame.Day;

  List<VendingMachine> vending_machines = [];
  List<String> vending_machine_values = [""];
  String vending_machine_value = "";

  List<String> dispenser_values =
      List<String>.generate(10, (i) => "Dispensador ${(i + 1)}");
  String dispenser_value = "Dispensador 1";

  List<Product> products = [];
  List<String> product_values = [""];
  String product_value = "";
  List<Payment> payments = [];

  @override
  void initState() {
    super.initState();
    get_vending_machines();
  }

  get_vending_machines() async {
    vending_machines.clear();
    vending_machine_values.clear();

    user_id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('vending_machines')
        .where(
          'user_id',
          isEqualTo: user_id,
        )
        .get()
        .then((QuerySnapshot query_snapshot) {
      query_snapshot.docs.forEach((DocumentSnapshot doc) {
        vending_machines.add(
          VendingMachine.from_snapshot(
            doc.id,
            doc.data() as Map<String, dynamic>,
          ),
        );
        vending_machine_values.add(vending_machines.last.name);
      });
      vending_machine_value = vending_machine_values.first;
      get_products();
    });
  }

  get_products() async {
    products.clear();
    product_values.clear();
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((snapshot_products) {
      for (var snapshot_product in snapshot_products.docs) {
        products.add(Product.from_snapshot(
          snapshot_product.id,
          snapshot_product.data(),
        ));
        product_values.add(products.last.name);
      }
      product_value = product_values.first;
      get_payments();
    });
  }

  get_payments() async {
    for (var vending_machine in vending_machines) {
      await FirebaseFirestore.instance
          .collection('payments')
          .where(
            'vending_machine_id',
            isEqualTo: vending_machine.id,
          )
          .get()
          .then((QuerySnapshot query_snapshot) {
        query_snapshot.docs.forEach((DocumentSnapshot doc) {
          payments.add(
            Payment.from_snapshot(
              doc.id,
              doc.data() as Map<String, dynamic>,
            ),
          );
        });
        print(payments.first.to_json());
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: sized_box_space * 3,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Analíticas de ventas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color_lum_light_pink,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: sized_box_space * 2,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: DropdownButton<String>(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: color_lum_light_pink,
                          ),
                          value: timeframe_value,
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          style: TextStyle(
                            color: color_lum_light_pink,
                          ),
                          underline: Container(
                            height: 1,
                            color: color_lum_light_pink,
                          ),
                          onChanged: (new_value) {
                            setState(() {
                              timeframe_value = new_value!;
                              switch (
                                  timeframe_values.indexOf(timeframe_value)) {
                                case 0:
                                  current_timeframe = TimeFrame.Day;
                                  break;
                                case 1:
                                  current_timeframe = TimeFrame.Week;
                                  break;
                                case 2:
                                  current_timeframe = TimeFrame.Month;
                                  break;
                                case 3:
                                  current_timeframe = TimeFrame.Year;
                                  break;
                                case 4:
                                  current_timeframe = TimeFrame.Beginning;
                                  break;
                              }
                            });
                          },
                          items: timeframe_values
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Spacer(flex: 1),
                      Expanded(
                        flex: 10,
                        child: DropdownButton<String>(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: color_lum_light_pink,
                          ),
                          value: vending_machine_value,
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          style: TextStyle(
                            color: color_lum_light_pink,
                          ),
                          underline: Container(
                            height: 1,
                            color: color_lum_light_pink,
                          ),
                          onChanged: (new_value) {
                            setState(() {
                              vending_machine_value = new_value!;
                            });
                          },
                          items: vending_machine_values
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 10,
                        child: DropdownButton<String>(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: color_lum_light_pink,
                          ),
                          value: dispenser_value,
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          style: TextStyle(
                            color: color_lum_light_pink,
                          ),
                          underline: Container(
                            height: 1,
                            color: color_lum_light_pink,
                          ),
                          onChanged: (new_value) {
                            setState(() {
                              dispenser_value = new_value!;
                            });
                          },
                          items: dispenser_values
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Spacer(flex: 1),
                      Expanded(
                        flex: 10,
                        child: DropdownButton<String>(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: color_lum_light_pink,
                          ),
                          value: product_value,
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          style: TextStyle(
                            color: color_lum_light_pink,
                          ),
                          underline: Container(
                            height: 1,
                            color: color_lum_light_pink,
                          ),
                          onChanged: (new_value) {
                            setState(() {
                              product_value = new_value!;
                            });
                          },
                          items: product_values
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: sized_box_space * 2,
              ),
              Container(
                height: screen_height / 3,
                width: screen_width,
                child: LineChart(
                  MainLineChart(timeframe: current_timeframe),
                  swapAnimationDuration: const Duration(milliseconds: 250),
                ),
              ),
              SizedBox(
                height: sized_box_space,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

LineChartData MainLineChart({
  required TimeFrame timeframe,
}) {
  double max_x = get_max_x(timeframe: timeframe);
  List<String> bottom_labels = get_bottom_labels(
    max_x: max_x,
    timeframe: timeframe,
  );

  return LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blue.withOpacity(0.8),
      ),
      touchCallback: (LineTouchResponse touchResponse) {},
      handleBuiltInTouches: true,
    ),
    gridData: FlGridData(
      show: true,
    ),
    titlesData: FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 0,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        margin: 10,
        getTitles: (value) {
          return bottom_labels[value.toInt()];
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '1m';
            case 2:
              return '2m';
            case 3:
              return '3m';
            case 4:
              return '5m';
          }
          return '';
        },
        margin: 8,
        reservedSize: 0,
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: const Border(
        bottom: BorderSide(
          color: Color(0xff4e4965),
          width: 4,
        ),
        left: BorderSide(
          color: Colors.transparent,
        ),
        right: BorderSide(
          color: Colors.transparent,
        ),
        top: BorderSide(
          color: Colors.transparent,
        ),
      ),
    ),
    minX: 0,
    maxX: max_x,
    maxY: 4,
    minY: 0,
    lineBarsData: linesBarData1(),
  );
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

List<LineChartBarData> linesBarData1() {
  final lineChartBarData1 = LineChartBarData(
    spots: [
      FlSpot(1, 1),
      FlSpot(3, 1.5),
      FlSpot(5, 1.4),
      FlSpot(7, 3.4),
      FlSpot(10, 2),
      FlSpot(12, 2.2),
      FlSpot(13, 1.8),
    ],
    isCurved: true,
    colors: [
      const Color(0xff4af699),
    ],
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
  );
  return [
    lineChartBarData1,
  ];
}
