// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';

class modeChooseForm extends StatefulWidget {
  const modeChooseForm({super.key});

  @override
  _modeChooseFormState createState() => _modeChooseFormState();
}

class _modeChooseFormState extends State<modeChooseForm> {
  List<String> items1 = [];
  final List<String> items2 = ['C', 'A', 'B'];
  String selectedItem1 = "";
  String selectedItem2 = "C";

  @override
  void initState() {
    super.initState();
    fetchData1();
  }

  //更新選單的內容
  Future<void> fetchData1() async {
    final String? serverSource = await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(serverSource!, '/users/userlist');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      setState(() {
        items1 = data.map<String>((item) => item['username']).toList();
        selectedItem1 = items1.isNotEmpty ? items1[0] : '';
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  //送至後端
  Future<void> postDataToBackend(String selectedValue1, String selectedValue2) async {
    final String? serverSource = await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(serverSource!, '/user/ModeChoose');
    final response = await http.post(
      uri,
      body: jsonEncode({
        'username': selectedValue1,
        'Mode': selectedValue2,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Data sent successfully!');
      showFinnishAlert(context);
    } else {
      print('Failed to send data. Status code: ${response.statusCode}');
      showFailCNAlert(context);
    }
  }

  //成功更改
  Future<void> showFinnishAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Finnish'),
          content: const Text('User Mode is Finnish Change!'),
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

  //連線失敗
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
                //pushToRegister(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('使用者: '),
              DropdownButton<String>(
                value: selectedItem1,
                onChanged: (value) {
                  setState(() {
                    selectedItem1 = value!;
                  });
                },
                items: items1.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),],),
            SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('選擇方案: '),
                DropdownButton<String>(
                  value: selectedItem2,
                  onChanged: (value) {
                    setState(() {
                      selectedItem2 = value!;
                    });
                  },
                  items: items2.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),],),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                postDataToBackend(selectedItem1,selectedItem2);
              },
              child: Text('更改方案'),
            ),
          ],
        ),
      );
  }

}
