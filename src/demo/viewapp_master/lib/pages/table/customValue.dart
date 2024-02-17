// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';

class customvarTable extends StatefulWidget {
  const customvarTable({super.key});

  @override
  _customvarTableState createState() => _customvarTableState();
}

class _customvarTableState extends State<customvarTable> {
  late Future<List<Map<String, dynamic>>> _dataFuture;
  final List<String> columns = ['登入名', '自訂值1','自訂值2','自訂值3','自訂值4','自訂值5','自訂值6','自訂值7'];

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final String? serverSource =
    await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(
        serverSource!, "/users/usecustomValue");
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
    return Center(
        child: Column(
          children: <Widget>[
            SizedBox(width: 25.0, height: 10.0),
            Column(children: [
              output(data),
            ])
          ],
        ));
  }

  Widget output(List<dynamic> data) {
    return  SingleChildScrollView(
        child:DataTable(
          columns: const <DataColumn>[
           DataColumn(
            label: Text('登入名',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            '自訂值1',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            '自訂值2',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            '自訂值3',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            '自訂值4',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            '自訂值5',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            '自訂值6',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            '自訂值7',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: List<DataRow>.generate(
        data.length,
            (index) => DataRow(
          cells: <DataCell>[
            DataCell(
              Text(data[index]["LoginName"].toString(),
                  style: const TextStyle(fontSize: 12)),
            ),
            DataCell(
              Text(data[index]["customvar01"].toString(),
                  style: const TextStyle(fontSize: 12)),
            ),
            DataCell(
              Text(data[index]["customvar02"].toString(),
                  style: const TextStyle(fontSize: 12)),
            ),
            DataCell(
              Text(data[index]["customvar03"].toString(),
                  style: const TextStyle(fontSize: 12)),
            ),
            DataCell(
              Text(data[index]["customvar04"].toString(),
                  style: const TextStyle(fontSize: 12)),
            ),
            DataCell(
              Text(data[index]["customvar05"].toString(),
                  style: const TextStyle(fontSize: 12)),
            ),
            DataCell(
              Text(data[index]["customvar06"].toString(),
                  style: const TextStyle(fontSize: 12)),
            ),
            DataCell(
              Text(data[index]["customvar07"].toString(),
                  style: const TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    ));
  }
}
