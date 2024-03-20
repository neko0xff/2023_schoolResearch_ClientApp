// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, sort_child_properties_last
// ignore_for_file: avoid_web_libraries_in_flutter, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';

// 定義輸入組件
final TextEditingController CPLstr = TextEditingController();
final TextEditingController diststr = TextEditingController();

const Color focusedColor = Colors.yellow;
const Color enableColor = Colors.black;

class CfootTraffic extends StatelessWidget {
  const CfootTraffic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InputGet(),
    );
  }
}

class InputGet extends StatefulWidget {
  const InputGet({super.key});

  @override
  _InputGetState createState() => _InputGetState();
}

class _InputGetState extends State<InputGet> {
  String result = '輸出結果: ';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "碳排放-交通部分",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            result,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10.0),
          PostStr(),
          SizedBox(height: 10.0),
          Text("公式: 排放因數 * 旅行的距離"),
          SizedBox(height: 10.0),
          BtnView(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  void setResult(String res) {
    setState(() {
      result = res;
    });
  }
}

class PostStr extends StatelessWidget {
  const PostStr({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TbCPL(),
        TbDist(),
      ],
    );
  }
}

class TbCPL extends StatelessWidget {
  const TbCPL({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: CPLstr,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.info),
          labelText: "排放因素",
          hintText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enableColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedColor),
          ),
        ),
      ),
    );
  }
}

class TbDist extends StatelessWidget {
  const TbDist({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: diststr,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.info),
          labelText: "行走距離",
          hintText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enableColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedColor),
          ),
        ),
      ),
    );
  }
}

class BtnClear extends StatelessWidget {
  const BtnClear({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 50.0,
      child: ElevatedButton(
        child: const Text("Clear"),
        onPressed: () {
          clearInput();
        },
      ),
    );
  }

  void clearInput() {
    CPLstr.text = "";
    diststr.text = "";
  }
}

class BtnView extends StatelessWidget {
  const BtnView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BtnStrSend(),
            ],
          ),
          SizedBox(height: 10.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BtnClear(),
            ],
          ),
          SizedBox(height: 10.0),
          BtnGoBack(),
        ],
      ),
    );
  }
}

class BtnStrSend extends StatelessWidget {
  const BtnStrSend({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 50.0,
      child: ElevatedButton(
        child: const Text("送出"),
        onPressed: () {
          checkInputNull(context);
        },
      ),
    );
  }

  void checkInputNull(BuildContext context) {
    final String CPL = CPLstr.text;
    final String dist = diststr.text;

    if (CPL.isEmpty || dist.isEmpty) {
      showFailAlert(context);
    } else {
      sendUserData(context);
    }
  }

  // 使用者比較部分
  Future<void> sendUserData(BuildContext context) async {
    final String? serverSource = await PreferencesUtil.getString("serverSource");
    final String CPL = CPLstr.text;
    final String dist = diststr.text;

    final Uri uri = Uri.http(serverSource!, "/cal/Cfoot/traffic");
    final response = await http.post(uri, body: {
      "CPL": CPL,
      "dist": dist
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);
    final code = data["code"];

    if (code == "1") {
      final output = data["output"].toString();
      final inputGetState = context.findAncestorStateOfType<_InputGetState>();
      inputGetState!.setResult("輸出結果: $output");
    } else if (code == "0") {
      showFailAlert(context);
    } else if (code == "-1") {
      showFailCNAlert(context);
    }
  }

  // 輸出傳送失敗
  Future<void> showFailAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Fail!'),
          content: const Text('Please check your input data!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 輸出連線失敗
  Future<void> showFailCNAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Network Connection Fail!'),
          content: const Text('Please check your network and server!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class BtnGoBack extends StatelessWidget {
  const BtnGoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
        child: const Text('Go Back'),
      ),
    );
  }
}

