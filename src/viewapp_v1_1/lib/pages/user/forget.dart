// ignore_for_file: non_constant_identifier_names,use_build_context_synchronously, camel_case_types, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1_1/class/user.dart';
import 'package:viewapp_v1_1/modules/PreferencesUtil.dart';
import 'package:viewapp_v1_1/pages/user/changePassword.dart';

// 定義輸入元件
TextEditingController serverSourceStr = TextEditingController();
TextEditingController EmailStr = TextEditingController();

class forgetPage extends StatelessWidget {
  const forgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
        automaticallyImplyLeading: false,
      ),
      body: const InputGet(),
    );
  }
}

class InputGet extends StatelessWidget {
  const InputGet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Text("請輸入註冊時所輸入email！",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Text("送出後則會自動查詢是否有該使用者存在",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          forgetStr(),
          SizedBox(height: 10.0),
          btnView(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class forgetStr extends StatelessWidget {
  const forgetStr({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[tbServerSource(), tbEmail()],
    );
  }
}

class tbServerSource extends StatelessWidget {
  const tbServerSource({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: serverSourceStr,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.info),
          labelText: "Server",
          hintText: "Your Server Address",
        ),
      ),
    );
  }
}

class tbEmail extends StatelessWidget {
  const tbEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: EmailStr,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.mail),
          labelText: "Email",
          hintText: "You are use a Email?",
        ),
      ),
    );
  }
}

class btnView extends StatelessWidget {
  const btnView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(width: 20.0),
        btnforgetSend(),
        SizedBox(width: 20.0),
        btnClear(),
        SizedBox(width: 20.0),
        btnToLoginPage(),
        SizedBox(width: 20.0),
      ],
    );
  }
}

class btnToLoginPage extends StatelessWidget {
  const btnToLoginPage({super.key});

  //跳回登入主頁
  void pushToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0,
      height: 40.0,
      child: ElevatedButton(
        child: const Text("Login"),
        onPressed: () {
          pushToLogin(context);
        },
      ),
    );
  }
}

class btnClear extends StatelessWidget {
  const btnClear({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0,
      height: 40.0,
      child: ElevatedButton(
        child: const Text("Clear"),
        onPressed: () {
          clearInput();
        },
      ),
    );
  }

  void clearInput() {
    serverSourceStr.text = "";
    EmailStr.text = "";
  }
}

class btnforgetSend extends StatelessWidget {
  const btnforgetSend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0,
      height: 40.0,
      child: ElevatedButton(
        child: const Text("Forget"),
        onPressed: () {
          checkInputNull(context);
          cnServer(context);
        },
      ),
    );
  }

  void checkInputNull(BuildContext context) {
    String? serverSource = serverSourceStr.text;
    String? email = EmailStr.text;

    if (serverSource == "" || email == "") {
      showFailAlert(context);
    }
  }

  Future<dynamic> cnServer(BuildContext context) async {
    String? serverSource = serverSourceStr.text;
    String? email = EmailStr.text;

    final Uri uri = Uri.http(serverSource, "/emailAuthCheck");
    final response = await http.post(uri, body: {
      "email": email
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);
    final userMeta user = userMeta(
        serverSource: serverSourceStr.text,
        LoginName: data["LoginName"],
        username: data["username"],
        email: data["email"]);

    if (data["code"] == "1") {
      PreferencesUtil.saveString('serverSource', serverSourceStr.text);
      PreferencesUtil.saveString('username', data["username"]);
      PreferencesUtil.saveString('LoginName', data["LoginName"]);
      PreferencesUtil.saveString('email', data["email"]);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => changePasswordPage(key: null, user: user)));
    } else if (data["code"] == "0") {
      showFailAlert(context);
    } else {
      showFailCNAlert(context);
    }
  }

  //輸出註冊失敗
  Future<void> showFailAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Forget Fail!'),
          content: const Text('Please check you are Input Data!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushToforget(context);
              },
            ),
          ],
        );
      },
    );
  }

  //輸出登入失敗
  Future<void> showFailCNAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Network Connection  Fail!'),
          content: const Text('Please check you are Network & Server!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushToforget(context);
              },
            ),
          ],
        );
      },
    );
  }

  //跳回忘記密碼主頁
  void pushToforget(BuildContext context) {
    Navigator.pushNamed(context, '/forget');
  }
}
