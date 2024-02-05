// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types
//import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:viewapp_master/modules/PreferencesUtil.dart';

final List<String> items2 = ['C', 'A', 'B'];
String? selectedValue2 = 'C';

class modeChooseForm extends StatefulWidget {
  const modeChooseForm({super.key});

  @override
  _modeChooseFormState createState() => _modeChooseFormState();
}

class _modeChooseFormState extends State<modeChooseForm> {
  //late Future<List<Map<String, dynamic>>> _dataFuture;
  String setValue2 = "C";

  @override
  void initState() {
    super.initState();
    //_dataFuture = sendUserData();
    selectedValue2 = setValue2; // 初始化選定的地點
  }

  /*Future<dynamic> sendUserData(BuildContext context) async {
    final String? serverSource =
    await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(
        serverSource!, "/user/ModeChoose");
    final response = await http.post(uri, body: {
      "username": "master",
      "password": setValue2
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final jsonData = jsonDecode(result);
    return List<Map<String, dynamic>>.from(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data!;
          return view2(data);
        }
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue, backgroundColor: Colors.white),
      ),
      home: Scaffold(
        body: view2(data),
      ),
    );
  }

  Widget btn2(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton(
            value: setValue2,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items2.map((String items2) {
              return DropdownMenuItem(
                value: items2,
                child: Text(items2,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              );
            }).toList(),
            onChanged: (String? newValue2) {
              setState(() {
                setValue2 = newValue2!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget view2(List<dynamic> data) {
    return Center(
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text("方案： ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              btn2(context)
            ]),
            SizedBox(width: 25.0, height: 10.0),
          ],
        ));
  }

}
