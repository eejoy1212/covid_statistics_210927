import 'package:covid_statistics_210927/model/covid_statistics.dart';
import 'package:covid_statistics_210927/utils/data_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatelessWidget {
  final List<Covid19StatisticsModel> covidDatas;
  final double maxY;
  const CovidBarChart({Key? key, required this.maxY, required this.covidDatas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return BarChart(
      BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY * 1.3,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.transparent,
              tooltipPadding: const EdgeInsets.all(0),
              tooltipMargin: 8,
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  rod.y.round().toString(),
                  TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            topTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (context, value) => const TextStyle(
                  color: Color(0xFF00050A),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              margin: 20,
              getTitles: (double value) {
                return DataUtils.simpleDayFormat(
                    covidDatas[value.toInt()].stateDt!);
              },
            ),
            leftTitles: SideTitles(showTitles: false),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: this.covidDatas.map<BarChartGroupData>((covidData) {
            return BarChartGroupData(
              x: x++,
              barRods: [
                BarChartRodData(y: covidData.calcDecideCnt, colors: [
                  Color(0xFF35BBE4),
                  Color(0xFFC84FE0),
                  Color(0xFFF01010),
                ])
              ],
              showingTooltipIndicators: [0],
            );
          }).toList()),
    );
  }
}
