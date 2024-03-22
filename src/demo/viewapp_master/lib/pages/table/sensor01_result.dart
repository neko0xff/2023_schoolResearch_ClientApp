// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';

class Sensor01Result extends StatefulWidget {
  const Sensor01Result({super.key});

  @override
  _Sensor01ResultState createState() => _Sensor01ResultState();
}

class _Sensor01ResultState extends State<Sensor01Result> {
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  Future<Map<String, dynamic>> getData() async {
    final String? serverSource =
    await PreferencesUtil.getString("serverSource");
    final String? username = await PreferencesUtil.getString("username");
    final Uri uri = Uri.http(serverSource!, "/read/UsersComparisonResult");
    final response = await http.post(uri, body: {
      "username": username,
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
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
      ],
    );
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
                Text(data["comparison_result_temp"] == 0 ? "標準" : "超標", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('hum', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text(data["comparison_result_hum"] == 0 ? "標準" : "超標", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('tvoc', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text(data["comparison_result_tvoc"] == 0 ? "標準" : "超標", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('co', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text(data["comparison_result_co"] == 0 ? "標準" : "超標", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('co2', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text(data["comparison_result_co2"] == 0 ? "標準" : "超標", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('PM2.5', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text(data["comparison_result_pm25"] == 0 ? "標準" : "超標", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                const Text('O3', style: TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text(data["comparison_result_o3"] == 0 ? "標準" : "超標", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
