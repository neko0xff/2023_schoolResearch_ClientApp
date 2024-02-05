// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:viewapp_master/pages/btn/userlistView.dart';
import 'package:viewapp_master/pages/btn/customValueView.dart';
import 'package:viewapp_master/pages/btn/modeTable.dart';
import 'package:viewapp_master/pages/btn/modeChoose.dart';
import 'package:viewapp_master/pages/widget/wallpaper.dart';
import 'package:viewapp_master/pages/user/register.dart';

class AccountData extends StatelessWidget {
  const AccountData({super.key});

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
                  Text("帳戶管理&檢視",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                ]),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                btn2(),
                SizedBox(width: 10),
                btn1(),
            ]),
            SizedBox(height: 10),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btn3(),
                  SizedBox(width: 10),
                  btn4(),
                ]),
            SizedBox(height: 10),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btn5(),
                  SizedBox(width: 10),
                ]),
          ]),
        );
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
              context, MaterialPageRoute(builder: (context) => userTablePage()));
        },
        child: Text('使用者列表', textAlign: TextAlign.center));
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
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        child: Text('使用者建立', textAlign: TextAlign.center));
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
              context, MaterialPageRoute(builder: (context) => customValueViewPage()));
        },
        child: Text('使用者自訂值', textAlign: TextAlign.center));
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
              context, MaterialPageRoute(builder: (context) => userModeTablePage()));
        },
        child: Text('使用者目前方案', textAlign: TextAlign.center));
  }
}

class btn5 extends StatelessWidget {
  const btn5({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(150, 100)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => modeChoosePage()));
        },
        child: Text('使用者方案選擇', textAlign: TextAlign.center));
  }
}