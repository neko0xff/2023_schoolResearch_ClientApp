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
    return Scaffold(
      appBar: AppBar(
        title: const Text('AQI Table'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error loading data');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No data available');
          } else {
            return buildAqiTable(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget buildAqiTable(List<Map<String, dynamic>> data) {
    double screenWidth = MediaQuery.of(context).size.width;
    int maxColumns = (screenWidth / 100).floor(); // Adjust this value as needed

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: List<DataColumn>.generate(
          maxColumns,
          (index) => DataColumn(
            label: Text(
              data[index % data.length]
                  ['測站編號'], // Use data from the API response
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        rows: List<DataRow>.generate(
          data.length,
          (rowIndex) => DataRow(
            cells: List<DataCell>.generate(
              maxColumns,
              (colIndex) => DataCell(
                Text(
                  data[rowIndex][data[colIndex % data.length]['地點']]
                      .toString(), // Use data from the API response
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
