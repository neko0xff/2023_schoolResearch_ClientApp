// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_print, unused_field, file_names, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1_1/modules/PreferencesUtil.dart';

class UserCustomValue extends StatefulWidget {
  const UserCustomValue({Key? key}) : super(key: key);

  @override
  _UserCustomValueState createState() => _UserCustomValueState();
}

class _UserCustomValueState extends State<UserCustomValue> {
  late TextEditingController userSelectedValue01;
  late TextEditingController userSelectedValue02;
  late TextEditingController userSelectedValue03;
  late TextEditingController userSelectedValue04;
  late TextEditingController userSelectedValue05;
  late TextEditingController userSelectedValue06;
  late TextEditingController userSelectedValue07;
  String _setValue = "";
  String _setNum = "0";

  @override
  void initState() {
    super.initState();
    userSelectedValue01 = TextEditingController();
    userSelectedValue02 = TextEditingController();
    userSelectedValue03 = TextEditingController();
    userSelectedValue04 = TextEditingController();
    userSelectedValue05 = TextEditingController();
    userSelectedValue06 = TextEditingController();
    userSelectedValue07 = TextEditingController();
    _getUserValueStatus();
  }

  @override
  void dispose() {
    userSelectedValue01.dispose();
    userSelectedValue02.dispose();
    userSelectedValue03.dispose();
    userSelectedValue04.dispose();
    userSelectedValue05.dispose();
    userSelectedValue06.dispose();
    userSelectedValue07.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          UserValue01ctr(
            userSelectedValue01: userSelectedValue01,
            onChanged: (value) {
              setState(() {
                _setValue = "customvar01";
                _setNum = value;
                PreferencesUtil.saveString("UserValue1", value);
              });
              _connectToServer(context);
            },
          ),
          const SizedBox(height: 20),
          UserValue02ctr(
            userSelectedValue02: userSelectedValue02,
            onChanged: (value) {
              setState(() {
                _setValue = "customvar02";
                _setNum = value;
                PreferencesUtil.saveString("UserValue2", value);
              });
              _connectToServer(context);
            },
          ),
          const SizedBox(height: 20),
          UserValue03ctr(
            userSelectedValue03: userSelectedValue03,
            onChanged: (value) {
              setState(() {
                _setValue = "customvar03";
                _setNum = value;
                PreferencesUtil.saveString("UserValue3", value);
              });
              _connectToServer(context);
            },
          ),
          const SizedBox(height: 20),
          UserValue04ctr(
            userSelectedValue04: userSelectedValue04,
            onChanged: (value) {
              setState(() {
                _setValue = "customvar04";
                _setNum = value;
                PreferencesUtil.saveString("UserValue4", value);
              });
              _connectToServer(context);
            },
          ),
          const SizedBox(height: 20),
          UserValue05ctr(
            userSelectedValue05: userSelectedValue05,
            onChanged: (value) {
              setState(() {
                _setValue = "customvar05";
                _setNum = value;
                PreferencesUtil.saveString("UserValue5", value);
              });
              _connectToServer(context);
            },
          ),
          const SizedBox(height: 20),
          UserValue06ctr(
            userSelectedValue06: userSelectedValue06,
            onChanged: (value) {
              setState(() {
                _setValue = "customvar06";
                _setNum = value;
                PreferencesUtil.saveString("UserValue6", value);
              });
              _connectToServer(context);
            },
          ),
          const SizedBox(height: 20),
          UserValue07ctr(
            userSelectedValue07: userSelectedValue07,
            onChanged: (value) {
              setState(() {
                _setValue = "customvar07";
                _setNum = value;
                PreferencesUtil.saveString("UserValue7", value);
              });
              _connectToServer(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _getUserValueStatus() async {
    String? userValue1Status = await PreferencesUtil.getString("UserValue1");
    if (userValue1Status != null) {
      setState(() {
        _setNum = userValue1Status;
        _setValue = "customvar01";
      });
    }
    String? userValue2Status = await PreferencesUtil.getString("UserValue2");
    if (userValue2Status != null) {
      setState(() {
        _setNum = userValue2Status;
        _setValue = "customvar02";
      });
    }
    String? userValue3Status = await PreferencesUtil.getString("UserValue3");
    if (userValue3Status != null) {
      setState(() {
        _setNum = userValue3Status;
        _setValue = "customvar03";
      });
    }
    String? userValue4Status = await PreferencesUtil.getString("UserValue4");
    if (userValue4Status != null) {
      setState(() {
        _setNum = userValue4Status;
        _setValue = "customvar04";
      });
    }
    String? userValue5Status = await PreferencesUtil.getString("UserValue5");
    if (userValue5Status != null) {
      setState(() {
        _setNum = userValue5Status;
        _setValue = "customvar05";
      });
    }
    String? userValue6Status = await PreferencesUtil.getString("UserValue6");
    if (userValue6Status != null) {
      setState(() {
        _setNum = userValue6Status;
        _setValue = "customvar06";
      });
    }
    String? userValue7Status = await PreferencesUtil.getString("UserValue7");
    if (userValue7Status != null) {
      setState(() {
        _setNum = userValue7Status;
        _setValue = "customvar07";
      });
    }
  }

  Future<void> _connectToServer(BuildContext context) async {
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final String? username = await PreferencesUtil.getString("username");

    // UserValue01
    final Uri uri = Uri.http(serverSource!, "/Set/UserCustomValue");
    final response = await http.post(uri, body: {
      "username": username,
      "ValueName": _setValue,
      "num": _setNum
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);
    final code = data["code"];
    print(data);

    if (code == "1") {
      showFinnishAlert(context);
    } else if (code == "0") {
      showFailSetAlert(context);
    } else if (code == "-1") {
      showFailCNAlert(context);
    }
  }

  //輸出上傳成功
  Future<void> showFinnishAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Finnish!'),
          content: const Text('Value is upload data!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //輸出上傳失敗
  Future<void> showFailCNAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Network Connection Fail!'),
          content: const Text('Please check you are Network & Server!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //輸出連結失敗
  Future<void> showFailSetAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Fail!'),
          content: const Text('Please check you are Input Data!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class UserValue01ctr extends StatelessWidget {
  final TextEditingController userSelectedValue01;
  final ValueChanged<String> onChanged;

  const UserValue01ctr({
    Key? key,
    required this.userSelectedValue01,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: userSelectedValue01,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.numbers),
              labelText: "User Custom Value 01",
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              onChanged(userSelectedValue01.text);
            },
            child: const Text("Send")),
        const SizedBox(width: 20),
      ],
    );
  }
}

class UserValue02ctr extends StatelessWidget {
  final TextEditingController userSelectedValue02;
  final ValueChanged<String> onChanged;

  const UserValue02ctr({
    Key? key,
    required this.userSelectedValue02,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: userSelectedValue02,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.numbers),
              labelText: "User Custom Value 02",
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              onChanged(userSelectedValue02.text);
            },
            child: const Text("Send")),
        const SizedBox(width: 20),
      ],
    );
  }
}

