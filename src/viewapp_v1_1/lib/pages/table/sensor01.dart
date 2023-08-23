// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1_1/modules/PreferencesUtil.dart';

class SensorTable1 extends StatefulWidget {
  const SensorTable1({Key? key}) : super(key: key);

  @override
  _SensorTable1State createState() => _SensorTable1State();
}

class _SensorTable1State extends State<SensorTable1> {
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  Future<Map<String, dynamic>> getData() async {
    const String setboards = "Sensor01";
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(serverSource!, "/read/$setboards/ALL");
    final response = await http.get(uri);
    final result = response.body;
    final data = jsonDecode(result);
    print(data[0]);
    return Map<String, dynamic>.from(data[0]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _dataFuture,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data!;
          return view(data);
        }
      },
    );
  }

  Widget view(Map<String, dynamic> data) {
    return Column(
      children: <Widget>[
        output(data),
        UpdateDay(data),
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

  Widget output(Map<String, dynamic> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20.0,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              '感測氣體',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              '回傳值',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: [
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('temp', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text('${data["temp"]}', style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('hum', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text('${data["hum"]}', style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('tvoc', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text('${data["tvoc"]}', style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('co', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text('${data["co"]}', style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('co2', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text('${data["co2"]}', style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('PM2.5', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text('${data["pm25"]}', style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('O3', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text('${data["o3"]}', style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
