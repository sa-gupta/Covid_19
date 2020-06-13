import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LineReportChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),

          lineBarsData: [
            LineChartBarData(
              spots: getSports(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [cPrimaryColor],
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }
}


List<FlSpot> getSports(){
  return [
    FlSpot(0, .5),
    FlSpot(1, 0.7),
    FlSpot(2, 0.9),
    FlSpot(3, 2.5),
    FlSpot(4, 2.7),
    FlSpot(5, 7.5),
    FlSpot(6, 10.5),
    FlSpot(7, 11.5),
    FlSpot(8, 13.5),
    FlSpot(9, 16.5),
  ];
}