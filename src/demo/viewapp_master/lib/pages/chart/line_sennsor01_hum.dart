// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, unused_field, unnecessary_question_mark
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';

class LineViewhum extends StatefulWidget {
  /*圖表色彩設置*/
  const LineViewhum({
    super.key,
    Color? lineColor,
    Color? indicatorLineColor,
    Color? indicatorTouchedLineColor,
    Color? indicatorSpotStrokeColor,
    Color? indicatorTouchedSpotStrokeColor,
    Color? bottomTextColor,
    Color? bottomTouchedTextColor,
    Color? averageLineColor,
    Color? tooltipBgColor,
    Color? tooltipTextColor,
  })  : lineColor = lineColor ?? Colors.orange,
        indicatorLineColor = indicatorLineColor ?? Colors.blue,
        indicatorTouchedLineColor = indicatorTouchedLineColor ?? Colors.yellow,
        indicatorSpotStrokeColor = indicatorSpotStrokeColor ?? Colors.yellow,
        indicatorTouchedSpotStrokeColor =
            indicatorTouchedSpotStrokeColor ?? Colors.blue,
        bottomTextColor = bottomTextColor ?? Colors.black,
        bottomTouchedTextColor = bottomTouchedTextColor ?? Colors.yellow,
        averageLineColor = averageLineColor ?? Colors.green,
        tooltipBgColor = tooltipBgColor ?? Colors.orange,
        tooltipTextColor = tooltipTextColor ?? Colors.black;

  final Color lineColor;
  final Color indicatorLineColor;
  final Color indicatorTouchedLineColor;
  final Color indicatorSpotStrokeColor;
  final Color indicatorTouchedSpotStrokeColor;
  final Color bottomTextColor;
  final Color bottomTouchedTextColor;
  final Color averageLineColor;
  final Color tooltipBgColor;
  final Color tooltipTextColor;

  @override
  State createState() => _LineViewhumState();
}

class _LineViewhumState extends State<LineViewhum> {
  late Future<dynamic> _dataFuture1;
  late Future<List<dynamic>?> _dataFuture2;
  late double touchedValue;
  dynamic? data1;
  List<dynamic>? data2;
  List<String> get datanum => const ['0', '1', '2', '3', '4', '5', '6', '7'];
  bool fitInsideBottomTitle = true;
  bool fitInsideLeftTitle = false;

  @override
  void initState() {
    super.initState();
    touchedValue = -1;
    _dataFuture1 = getData1().then((data) {
      setState(() {
        data1 = data;
      });
    });
    _dataFuture2 = getData2();
  }

