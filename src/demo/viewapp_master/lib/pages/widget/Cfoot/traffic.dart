// ignore_for_file: avoid_web_libraries_in_flutter, use_key_in_widget_constructors, camel_case_types

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';
import 'package:viewapp_master/pages/btn/Cfoot.dart';

// 定義輸入元件
TextEditingController CPLstr = TextEditingController();
TextEditingController diststr = TextEditingController();

var focusedcolor = Colors.yellow;
var enablecolor = Colors.black;

class Cfoot_traffic extends StatelessWidget {
  const Cfoot_traffic({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InputGet(),
    );
  }
}

class InputGet extends StatelessWidget {
  const InputGet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("碳排放-交通部分",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
              ]),
          SizedBox(height: 10.0),
          PostStr(),
          SizedBox(height: 10.0),
          btnView(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class PostStr extends StatelessWidget {
  const PostStr({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[tbCPL(), tbdist()],
    );
  }
}

class tbCPL extends StatelessWidget {
  const tbCPL({super.key});

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
            enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: enablecolor)),
            focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: focusedcolor))),
      ),
    );
  }
}

class tbdist extends StatelessWidget {
  const tbdist({super.key});

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
            enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: enablecolor)),
            focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: focusedcolor))),
      ),
    );
  }
}

class btnClear extends StatelessWidget {
  const btnClear({super.key});

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

class btnView extends StatelessWidget {
  const btnView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btnStrSend()
              ],
            ),
            SizedBox(height: 10.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btnClear(),
              ],
            ),
            SizedBox(height: 10.0),
            btnGoBack(),
          ],
        ));
  }
}

class btnStrSend extends StatelessWidget {
  const btnStrSend({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 50.0,
      child: ElevatedButton(
        child: const Text("送出"),
        onPressed: () {
          checkInputNull(context);
          sendUserData(context);
        },
      ),
    );
  }

  void checkInputNull(BuildContext context) {
    String? CPL = CPLstr.text;
    String? dist = diststr.text;

    if (CPL == "" || dist == "") {
      showFailAlert(context);
    }
  }

  // 使用者比對部分
  Future<dynamic> sendUserData(BuildContext context) async {
    String? serverSource = await PreferencesUtil.getString("serverSource");
    String? CPL = CPLstr.text;
    String? dist = diststr.text;

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

    /*主迴圈*/
    if (code == "1") {


    } else if (code == "0") {
      //showFailAlert(context);
    } else if (code == "-1") {
      showFailCNAlert(context);
    }
  }

  //輸出註冊失敗
  Future<void> showFailAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Fail!'),
          content: const Text('Please check you are Input Data!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushTolaster(context);
              },
            ),
          ],
        );
      },
    );
  }

  //輸出登入失敗
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
                pushTolaster(context);
              },
            ),
          ],
        );
      },
    );
  }

  //跳回登入主頁
  void pushTolaster(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class btnGoBack extends StatelessWidget {
  const btnGoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100.0,
        height: 50.0,
        child:ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CfootPage()));
          },
          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
          child: const Text('Go Back'),
        )
    );
  }
}