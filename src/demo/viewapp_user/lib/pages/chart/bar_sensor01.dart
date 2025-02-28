// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_user/modules/PreferencesUtil.dart';

class BarView1 extends StatefulWidget {
  const BarView1({super.key});

  @override
  State<StatefulWidget> createState() => _BarChartView1State();
}

class _BarChartView1State extends State<BarView1> {
  late Future<Map<String, dynamic>?> _dataFuture;
  Map<String, dynamic>? _data;

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  //連線部分
  Future<Map<String, dynamic>?> getData() async {
    const String setboards = "Sensor01";
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(serverSource!, "/read/$setboards/ALL");
    final response = await http.get(uri);
    final result = response.body;
    final data = jsonDecode(result);
    //print(data[0]);
    _data = Map<String, dynamic>.from(data[0]);
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _dataFuture,
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return view(data);
        } else {
          return const Text('No data available.');
        }
      },
    );
  }

  Widget view(Map<String, dynamic> data) {
    return Column(
      children: <Widget>[
        UpdateDay(data),
        AspectRatio(aspectRatio: 1.6, child: bar1(context, data))
      ],
    );
  }

  Widget UpdateDay(Map<String, dynamic> data) {
    return Center(
        child: Column(
      children: <Widget>[
        Text("Update Time", style: TextStyle(fontSize: 20)),
        Text("Date= ${data["date"]}", style: TextStyle(fontSize: 20)),
        Text("Time= ${data["time"]}", style: TextStyle(fontSize: 20)),
      ],
    ));
  }

  /*折線圖*/
  Widget bar1(BuildContext context, Map<String, dynamic> data) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 2000,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  //文字
  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Temp';
        break;
      case 1:
        text = 'Hum';
        break;
      case 2:
        text = 'TVOC';
        break;
      case 3:
        text = 'CO';
        break;
      case 4:
        text = 'CO2';
        break;
      case 5:
        text = 'PM2.5';
        break;
      case 6:
        text = 'O3';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  //數值
  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: (_data!["temp"]?.toDouble() ?? 0).toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: (_data!["hum"]?.toDouble() ?? 0).toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: (_data!["tvoc"]?.toDouble() ?? 0).toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: (_data!["co"]?.toDouble() ?? 0).toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: (_data!["co2"]?.toDouble() ?? 0).toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: (_data!["pm25"]?.toDouble() ?? 0).toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: (_data!["o3"]?.toDouble() ?? 0).toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
