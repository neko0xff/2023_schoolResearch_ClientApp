// ignore_for_file: camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, body_might_complete_normally_catch_error
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:viewapp_v1/modules/PreferencesUtil.dart';

class Switchctr extends StatelessWidget {
  const Switchctr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Fan1ctr(),
          SizedBox(height: 20),
          Fan2ctr(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class Fan1ctr extends StatefulWidget {
  const Fan1ctr({Key? key}) : super(key: key);

  @override
  _Fan1ctrState createState() => _Fan1ctrState();
}

class _Fan1ctrState extends State<Fan1ctr> {
  bool _switchSelectedFan2 = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          "Fan2 ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Switch(
          value: _switchSelectedFan2,
          onChanged: (value) {
            setState(() {
              _switchSelectedFan2 = value;
            });
          },
        ),
      ],
    );
  }
}

class Fan2ctr extends StatefulWidget {
  const Fan2ctr({Key? key}) : super(key: key);

  @override
  _Fan2ctrState createState() => _Fan2ctrState();
}

class _Fan2ctrState extends State<Fan2ctr> {
  bool _switchSelectedFan2 = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          "Fan2 ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Switch(
          value: _switchSelectedFan2,
          onChanged: (value) {
            setState(() {
              _switchSelectedFan2 = value;
            });
          },
        ),
      ],
    );
  }
}