  final MaterialStateProperty<Color?> overlayColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Material color when switch is selected.
      if (states.contains(MaterialState.selected)) {
        return Colors.amber.withOpacity(0.54);
      }
      // Material color when switch is disabled.
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade400;
      }
      // Otherwise return null to set default material color
      // for remaining states such as when the switch is
      // hovered, or focused.
      return null;
    },
  );

  //自訂值連線部分
  Future<dynamic> getData1() async {
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final String? username = await PreferencesUtil.getString("username");
    final Uri uri = Uri.http(serverSource!, "/read/UserCustomValueStatus",
        <String, String>{"username": "$username", "ValueName": "customvar01"});
    final response = await http.get(uri);
    final result = response.body;
    final data1 = jsonDecode(result);
    //print(data1);
    return data1;
  }

  //感測器數值連線部分
  Future<List<dynamic>?> getData2() async {
    const String setboards = "Sensor01";
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(serverSource!, "/read/$setboards/hum");
    final response = await http.get(uri);
    final result = response.body;
    final data = jsonDecode(result);
    //print(data);
    data2 = List<dynamic>.from(data);
    return data2;
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value % 1 != 0) {
      return Container();
    }
    const style = TextStyle(
      color: Colors.black,
      fontSize: 10,
    );

    /*SideTitle 刻度*/
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 10:
        text = '10';
        break;
      case 15:
        text = '15';
        break;
      case 20:
        text = '20';
        break;
      case 25:
        text = '25';
        break;
      case 50:
        text = '50';
        break;
      case 100:
        text = '100';
        break;
      case 150:
        text = '150';
        break;
      case 200:
        text = '200';
        break;
      case 250:
        text = '250';
        break;
      case 300:
        text = '300';
        break;
      case 400:
        text = '400';
        break;
      case 500:
        text = '500';
        break;
      case 600:
        text = '600';
        break;
      case 700:
        text = '700';
        break;
      case 800:
        text = '800';
        break;
      case 900:
        text = '900';
        break;
      case 1000:
        text = '1000';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      fitInside: fitInsideLeftTitle
          ? SideTitleFitInsideData.fromTitleMeta(meta)
          : SideTitleFitInsideData.disable(),
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final isTouched = value == touchedValue;
    final style = TextStyle(
      color: isTouched ? widget.bottomTouchedTextColor : widget.bottomTextColor,
      fontWeight: FontWeight.bold,
    );

    if (value % 1 != 0) {
      return Container();
    }
    return SideTitleWidget(
      space: 7,
      axisSide: meta.axisSide,
      fitInside: fitInsideBottomTitle
          ? SideTitleFitInsideData.fromTitleMeta(meta, distanceFromEdge: 0)
          : SideTitleFitInsideData.disable(),
      child: Text(
        datanum[value.toInt()],
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var customValue = (data1?["customvar01"] as int?) ?? 0.0;
    final doubleValue0 = data2?[0]["hum"]?.toDouble() ?? 0.0;
    final doubleValue1 = data2?[1]["hum"]?.toDouble() ?? 0.0;
    final doubleValue2 = data2?[2]["hum"]?.toDouble() ?? 0.0;
    final doubleValue3 = data2?[3]["hum"]?.toDouble() ?? 0.0;
    final doubleValue4 = data2?[4]["hum"]?.toDouble() ?? 0.0;
    final doubleValue5 = data2?[5]["hum"]?.toDouble() ?? 0.0;
    final doubleValue6 = data2?[6]["hum"]?.toDouble() ?? 0.0;
    final doubleValue7 = data2?[7]["hum"]?.toDouble() ?? 0.0;
    List<double> yValues = [
      doubleValue0,
      doubleValue1,
      doubleValue2,
      doubleValue3,
      doubleValue4,
      doubleValue5,
      doubleValue6,
      doubleValue7
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 5),
        //標頭顯示
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'User Custom Value',
              style: TextStyle(
                color: widget.averageLineColor.withOpacity(1),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              ' & ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'Sensor Data',
              style: TextStyle(
                color: widget.indicatorLineColor.withOpacity(1),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        AspectRatio(
          aspectRatio: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 12),
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  getTouchedSpotIndicator:
                      (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map((spotIndex) {
                      final spot = barData.spots[spotIndex];
                      if (spot.x == 0 || spot.x == 200) {
                        return null;
                      }
                      return TouchedSpotIndicatorData(
                        FlLine(
                          color: widget.indicatorTouchedLineColor,
                          strokeWidth: 5,
                        ),
                        FlDotData(
                          getDotPainter: (spot, percent, barData, index) {
                            if (index.isEven) {
                              return FlDotCirclePainter(
                                radius: 10,
                                color: Colors.white,
                                strokeWidth: 8,
                                strokeColor:
                                    widget.indicatorTouchedSpotStrokeColor,
                              );
                            } else {
                              return FlDotSquarePainter(
                                size: 20,
                                color: Colors.white,
                                strokeWidth: 8,
                                strokeColor:
                                    widget.indicatorTouchedSpotStrokeColor,
                              );
                            }
                          },
                        ),
                      );
                    }).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: widget.tooltipBgColor,
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        final flSpot = barSpot;
                        if (flSpot.x == 0 || flSpot.x == 200) {
                          return null;
                        }

                        TextAlign textAlign;
                        switch (flSpot.x.toInt()) {
                          case 1:
                            textAlign = TextAlign.left;
                            break;
                          case 5:
                            textAlign = TextAlign.right;
                            break;
                          default:
                            textAlign = TextAlign.center;
                        }

                        /*當手按到折線上時*/
                        return LineTooltipItem(
                          '${datanum[flSpot.x.toInt()]} \n',
                          TextStyle(
                            color: widget.tooltipTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: flSpot.y.toString(),
                              style: TextStyle(
                                color: widget.tooltipTextColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const TextSpan(
                              text: '(value)',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                          textAlign: textAlign,
                        );
                      }).toList();
                    },
                  ),
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? lineTouch) {
                    if (!event.isInterestedForInteractions ||
                        lineTouch == null ||
                        lineTouch.lineBarSpots == null) {
                      setState(() {
                        touchedValue = -1;
                      });
                      return;
                    }
                    final value = lineTouch.lineBarSpots![0].x;

                    if (value == 0 || value == 15) {
                      setState(() {
                        touchedValue = -1;
                      });
                      return;
                    }

                    setState(() {
                      touchedValue = value;
                    });
                  },
                ),
                /*使用者自訂值線*/
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: customValue.toDouble(),
                      color: widget.averageLineColor,
                      strokeWidth: 3,
                      dashArray: [20, 10],
                    ),
                  ],
                ),
                lineBarsData: [
                  LineChartBarData(
                    isStepLineChart: true,
                    spots: yValues.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value);
                    }).toList(),
                    isCurved: false,
                    barWidth: 5,
                    color: widget.lineColor,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          widget.lineColor.withOpacity(0.5),
                          widget.lineColor.withOpacity(0),
                        ],
                        stops: const [0.5, 1.0],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      spotsLine: BarAreaSpotsLine(
                        show: true,
                        flLineStyle: FlLine(
                          color: widget.indicatorLineColor,
                          strokeWidth: 2,
                        ),
                        checkToShowSpotLine: (spot) {
                          if (spot.x == 0 || spot.x == 10) {
                            return false;
                          }
                          return true;
                        },
                      ),
                    ),
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        if (index.isEven) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: Colors.white,
                            strokeWidth: 3,
                            strokeColor: widget.indicatorSpotStrokeColor,
                          );
                        } else {
                          return FlDotSquarePainter(
                            size: 12,
                            color: Colors.white,
                            strokeWidth: 3,
                            strokeColor: widget.indicatorSpotStrokeColor,
                          );
                        }
                      },
                      //點的數量
                      checkToShowDot: (spot, barData) {
                        return spot.x != 0 && spot.x != 10;
                      },
                    ),
                  ),
                ],
                minY: 0,
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                  checkToShowHorizontalLine: (value) => value % 1 == 0,
                  checkToShowVerticalLine: (value) => value % 1 == 0,
                  getDrawingHorizontalLine: (value) {
                    if (value == 0) {
                      return const FlLine(
                        color: Colors.orange,
                        strokeWidth: 2,
                      );
                    } else {
                      return const FlLine(
                        color: Colors.black,
                        strokeWidth: 0.5,
                      );
                    }
                  },
                  getDrawingVerticalLine: (value) {
                    if (value == 0) {
                      return const FlLine(
                        color: Colors.redAccent,
                        strokeWidth: 10,
                      );
                    } else {
                      return const FlLine(
                        color: Colors.black,
                        strokeWidth: 0.5,
                      );
                    }
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 46,
                      getTitlesWidget: leftTitleWidgets,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            const Text('Fit Inside Title Option'),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Left Title'),
                Switch(
                  value: fitInsideLeftTitle,
                  onChanged: (value) => setState(() {
                    fitInsideLeftTitle = value;
                  }),
                  overlayColor: overlayColor,
                  thumbColor:
                      const MaterialStatePropertyAll<Color>(Colors.black),
                  inactiveTrackColor: Colors.green,
                ),
                const Text('Bottom Title'),
                Switch(
                  value: fitInsideBottomTitle,
                  onChanged: (value) => setState(() {
                    fitInsideBottomTitle = value;
                  }),
                  overlayColor: overlayColor,
                  thumbColor:
                      const MaterialStatePropertyAll<Color>(Colors.black),
                  inactiveTrackColor: Colors.green,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
