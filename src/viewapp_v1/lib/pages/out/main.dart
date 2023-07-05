// ignore_for_file: camel_case_types, non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:viewapp_v1/modules/PreferencesUtil.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: MainPage(),
        ));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(height: 10.0),
        Data1(),
        //SizedBox(height: 10.0),
        Data2(),
        SizedBox(height: 10.0),
      ],
    );
  }
}

class Data1 extends StatelessWidget {
  const Data1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Hello",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Data2 extends StatefulWidget {
  const Data2({Key? key}) : super(key: key);

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
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
