// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:viewapp_v2_1/pages/btn/aqiTable.dart';
import 'package:viewapp_v2_1/pages/widget/wallpaper.dart';

class NewsData extends StatelessWidget {
  const NewsData({super.key});

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
        body: NewsPage(),
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0),
            Data1(),
            SizedBox(height: 5.0),
            wallpaperLogin(),
          ]),
    );
  }
}

class Data1 extends StatelessWidget {
  const Data1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("官方資料",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
            ]),
        SizedBox(height: 10),
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              btn1(),
            ]),
      ],
    ));
  }
}

class btn1 extends StatelessWidget {
  const btn1({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(100, 80)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => aqiTablePage()));
        },
        child: Text('AQI', textAlign: TextAlign.center));
  }
}
