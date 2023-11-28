// ignore_for_file: prefer_const_literals_to_create_immutables, camel_case_types, duplicate_ignore, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        automaticallyImplyLeading: true,
      ),
      body: const AboutGet(),
    );
  }
}

class AboutGet extends StatelessWidget {
  const AboutGet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: data1(),
    );
  }
}

class data1 extends StatelessWidget {
  const data1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 25.0, height: 10.0),
        Text("關於開發者部分",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(width: 25.0, height: 10.0),
        Text("這是aeust MI 112學年 B組 專題",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text("該客戶端可檢視伺服端上的所有資訊&控制項",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(width: 25.0, height: 10.0),
        Text("使用框架部分",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(width: 25.0, height: 10.0),
        Text("前端： Flutter",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text("後端： nodejs",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text("資料庫： mysql(MariaDB)",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(width: 25.0, height: 10.0),
        Text("其它", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(width: 25.0, height: 10.0),
        Text("撰寫時間: 2023/07/01~now",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(width: 25.0),
        Text("釋出版本： V2.1",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(width: 25.0, height: 10.0),
        Text("Ask Author",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        btnView(),
      ],
    ));
  }
}

class btnView extends StatelessWidget {
  const btnView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(height: 10),
        btnGithub(),
        SizedBox(height: 25),
        btnTwitter(),
        SizedBox(height: 25),
        btnMastdon(),
        SizedBox(height: 25),
      ],
    );
  }
}

class btnGithub extends StatelessWidget {
  const btnGithub({super.key});

  final String URL =
      'https://github.com/neko0xff/2023_schoolResearch_ClientApp';
  launchURL() {
    launch(URL);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: launchURL,
        child: const Text("Github"),
      ),
    );
  }
}

// ignore: camel_case_types
class btnTwitter extends StatelessWidget {
  const btnTwitter({super.key});

  final String URL = 'https://twitter.com/neko_0xFF';
  launchURL() {
    launch(URL);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: launchURL,
        child: const Text("X(Twitter)"),
      ),
    );
  }
}

// ignore: camel_case_types
class btnMastdon extends StatelessWidget {
  const btnMastdon({super.key});

  final String URL = 'https://mas.to/@neko_0xff';
  launchURL() {
    launch(URL);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: launchURL,
        child: const Text("Mastdon(mas.to)"),
      ),
    );
  }
}
