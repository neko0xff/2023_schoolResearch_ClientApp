// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:viewapp_v1_1/pages/out/view.dart';

class chartViewPage extends StatelessWidget {
  const chartViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: chartView(),
      ),
    );
  }
}

class chartView extends StatelessWidget {
  chartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text('Sensor01',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
  const btnGoBack({Key? key}) : super(key: key);

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
