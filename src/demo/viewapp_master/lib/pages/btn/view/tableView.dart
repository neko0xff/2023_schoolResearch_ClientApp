// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:viewapp_master/pages/out/view.dart';
import 'package:viewapp_master/pages/table/sensor01.dart';
import 'package:viewapp_master/pages/widget/createpdf_sensor01.dart';

class tableViewPage extends StatelessWidget {
  const tableViewPage({super.key});

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
        body: tableView(),
      ),
    );
  }
}

class tableView extends StatelessWidget {
  tableView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 10.0),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                btnGoBack(),
              ]),
          SizedBox(height: 10.0),
          Text('Sensor01',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const Data1(),
          SizedBox(height: 10.0),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btn1(),
                SizedBox(width: 10),
              ]),
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
        style: ElevatedButton.styleFrom(minimumSize: const Size(100, 80)),
        child: Text('Create a PDF'));
  }
}

class Data1 extends StatelessWidget {
  const Data1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SensorTable1(),
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
      style: ElevatedButton.styleFrom(minimumSize: const Size(100, 80)),
      child: const Text('Go Back'),
    );
  }
}
