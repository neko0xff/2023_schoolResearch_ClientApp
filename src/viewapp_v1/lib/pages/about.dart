// ignore_for_file: prefer_const_literals_to_create_immutables, camel_case_types, duplicate_ignore, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Page"),
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
      children: <Widget>[
        SizedBox(width: 25.0),
        Text("About Dev",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(width: 25.0),
        Text("這是neko0xff學校專題，該APP客戶端是使用Flutter進行撰寫且試著使用API串接伺服端呈現後端的運行狀態！",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(width: 25.0),
        Text("撰寫時間: 2023/07/01~now",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(width: 25.0),
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
        SizedBox(height: 25),
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
      width: 100.0,
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
      width: 100.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: launchURL,
        child: const Text("Twitter"),
      ),
    );
  }
}

// ignore: camel_case_types
class btnMastdon extends StatelessWidget {
  const btnMastdon({super.key});

  final String URL = 'https://g0v.social/@neko_0xff';
  launchURL() {
    launch(URL);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: launchURL,
        child: const Text("Mastdon"),
      ),
    );
  }
}
