// ignore_for_file: camel_case_types, non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:viewapp_v2_1/modules/PreferencesUtil.dart';
import 'package:viewapp_v2_1/pages/table/switch01.dart';
import 'package:viewapp_v2_1/pages/widget/wallpaper.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green, backgroundColor: Colors.white),
        ),
        home: const Scaffold(
          body: MainPage(),
        ));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const SizedBox(height: 10.0),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Data1(),
            SizedBox(width: 10.0),
            Data2(),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text('Switch Status',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10.0),
        const Text('Switch01',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Data3(),
        const SizedBox(height: 10.0),
        wallpaperLogin(),
      ],
    ));
  }
}

class Data1 extends StatelessWidget {
  const Data1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Hello",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Data2 extends StatefulWidget {
  const Data2({super.key});

  @override
  _Data2State createState() => _Data2State();
}

class _Data2State extends State<Data2> {
  late Future<String?> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  Future<String?> getData() async {
    final String? loginName = await PreferencesUtil.getString("LoginName");
    return loginName;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        final loginName = snapshot.data;
        return output(loginName);
      },
    );
  }

  Widget output(String? loginName) {
    return Column(
      children: <Widget>[
        outLoginName(loginName),
      ],
    );
  }

  Widget outLoginName(String? loginName) {
    return Center(
      child: Column(
        children: <Widget>[
          Text('$loginName',
              style:
                  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class Data3 extends StatelessWidget {
  const Data3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SwitchTable1()]),
    );
  }
}
