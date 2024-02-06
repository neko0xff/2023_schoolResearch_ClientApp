// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_user/modules/PreferencesUtil.dart';

class modeView extends StatefulWidget {
  const modeView({super.key});

  @override
  _modeViewState createState() => _modeViewState();
}

class _modeViewState extends State<modeView> {
  late Future<List<dynamic>> _dataFuture;
  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  Future<List<dynamic>> getData() async {
    final String? serverSource = await PreferencesUtil.getString("serverSource");
    final Uri uri = Uri.http(serverSource!, "/users/Modeview");
    final response = await http.get(uri);
    final result = response.body;
    final data = jsonDecode(result);
    print(data);
    return List<dynamic>.from(data);
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

  Widget view(List<dynamic> data) {
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            output(data),
          ],
        ));
  }

  Future<String?> getCurrentUsername(List<dynamic> data) async {
    final String? username = await PreferencesUtil.getString("username");
    return username ;
  }

  Widget output(List<dynamic> data) {
    return FutureBuilder<String?>(
      future: getCurrentUsername(data),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var currentUser = data.firstWhere(
                (user) => user['username'] == snapshot.data,
            orElse: () => null,
          );

          if (currentUser != null) {
            return Text(
              '目前使用者方案: ${currentUser["Mode"]}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            );
          } else {
            return const Text('Error');
          }
        }

      },
    );
  }


}