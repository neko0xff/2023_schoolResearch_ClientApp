// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';

class CfootTable extends StatefulWidget {
  const CfootTable({Key? key});

  @override
  _CfootTableState createState() => _CfootTableState();
}

class _CfootTableState extends State<CfootTable> {
  late Future<List<Map<String, dynamic>>> _dataFuture;
  final List<String> items1 = [];
  String selectedItem1 = "標籤紙(PET)";

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData1();
  }

  // 更新選單的內容
  Future<List<Map<String, dynamic>>> fetchData1() async {
    try {
      final String? serverSource = await PreferencesUtil.getString("serverSource");
      final Uri uri = Uri.http(serverSource!, '/read/crawler/CFoot/ALL');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          items1.clear();
          items1.addAll(data.map<String>((item) => item['name']).toList());
          selectedItem1 = items1.isNotEmpty ? items1[0] : '';
        });

        return getData(); // 返回取得的數據
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getData() async {
    try {
      final String? serverSource = await PreferencesUtil.getString("serverSource");
      final Uri uri = Uri.http(serverSource!, "/read/crawler/CFoot/ALL", {"name": selectedItem1});
      final response = await http.get(uri);
      final result = response.body;
      final jsonData = jsonDecode(result);
      return List<Map<String, dynamic>>.from(jsonData);
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.requireData;
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
          DropdownButton<String>(
            value: selectedItem1,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items1.map((String items) {
              return DropdownMenuItem<String>(
                value: items,
                child: Text(
                  items,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedItem1 = newValue!;
                _dataFuture = getData(); // 取得新的資料
              });
            },
          ),
        ],
      ),
    );
  }

  Widget view(List<Map<String, dynamic>> data) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Text(
                "查詢位置： ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              btnx(context)
            ],
          ),
          SizedBox(width: 25.0, height: 10.0),
          Column(
            children: [
              output(data),
            ],
          )
        ],
      ),
    );
  }

  Widget output(List<Map<String, dynamic>> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                '物品名',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Coe',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                '單位',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: List<DataRow>.generate(
            data.length,
                (index) => DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(
                    data[index]["name"].toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                DataCell(
                  Text(
                    data[index]["coe"].toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                DataCell(
                  Text(
                    data[index]["unit"].toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
