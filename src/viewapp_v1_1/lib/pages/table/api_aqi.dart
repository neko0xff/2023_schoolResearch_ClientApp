// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1_1/modules/PreferencesUtil.dart';

class AqiTable extends StatefulWidget {
  const AqiTable({Key? key}) : super(key: key);

  @override
  _AqiTableState createState() => _AqiTableState();
}

class _AqiTableState extends State<AqiTable> {
  late Future<List<Map<String, dynamic>>> _dataFuture;
  final List<String> columns = ['測站編號', '地點', 'AQI'];

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  Future<List<Map<String, dynamic>>> getData() async {
    const String setLocal = "板橋";
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final Uri uri =
        Uri.http(serverSource!, "/crawler/AQI/site", {"sitename": setLocal});
    final response = await http.get(uri);
    final result = response.body;
    final jsonData = jsonDecode(result);
    return List<Map<String, dynamic>>.from(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
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

  Widget view(List<dynamic> data) {
    return Column(
      children: <Widget>[
        UpdateDay(data),
        output(data),
      ],
    );
  }

  Widget UpdateDay(List<dynamic> data) {
    return Center(
        child: Column(
      children: <Widget>[
        Text("Update Time", style: TextStyle(fontSize: 20)),
        Text("Date= ${data[0]["monitordate"].toString()}",
            style: TextStyle(fontSize: 20)),
      ],
    ));
  }

  Widget output(List<dynamic> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              '編號',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              '地點',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'AQI',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: List<DataRow>.generate(
          data.length,
          (index) => DataRow(
            cells: <DataCell>[
              DataCell(
                Text(data[0]["siteid"].toString(),
                    style: const TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text(data[0]["sitename"].toString(),
                    style: const TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text(data[0]["aqi"].toString(),
                    style: const TextStyle(fontSize: 25)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
