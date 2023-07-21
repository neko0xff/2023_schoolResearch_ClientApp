// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:viewapp_v1_1/pages/table/sensor01.dart';
import 'package:viewapp_v1_1/pages/widget/createpdf_sensor01.dart';

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
          btn1(),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }
}

class btn1 extends StatelessWidget {
  const btn1({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreatePDFViewPage()));
        },
        child: Text('Create a PDF'));
  }
}

class Data1 extends StatelessWidget {
  const Data1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SensorTable1(),
    );
  }
}
