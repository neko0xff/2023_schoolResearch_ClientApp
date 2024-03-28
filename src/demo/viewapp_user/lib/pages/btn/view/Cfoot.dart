// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, camel_case_types, must_be_immutable, file_names, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:viewapp_user/pages/out/news.dart';
import 'package:viewapp_user/pages/widget/Cfoot/traffic_db.dart';
import 'package:viewapp_user/pages/widget/Cfoot/other_db.dart';
import 'package:viewapp_user/pages/widget/CBAM/emissions_db.dart';
import 'package:viewapp_user/pages/widget/CBAM/CC_simple_db.dart';
import 'package:viewapp_user/pages/widget/CBAM/CC_CoPS_db.dart';
import 'package:viewapp_user/pages/btn/table/cfootTable.dart';

class CfootPage_api extends StatelessWidget {
  const CfootPage_api({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue, backgroundColor: Colors.white),
      ),
      home: const Scaffold(
        body: crdata(),
      ),
    );
  }
}

class crdata extends StatelessWidget {
  const crdata({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[SizedBox(height: 10.0), DataAQI()])
    );
  }
}

class DataAQI extends StatelessWidget {
  const DataAQI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("碳排放計算",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                ]),
            SizedBox(height: 10),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ btn6()]),
            SizedBox(height: 10),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ btn5(),SizedBox(width: 10), btn4() ]),
            SizedBox(height: 10),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ btn1(),SizedBox(width: 10), btn2()]),
            SizedBox(height: 10),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ btn3(),SizedBox(width: 10)]),
            SizedBox(height: 10),
            btnGoBack(),
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
              context, MaterialPageRoute(builder: (context) => CfootTraffic_DB()));
        },
        child: Text('交通', textAlign: TextAlign.center));
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
              context, MaterialPageRoute(builder: (context) => CfootOther_DB()));
        },
        child: Text('其它', textAlign: TextAlign.center));
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
              context, MaterialPageRoute(builder: (context) => CBAMemissions_db()));
        },
        child: Text('CBAM \n 排放量', textAlign: TextAlign.center));
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
              context, MaterialPageRoute(builder: (context) => CBAMCCsimple_db()));
        },
        child: Text('CBAM \n 碳含量_簡單與中間產品', textAlign: TextAlign.center));
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
              context, MaterialPageRoute(builder: (context) => CBAMCCcops_db()));
        },
        child: Text('CBAM \n 碳含量_複雜產品', textAlign: TextAlign.center));
  }
}

class btn6 extends StatelessWidget {
  const btn6({super.key});

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

class btnGoBack extends StatelessWidget {
  const btnGoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const NewsData()));
      },
      style: ElevatedButton.styleFrom(minimumSize: const Size(100, 80)),
      child: const Text('回上頁'),
    );
  }
}