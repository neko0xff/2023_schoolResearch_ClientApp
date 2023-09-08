// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1_1/modules/PreferencesUtil.dart';

class SwitchTable1 extends StatefulWidget {
  const SwitchTable1({Key? key}) : super(key: key);

  @override
  _SwitchTable1State createState() => _SwitchTable1State();
}

class _SwitchTable1State extends State<SwitchTable1> {
  late Future<List<dynamic>> _dataFuture;
  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  Future<List<dynamic>> getData() async {
    const String setboards = "Switch01";
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final Uri uri =
        Uri.http(serverSource!, "/read/statusNow/$setboards/viewALL");
    final response = await http.get(uri);
    final result = response.body;
    final data = jsonDecode(result);
    print(data);
    return List<dynamic>.from(data);
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
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        output(data),
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
              '開関',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              '狀態',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: List<DataRow>.generate(
          data.length,
          (index) => DataRow(
            cells: <DataCell>[
              DataCell(
                Text(data[index]["name"] as String,
                    style: const TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text('${data[index]["status"]}',
                    style: const TextStyle(fontSize: 25)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
