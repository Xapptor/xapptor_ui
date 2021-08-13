import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:xapptor_logic/firebase_tasks.dart';
import 'package:xapptor_ui/models/lum/payments.dart';
import 'package:xapptor_ui/models/lum/product.dart';
import 'package:xapptor_ui/models/lum/vending_machine.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xapptor_ui/widgets/timeframe_chart_functions.dart';

class AdminAnalytics extends StatefulWidget {
  @override
  _AdminAnalyticsState createState() => _AdminAnalyticsState();
}

class _AdminAnalyticsState extends State<AdminAnalytics> {
  String user_id = "";

  static List<String> timeframe_values = [
    "Del último día",
    "De la última semana",
    "Del último mes",
    "Del último año",
    "Desde el inicio",
  ];
  String timeframe_value = timeframe_values[3];
  TimeFrame current_timeframe = TimeFrame.Year;

  List<VendingMachine> vending_machines = [];
  List<String> vending_machine_values = [""];
  String vending_machine_value = "";

  static List<String> dispenser_values =
      List<String>.generate(10, (i) => "Dispensador ${(i + 1)}");
  String dispenser_value = dispenser_values.first;

  List<Product> products = [];
  List<String> product_values = [""];
  String product_value = "";

  List<Payment> payments = [];
  List<Payment> filtered_payments = [];

  List<Map<String, dynamic>> sum_of_payments_per_day = [];

  @override
  void initState() {
    super.initState();
    get_vending_machines();
    // duplicate_document(
    //   document_id: "72CkPp1jPJiaW3TqcAH4",
    //   collection_id: "payments",
    //   times: 3,
    // );
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
        get_filtered_payments();
      });
    }
  }

  get_filtered_payments() {
    filtered_payments.clear();
    filtered_payments = payments
        .where(
          (payment) => payment.date.isAfter(
            get_timeframe_date(timeframe: current_timeframe),
          ),
        )
        .where(
          (payment) =>
              payment.vending_machine_id ==
              vending_machines[
                      vending_machine_values.indexOf(vending_machine_value)]
                  .id,
        )
        .where(
          (payment) =>
              payment.dispenser ==
              (int.parse(dispenser_value.characters.last) - 1),
        )
        .where(
          (payment) =>
              payment.product_id ==
              products[product_values.indexOf(product_value)].id,
        )
        .toList();

    filtered_payments.sort((a, b) => a.date.compareTo(b.date));
    print("filtered_payments:");
    for (var filtered_payment in filtered_payments) {
      print(filtered_payment.to_json());
    }
    get_sum_of_payments();
  }

  get_sum_of_payments() {
    sum_of_payments_per_day.clear();
    for (var filtered_payment in filtered_payments) {
      if (sum_of_payments_per_day.isEmpty) {
        sum_of_payments_per_day.add({
          "date": filtered_payment.date,
          "amount": filtered_payment.amount,
        });
      } else {
        bool payment_was_made_at_same_timeframe = false;

        bool same_hour = filtered_payment.date.hour ==
            sum_of_payments_per_day.last["date"].hour;

        bool same_day = filtered_payment.date.day ==
            sum_of_payments_per_day.last["date"].day;

        bool same_month = filtered_payment.date.month ==
            sum_of_payments_per_day.last["date"].month;

        bool same_year = filtered_payment.date.year ==
            sum_of_payments_per_day.last["date"].year;

        switch (current_timeframe) {
          case TimeFrame.Day:
            if (same_hour && same_day && same_month && same_year)
              payment_was_made_at_same_timeframe = true;
            break;
          case TimeFrame.Week:
            if (same_day && same_month && same_year)
              payment_was_made_at_same_timeframe = true;
            break;
          case TimeFrame.Month:
            if (same_day && same_month && same_year)
              payment_was_made_at_same_timeframe = true;
            break;
          case TimeFrame.Year:
            if (same_month && same_year)
              payment_was_made_at_same_timeframe = true;
            break;
          case TimeFrame.Beginning:
            payment_was_made_at_same_timeframe = true;
            break;
        }

        if (payment_was_made_at_same_timeframe) {
          sum_of_payments_per_day.last["amount"] += filtered_payment.amount;
        } else {
          sum_of_payments_per_day.add({
            "date": filtered_payment.date,
            "amount": filtered_payment.amount,
          });
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: sized_box_space * 3,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(
                      'Analíticas de ventas',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: color_lum_light_pink,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        //
                      },
                      icon: Icon(
                        Typicons.down_outline,
                        color: color_lum_light_pink,
                      ),
                    ),
                  ),
                ],
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
                              get_filtered_payments();
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
                              get_filtered_payments();
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
                              get_filtered_payments();
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
                              get_filtered_payments();
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
      color_lum_green,
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
