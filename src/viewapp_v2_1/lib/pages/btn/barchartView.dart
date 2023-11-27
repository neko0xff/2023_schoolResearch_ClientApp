// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:viewapp_v2_1/pages/chart/bar_sensor01.dart';
import 'package:viewapp_v2_1/pages/out/view.dart';

class barchartViewPage extends StatelessWidget {
  const barchartViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green, backgroundColor: Colors.white),
      ),
      home: Scaffold(
        body: chartView(),
      ),
    );
  }
}

class chartView extends StatelessWidget {
  chartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text('Sensor01',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          BarView1(),
          SizedBox(height: 10.0),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 10),
                btnGoBack(),
              ]),
          SizedBox(height: 15.0),
        ],
      )),
    );
  }
}

class btnGoBack extends StatelessWidget {
  const btnGoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewData()));
      },
      child: const Text('Go Back'),
    );
  }
}
