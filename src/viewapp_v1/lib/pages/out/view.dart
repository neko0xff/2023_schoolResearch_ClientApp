// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:viewapp_v1/pages/table/sensor01.dart';
import 'package:viewapp_v1/pages/table/switch01.dart';

class ViewData extends StatelessWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ViewPage(),
      ),
    );
  }
}

class ViewPage extends StatelessWidget {
  var isScrollable = true;
  ViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text('Data View',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Text('Sensor01',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const Data1(),
          SizedBox(height: 15.0),
          Text('Switch01',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const Data2(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class Data1 extends StatelessWidget {
  const Data1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SensorTable1(),
    );
  }
}

class Data2 extends StatelessWidget {
  const Data2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SwitchTable1(),
    );
  }
}
