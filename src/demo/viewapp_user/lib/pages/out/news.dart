// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:viewapp_user/pages/btn/table/aqiTable.dart';
import 'package:viewapp_user/pages/btn/table/cfootTable.dart';
import 'package:viewapp_user/pages/btn/view/Cfoot.dart';
import 'package:viewapp_user/pages/widget/wallpaper.dart';

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
            children: [btn1(), SizedBox(width: 10), btn4()]
        ),
        SizedBox(height: 10.0),
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [btn2(), SizedBox(width: 10), btn3()]
        ),
      ],
    ));
  }
}

class btn1 extends StatelessWidget {
  const btn1({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 100)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => aqiTablePage()));
        },
        child: Text('各測站點AQI', textAlign: TextAlign.center));
  }
}

class btn2 extends StatelessWidget {
  const btn2({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 100)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CfootPage()));
        },
        child: Text('碳排放\n手動', textAlign: TextAlign.center));
  }
}

class btn3 extends StatelessWidget {
  const btn3({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 100)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CfootPage()));
        },
        child: Text('碳排放\n自動', textAlign: TextAlign.center));
  }
}

class btn4 extends StatelessWidget {
  const btn4({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 100)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => cfootTablePage()));
        },
        child: Text('各項物品碳排放', textAlign: TextAlign.center));
  }
}