class UserValue03ctr extends StatelessWidget {
  final TextEditingController userSelectedValue03;
  final ValueChanged<String> onChanged;

  const UserValue03ctr({
    Key? key,
    required this.userSelectedValue03,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: userSelectedValue03,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.numbers),
              labelText: "User Custom Value 03",
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              onChanged(userSelectedValue03.text);
            },
            child: const Text("Send")),
        const SizedBox(width: 20),
      ],
    );
  }
}

class UserValue04ctr extends StatelessWidget {
  final TextEditingController userSelectedValue04;
  final ValueChanged<String> onChanged;

  const UserValue04ctr({
    Key? key,
    required this.userSelectedValue04,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: userSelectedValue04,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.numbers),
              labelText: "User Custom Value 04",
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              onChanged(userSelectedValue04.text);
            },
            child: const Text("Send")),
        const SizedBox(width: 20),
      ],
    );
  }
}

class UserValue05ctr extends StatelessWidget {
  final TextEditingController userSelectedValue05;
  final ValueChanged<String> onChanged;

  const UserValue05ctr({
    Key? key,
    required this.userSelectedValue05,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: userSelectedValue05,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.numbers),
              labelText: "User Custom Value 05",
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              onChanged(userSelectedValue05.text);
            },
            child: const Text("Send")),
        const SizedBox(width: 20),
      ],
    );
  }
}

class UserValue06ctr extends StatelessWidget {
  final TextEditingController userSelectedValue06;
  final ValueChanged<String> onChanged;

  const UserValue06ctr({
    Key? key,
    required this.userSelectedValue06,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: userSelectedValue06,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.numbers),
              labelText: "User Custom Value 06",
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              onChanged(userSelectedValue06.text);
            },
            child: const Text("Send")),
        const SizedBox(width: 20),
      ],
    );
  }
}

class UserValue07ctr extends StatelessWidget {
  final TextEditingController userSelectedValue07;
  final ValueChanged<String> onChanged;

  const UserValue07ctr({
    Key? key,
    required this.userSelectedValue07,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: userSelectedValue07,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.numbers),
              labelText: "User Custom Value 07",
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              onChanged(userSelectedValue07.text);
            },
            child: const Text("Send")),
        const SizedBox(width: 20),
      ],
    );
  }
}
