// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1/modules/PreferencesUtil.dart';

class Sensor extends StatelessWidget {
  const Sensor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SensorPage(),
      ),
    );
  }
}

class SensorPage extends StatelessWidget {
  const SensorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text("Output Data", style: TextStyle(fontSize: 20)),
        SizedBox(height: 10.0),
        const Data1(),
        SizedBox(height: 10.0),
      ],
    );
  }
}

class Data1 extends StatelessWidget {
  const Data1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MetaTable1(),
    );
  }
}

class MetaTable1 extends StatefulWidget {
  const MetaTable1({Key? key}) : super(key: key);

  @override
  _MetaTable1State createState() => _MetaTable1State();
}

class _MetaTable1State extends State<MetaTable1> {
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  Future<Map<String, dynamic>> getData() async {
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(serverSource!, "/read/Sensor01/ALL");
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
          return output(data);
        }
      },
    );
  }

  Widget output(Map<String, dynamic> data) {
    return Column(
      children: <Widget>[
        buildTable(data),
        UpdateDay(data),
      ],
    );
  }

  Widget UpdateDay(Map<String, dynamic> data) {
    return Center(
        child: Column(
      children: <Widget>[
        Text("Update Time", style: TextStyle(fontSize: 20)),
        Text("Date= " + data["date"], style: TextStyle(fontSize: 20)),
        Text("Time= " + data["time"], style: TextStyle(fontSize: 20)),
      ],
    ));
  }

  Widget buildTable(Map<String, dynamic> data) {
    return Center(
        child: Column(children: <Widget>[
      Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(110.0),
          1: FixedColumnWidth(110.0),
          2: FixedColumnWidth(110.0),
        },
        border: TableBorder.all(
          color: Colors.black87,
          width: 1.0,
          style: BorderStyle.solid,
        ),
        children: <TableRow>[
          const TableRow(
            children: <Widget>[
              Center(
                  child: Text(
                '開發版',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
              Center(
                  child: Text(
                '感測氣體',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
              Center(
                  child: Text(
                '回傳值',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
            ],
          ),
          TableRow(
            children: <Widget>[
              const Center(
                  child: Text('Sensor01', style: TextStyle(fontSize: 25))),
              const Center(child: Text('temp', style: TextStyle(fontSize: 25))),
              Center(
                  child:
                      Text('${data["temp"]}', style: TextStyle(fontSize: 25))),
            ],
          ),
          TableRow(
            children: <Widget>[
              const Center(
                  child: Text('Sensor01', style: TextStyle(fontSize: 25))),
              const Center(child: Text('hum', style: TextStyle(fontSize: 25))),
              Center(
                  child:
                      Text('${data["hum"]}', style: TextStyle(fontSize: 25))),
            ],
          ),
          TableRow(
            children: <Widget>[
              const Center(
                  child: Text('Sensor01', style: TextStyle(fontSize: 25))),
              const Center(child: Text('tvoc', style: TextStyle(fontSize: 25))),
              Center(
                  child:
                      Text('${data["tvoc"]}', style: TextStyle(fontSize: 25))),
            ],
          ),
          TableRow(
            children: <Widget>[
              const Center(
                  child: Text('Sensor01', style: TextStyle(fontSize: 25))),
              const Center(child: Text('co', style: TextStyle(fontSize: 25))),
              Center(
                  child: Text('${data["co"]}', style: TextStyle(fontSize: 25))),
            ],
          ),
          TableRow(
            children: <Widget>[
              const Center(
                  child: Text('Sensor01', style: TextStyle(fontSize: 25))),
              const Center(child: Text('co2', style: TextStyle(fontSize: 25))),
              Center(
                  child:
                      Text('${data["co2"]}', style: TextStyle(fontSize: 25))),
            ],
          ),
          TableRow(
            children: <Widget>[
              const Center(
                  child: Text('Sensor01', style: TextStyle(fontSize: 25))),
              const Center(
                  child: Text('PM2.5', style: TextStyle(fontSize: 25))),
              Center(
                  child:
                      Text('${data["pm25"]}', style: TextStyle(fontSize: 25))),
            ],
          ),
          TableRow(
            children: <Widget>[
              const Center(
                  child: Text('Sensor01', style: TextStyle(fontSize: 25))),
              const Center(child: Text('O3', style: TextStyle(fontSize: 25))),
              Center(
                  child: Text('${data["o3"]}', style: TextStyle(fontSize: 25))),
            ],
          ),
        ],
      ),
    ]));
  }
}
