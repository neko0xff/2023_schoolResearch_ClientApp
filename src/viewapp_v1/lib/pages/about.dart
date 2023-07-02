import 'package:flutter/material.dart';

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
      child: Column(
        children: <Widget>[
          Text("About"),
        ],
      ),
    );
  }
}
