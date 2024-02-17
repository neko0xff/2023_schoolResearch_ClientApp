// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_user/modules/PreferencesUtil.dart';

String selectedLocation = '富貴角'; // 預設選擇的地點

class AqiTable extends StatefulWidget {
  const AqiTable({super.key});

  @override
  _AqiTableState createState() => _AqiTableState();
}

class _AqiTableState extends State<AqiTable> {
  late Future<List<Map<String, dynamic>>> _dataFuture;
  final List<String> items1 = [];
  String selectedItem1 = "富貴角";
  String setname = "富貴角";

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData1();
  }

  // 更新選單的內容
  Future<List<Map<String, dynamic>>> fetchData1() async {
    try {
      final String? serverSource = await PreferencesUtil.getString("serverSource");
      final Uri uri = Uri.http(serverSource!, '/read/crawler/AQI/ALL');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          items1.clear();
          items1.addAll(data.map<String>((item) => item['sitename']).toList());
          selectedItem1 = items1.isNotEmpty ? items1[0] : '';
        });

        return getData(setname); // 返回取得的數據
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getData(String selectedName) async {
    final String? serverSource = await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(
        serverSource!, "/read/crawler/AQI/site", {"sitename": setname});
    final response = await http.get(uri);
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
          return view(data);
        }
      },
    );
  }

  Widget btnx(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton(
            value: setname,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items1.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                selectedItem1 = newValue!;
                setname = selectedItem1; // 更新setname变量
                _dataFuture = getData(selectedItem1); // 取得新的資料
              });
            },
          ),
        ],
      ),
    );
  }

  Widget view(List<dynamic> data) {
    return Center(
        child: Column(
      children: <Widget>[
        Row(children: [
          Text("查詢位置： ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          btnx(context)
        ]),
        SizedBox(width: 25.0, height: 10.0),
        Column(children: [
          UpdateDay(data),
          output(data),
        ])
      ],
    ));
  }

  Widget UpdateDay(List<dynamic> data) {
    return Center(
        child: Column(
      children: <Widget>[
        Text("Update Time", style: TextStyle(fontSize: 20)),
        Text("Date= ${data[0]["monitordate"].toString()}",
            style: TextStyle(fontSize: 20)),
      ],
    ));
  }

  Widget output(List<dynamic> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              '地點',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'AQI',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: List<DataRow>.generate(
          data.length,
          (index) => DataRow(
            cells: <DataCell>[
              DataCell(
                Text(data[index]["sitename"].toString(),
                    style: const TextStyle(fontSize: 25)),
              ),
              DataCell(
                Text(data[index]["aqi"].toString(),
                    style: const TextStyle(fontSize: 25)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
