// ignore_for_file: camel_case_types, must_be_immutable, unused_import, non_constant_identifier_names, library_private_types_in_public_api
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1/class/user.dart';

class Sensor extends StatelessWidget {
  final userData user;
  String? serverSource;

  Sensor({Key? key, required this.user}) : super(key: key) {
    serverSource = user.serverSource;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SensorPage(user: user),
      ),
    );
  }
}

class SensorPage extends StatelessWidget {
  final userData user;
  String? serverSource;
  SensorPage({Key? key, required this.user}) : super(key: key) {
    serverSource = user.serverSource;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const SizedBox(height: 10.0),
        const Text("Output Data"),
        const SizedBox(height: 10.0),
        data1(user: user),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class data1 extends StatelessWidget {
  String? serverSource;
  final userData user;
  data1({Key? key, required this.user}) : super(key: key) {
    serverSource = user.serverSource;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MetaTable1(user: user),
    );
  }
}

class MetaTable1 extends StatefulWidget {
  final userData user;

  const MetaTable1({Key? key, required this.user}) : super(key: key);

  @override
  _MetaTable1State createState() => _MetaTable1State();
}

class _MetaTable1State extends State<MetaTable1> {
  late final userData user;
  String? serverSource;

  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List> fetchData() async {
    String serverSource = widget.user.serverSource!;
    String uriSource = "$serverSource/read/Sensor01/ALL";
    final response = await http.get(Uri.parse(uriSource));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        //指定索引及固定列宽
        0: FixedColumnWidth(100.0),
        1: FixedColumnWidth(100.0),
        2: FixedColumnWidth(100.0),
      },
      //設定表格樣式
      border: TableBorder.all(
          color: Colors.black87, width: 1.0, style: BorderStyle.solid),
      children: <TableRow>[
        const TableRow(
          children: <Widget>[
            Center(child: Text('開發版')),
            Center(child: Text('感測氣體')),
            Center(child: Text('回傳值')),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Center(child: Text('Sensor01')),
            const Center(child: Text('temp')),
            Center(child: Text('${data[1]}')),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Center(child: Text('Sensor01')),
            const Center(child: Text('hum')),
            Center(child: Text('${data[2]}')),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Center(child: Text('Sensor01')),
            const Center(child: Text('tvoc')),
            Center(child: Text('${data[3]}')),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Center(child: Text('Sensor01')),
            const Center(child: Text('co')),
            Center(child: Text('${data[4]}')),
          ],
        ),
        const TableRow(
          children: <Widget>[
            Center(child: Text('Sensor01')),
            Center(child: Text('co2')),
            Center(child: Text('每週 一、三 21:00~22:00')),
          ],
        ),
        const TableRow(
          children: <Widget>[
            Center(child: Text('Sensor01')),
            Center(child: Text('PM2.5')),
            Center(child: Text('每週 一、三 21:00~22:00')),
          ],
        ),
        const TableRow(
          children: <Widget>[
            Center(child: Text('Sensor01')),
            Center(child: Text('o3')),
            Center(child: Text('每週 一、三 21:00~22:00')),
          ],
        ),
      ],
    );
  }
}
