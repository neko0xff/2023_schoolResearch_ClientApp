// ignore_for_file: camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:viewapp_v1_1/pages/widget/switch01ctr.dart';
import 'package:viewapp_v1_1/pages/widget/usercustomValue.dart';

class Control extends StatelessWidget {
  const Control({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ControlPage(),
        ));
  }
}

class ControlPage extends StatelessWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text("Switch Control",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.0),
        Text("Switch01",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.0),
        Control1(),
        SizedBox(height: 10.0),
        Text("User Custom",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.0),
        Control2(),
        SizedBox(height: 10.0),
      ],
    ));
  }
}

class Control1 extends StatelessWidget {
  const Control1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Switch01ctr());
  }
}

class Control2 extends StatelessWidget {
  const Control2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: UserCustomValue());
  }
}
