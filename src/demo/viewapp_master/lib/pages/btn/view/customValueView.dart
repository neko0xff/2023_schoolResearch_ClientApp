// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:viewapp_master/pages/out/account.dart';
import 'package:viewapp_master/pages/table/customValue.dart';

class customValueViewPage extends StatelessWidget {
  const customValueViewPage({super.key});

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
        body: crdata(),
      ),
    );
  }
}

class crdata extends StatelessWidget {
  const crdata({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(child:Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[SizedBox(height: 10.0), DataUserlist()]))
    );
  }
}

class DataUserlist extends StatelessWidget {
  const DataUserlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnGoBack(),
            SizedBox(height: 10),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("使用者自訂值",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                ]),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [table_customvarule()]),
          ],
        ));
  }
}

class table_customvarule extends StatelessWidget {
  const table_customvarule({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customvarTable(),
        ]
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
            context, MaterialPageRoute(builder: (context) => AccountData()));
      },
      child: const Text('Go Back'),
      style: ElevatedButton.styleFrom(minimumSize: const Size(100, 80)),
    );
  }
}
