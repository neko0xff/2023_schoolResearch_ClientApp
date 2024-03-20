// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, sort_child_properties_last
// ignore_for_file: avoid_web_libraries_in_flutter, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';

List<String> items1 = [
  '煤油使用(2021)',
  '車用汽油(於移動源使用，2021)',
  '柴油(於捕撈移動源使用，2021)',
  '柴油(於水路運輸移動源使用，2021)',
  '柴油(於鐵路運輸與非道路運輸移動源使用，2021)',
  '柴油(於公路運輸移動源使用，2021)',
  '營業小貨車(汽油)',
  '營業小貨車(柴油)',
  '營業大貨車(柴油)',
];
String selectedItem1 = "車用汽油(於移動源使用，2021)";
String setname = "車用汽油(於移動源使用，2021)";

final TextEditingController distStr = TextEditingController();

const Color focusedColor = Colors.yellow;
const Color enableColor = Colors.black;

class CfootTraffic_DB extends StatelessWidget {
  const CfootTraffic_DB({super.key});

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
        Text('排放來源', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        DbCPL(),
        Text('距離', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        TbDist(),
      ],
    );
  }
}

class DbCPL extends StatefulWidget {
  const DbCPL({super.key});

  @override
  _DbCPLState createState() => _DbCPLState();
}

class _DbCPLState extends State<DbCPL> {
  late String selectedCPL;

  @override
  void initState() {
    super.initState();
    selectedCPL = selectedItem1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: selectedCPL,
            onChanged: (value) {
              setState(() {
                selectedCPL = value!;
              });
            },
            items: items1.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ],
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
        controller: distStr,
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
          clearInput(context);
        },
      ),
    );
  }

  void clearInput(BuildContext context) {
    distStr.text = "";
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
      child: TextButton(
        onPressed: () {
          checkInputNull(context);
          sendUserData(context);
        },
        style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
        child: const Text("送出"),
      ),
    );
  }
}

void checkInputNull(BuildContext context) {
  final String dist = distStr.text;

  if (dist.isEmpty) {
    showFailAlert(context);
  } else {
    sendUserData(context);
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

Future<void> sendUserData(BuildContext context) async {
  try {
    final String? serverSource = await PreferencesUtil.getString("serverSource");
    final String cpl = selectedItem1;
    final String dist = distStr.text;

    final Uri uri = Uri.http(serverSource!, "/cal/Cfoot/traffic_db");
    final response = await http.post(uri, body: {
      "CPL": cpl,
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
      //showFailAlert(context);
    } else if (code == "-1") {
      showFailCNAlert(context);
    }
  } catch (e) {
    print("Error: $e");
    showFailCNAlert(context);
  }
}

Future<void> showFailCNAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Network Connection Fail!'),
        content: const Text('Please check you are Network & Server!'
            'Failed to send data.'),
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

