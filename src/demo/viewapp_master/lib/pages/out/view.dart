// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:viewapp_master/pages/btn/view/barchartView.dart';
import 'package:viewapp_master/pages/btn/view/linechartView.dart';
import 'package:viewapp_master/pages/btn/view/tableView.dart';
import 'package:viewapp_master/pages/widget/wallpaper.dart';

class ViewData extends StatelessWidget {
  const ViewData({super.key});

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
        body: ViewPage(),
      ),
    );
  }
}

class ViewPage extends StatelessWidget {
  var isScrollable = true;
  ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text('檢視方式',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 20.0),
          btn1(),
          SizedBox(height: 15.0),
          btn2(),
          SizedBox(height: 15.0),
          btn3(),
          wallpaperLogin(),
        ],
      )),
    );
  }
}

class btn1 extends StatelessWidget {
  const btn1({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => tableViewPage()));
        },
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 100)),
        child: Text('表格', textAlign: TextAlign.center));
  }
}

class btn2 extends StatelessWidget {
  const btn2({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => barchartViewPage()));
        },
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 100)),
        child: Text('長條圖', textAlign: TextAlign.center));
  }
}

class btn3 extends StatelessWidget {
  const btn3({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => linecartViewPage()));
        },
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 100)),
        child: Text('折線圖', textAlign: TextAlign.center));
  }
}
