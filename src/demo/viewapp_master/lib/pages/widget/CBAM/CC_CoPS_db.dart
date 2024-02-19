// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, sort_child_properties_last
// ignore_for_file: avoid_web_libraries_in_flutter, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';

// 定義輸入組件
final TextEditingController emissionsstr = TextEditingController();
final TextEditingController productionstr = TextEditingController();
final TextEditingController Mid_productionstr = TextEditingController();
final TextEditingController CCstr = TextEditingController();

const Color focusedColor = Colors.yellow;
const Color enableColor = Colors.black;

class CBAMCCcops_db extends StatelessWidget {
  const CBAMCCcops_db({super.key});

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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "CBAM \n 碳含量_複雜產品",
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
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "公式\n",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "特定產品碳含量\n+\n((中間產品活動數據/產品活動數據)*中間產品碳含量)",
              ),
            ],
          ),
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
        Tbemissions(),
        Tbproduction(),
        TbMid_production(),
        Tbcc()
      ],
    );
  }
}

class Tbemissions extends StatelessWidget {
  const Tbemissions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: emissionsstr,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.info),
          labelText: "排放量",
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

class Tbproduction extends StatelessWidget {
  const Tbproduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: productionstr,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.info),
          labelText: "生產量",
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

class TbMid_production extends StatelessWidget {
  const TbMid_production({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: Mid_productionstr,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.info),
          labelText: "中間產品活動數據",
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

class Tbcc extends StatelessWidget {
  const Tbcc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: CCstr,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.info),
          labelText: "中間產品碳含量",
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
    emissionsstr.text = "";
    productionstr.text = "";
    Mid_productionstr.text = "";
    CCstr.text = "";
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
    final String emissions = emissionsstr.text;
    final String production = productionstr.text;
    final String Mid_production = Mid_productionstr.text;
    final String CC = CCstr.text;

    if (emissions.isEmpty || production.isEmpty || Mid_production.isEmpty || CC.isEmpty ) {
      showFailAlert(context);
    } else {
      sendUserData(context);
    }
  }

  // 使用者比較部分
  Future<void> sendUserData(BuildContext context) async {
    final String? serverSource = await PreferencesUtil.getString("serverSource");
    final String emissions = emissionsstr.text;
    final String production = productionstr.text;
    final String Mid_production = Mid_productionstr.text;
    final String CC = CCstr.text;

    final Uri uri = Uri.http(serverSource!, "/cal/CBAM/CC_CoPS");
    final response = await http.post(uri, body: {
      "emissions": emissions,
      "production": production,
      "Mid_production": Mid_production,
      "CC": CC
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);
    final code = data["code"];

    if (code == "1") {
      showFailAlert(context);
    } else if (code == "0") {
      final output = data["output"].toString();
      final inputGetState = context.findAncestorStateOfType<_InputGetState>();
      inputGetState!.setResult("輸出結果: $output");
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

