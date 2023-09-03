// ignore_for_file: camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names
import 'package:flutter/material.dart';
import 'package:viewapp_v1_1/pages/out/control.dart';
import 'package:viewapp_v1_1/pages/widget/usercustomValue.dart';

class valueCtrPage extends StatelessWidget {
  const valueCtrPage({Key? key}) : super(key: key);

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
        btnGoBack(),
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

class Control2 extends StatelessWidget {
  const Control2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: UserCustomValue());
  }
}

class btnGoBack extends StatelessWidget {
  const btnGoBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Control()));
      },
      child: const Text('Go Back'),
    );
  }
}