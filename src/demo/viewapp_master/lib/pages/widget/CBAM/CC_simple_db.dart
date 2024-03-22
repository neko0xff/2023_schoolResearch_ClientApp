// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, sort_child_properties_last
// ignore_for_file: avoid_web_libraries_in_flutter, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';

// 定義輸入組件
final TextEditingController usestr = TextEditingController();
final TextEditingController productionstr = TextEditingController();

const Color focusedColor = Colors.yellow;
const Color enableColor = Colors.black;

List<String> items1 = [];
String selectedItem1 = "";
const String setname = "苯乙烯-乙烯/丁烯-苯乙烯熱塑性彈性體";

class CBAMCCsimple_db extends StatelessWidget {
  const CBAMCCsimple_db({super.key});

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
                "CBAM\n碳含量_簡單與中間產品",
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
          Text("公式: 產品碳含量= 排放量/產品活動數據(生產量)"),
          Text("備註: 簡單和中間產品的運算公式相同"),
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
        Text("特定產品排放量",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text("指定生產的產品",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        DbCPL(),
        Tbuse(),
        SizedBox(height: 10),
        Text("產品活動數據",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Tbproduction(),
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
    fetchData1();
  }

  Future<void> fetchData1() async {
    try {
      final String? serverSource = await PreferencesUtil.getString("serverSource");
      final Uri uri = Uri.http(serverSource!, '/read/crawler/CFoot/list');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        items1 = data.map<String>((item) => item['name'].toString()).toSet().toList();

        setState(() {
          selectedItem1 = items1.isNotEmpty ? items1[0] : '';
          selectedCPL = selectedItem1;

          // 確保 selectedCPL 的初始值存在於 items1 中
          if (!items1.contains(selectedCPL)) {
            selectedCPL = items1.isNotEmpty ? items1[0] : '';
          }
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
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

class Tbuse extends StatelessWidget {
  const Tbuse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: usestr,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.info),
          labelText: "該項目每1個單位的使用量",
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
          labelText: "生產總量",
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
      width: 140.0,
      height: 50.0,
      child: ElevatedButton(
        child: const Text("清除填入內容"),
        onPressed: () {
          clearInput();
        },
      ),
    );
  }

  void clearInput() {
    usestr.text = "";
    productionstr.text = "";
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
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                BtnStrSend(),
                SizedBox(width: 10.0,height: 10.0),
                BtnClear(),
              ])
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
    final String use = usestr.text;
    final String production = productionstr.text;

    if (use.isEmpty || production.isEmpty) {
      showFailAlert(context);
    } else {
      sendUserData(context);
    }
  }

  // 使用者比較部分
  Future<void> sendUserData(BuildContext context) async {
    final String? serverSource = await PreferencesUtil.getString("serverSource");
    final String use = usestr.text;
    final String cpl = selectedItem1;
    final String production = productionstr.text;

    final Uri uri = Uri.http(serverSource!, "/cal/CBAM/CC_simple_db");
    final response = await http.post(uri, body: {
      "use": use,
      "gwp": cpl,
      "production": production
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
        child: const Text('回上頁'),
      ),
    );
  }
}

