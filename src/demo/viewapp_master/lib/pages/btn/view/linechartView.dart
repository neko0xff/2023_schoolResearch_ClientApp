// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, prefer_const_constructors_in_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:viewapp_master/pages/chart/line_sennsor01_co.dart';
import 'package:viewapp_master/pages/chart/line_sennsor01_co2.dart';
import 'package:viewapp_master/pages/chart/line_sennsor01_hum.dart';
import 'package:viewapp_master/pages/chart/line_sennsor01_o3.dart';
import 'package:viewapp_master/pages/chart/line_sennsor01_pm25.dart';
import 'package:viewapp_master/pages/chart/line_sennsor01_temp.dart';
import 'package:viewapp_master/pages/chart/line_sennsor01_tvoc.dart';
import 'package:viewapp_master/pages/out/view.dart';

class linecartViewPage extends StatelessWidget {
  const linecartViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue, backgroundColor: Colors.white),
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
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 10),
                btnGoBack(),
              ]),
          SizedBox(height: 10.0),
          Text('Sensor01',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 5.0),
          Text('Temp',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          LineViewtemp(),
          Text('Hum',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          LineViewhum(),
          Text('TVOC',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          LineViewtvoc(),
          Text('Co',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          LineViewco(),
          Text('Co2',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          LineViewco2(),
          Text('PM2.5',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          LineViewpm25(),
          Text('O3',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          LineViewo3(),
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
        style: ElevatedButton.styleFrom(minimumSize: const Size(100, 80)));
  }
}
