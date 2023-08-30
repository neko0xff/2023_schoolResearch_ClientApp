// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_print, unused_field, file_names, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1_1/modules/PreferencesUtil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserCustomValue(),
    );
  }
}

class UserCustomValue extends StatefulWidget {
  const UserCustomValue({Key? key}) : super(key: key);

  @override
  _UserCustomValueState createState() => _UserCustomValueState();
}

class _UserCustomValueState extends State<UserCustomValue> {
  late TextEditingController userSelectedValue01;
  String _setValue01 = "0";

  @override
  void initState() {
    super.initState();
    userSelectedValue01 = TextEditingController();
    _getUserValueStatus();
  }

  @override
  void dispose() {
    userSelectedValue01.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          UserValue01ctr(
            userSelectedValue01: userSelectedValue01,
            onChanged: (value) {
              setState(() {
                _setValue01 = value;
                PreferencesUtil.saveString("UserValue1", value);
              });
              _connectToServer(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _getUserValueStatus() async {
    String? userValue1Status = await PreferencesUtil.getString("UserValue1");
    if (userValue1Status != null) {
      setState(() {
        _setValue01 = userValue1Status;
      });
    }
  }

  Future<void> _connectToServer(BuildContext context) async {
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final String? username = await PreferencesUtil.getString("username");

    // UserValue01
    final Uri uri = Uri.http(serverSource!, "/Set/UserCustomValue01");
    final response = await http.post(uri, body: {
      "username": username, // You need to define 'username'
      "customvar01": _setValue01
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);
    final code = data["code"];
    print(data);

    if (code == "1") {
      showFinnishAlert(context);
    } else if (code == "0") {
      showFailSetAlert(context);
    } else if (code == "-1") {
      showFailCNAlert(context);
    }
  }

  //輸出上傳成功
  Future<void> showFinnishAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Finnish!'),
          content: const Text('Value is upload data!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //輸出上傳失敗
  Future<void> showFailCNAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Network Connection Fail!'),
          content: const Text('Please check you are Network & Server!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //輸出連結失敗
  Future<void> showFailSetAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Fail!'),
          content: const Text('Please check you are Input Data!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class UserValue01ctr extends StatelessWidget {
  final TextEditingController userSelectedValue01;
  final ValueChanged<String> onChanged;

  const UserValue01ctr({
    Key? key,
    required this.userSelectedValue01,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: userSelectedValue01,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.numbers),
              labelText: "User Custom Value 01",
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              onChanged(userSelectedValue01.text);
            },
            child: const Text("Send")),
        const SizedBox(width: 20),
      ],
    );
  }
}
