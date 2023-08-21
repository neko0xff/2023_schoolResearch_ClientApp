// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

class NewsData extends StatelessWidget {
  const NewsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    return const Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0),
          Data1(),
          SizedBox(height: 10.0),
          DataAQI()
        ]);
  }
}

class Data1 extends StatelessWidget {
  const Data1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("官方資料",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
            ]),
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("資料來源： 行政院環境保護部(署)",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ]),
      ],
    ));
  }
}

class DataAQI extends StatelessWidget {
  const DataAQI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("AQI",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
            ]),
      ],
    ));
  }
}
