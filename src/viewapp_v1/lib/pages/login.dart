import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1/pages/home.dart';
import 'package:viewapp_v1/pages/register.dart';

// 定義輸入元件
TextEditingController serverSourceStr = TextEditingController();
TextEditingController usernameStr = TextEditingController();
TextEditingController passwordStr = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
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
          LoginStr(),
          SizedBox(height: 10.0),
          btnView(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class LoginStr extends StatelessWidget {
  const LoginStr({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[tbServerSource(), tbUsername(), tbPassword()],
    );
  }
}

// ignore: camel_case_types
class tbServerSource extends StatelessWidget {
  const tbServerSource({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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

// ignore: camel_case_types
class tbUsername extends StatelessWidget {
  const tbUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: TextFormField(
        controller: usernameStr,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: "Name",
          hintText: "Your account username",
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class btnView extends StatelessWidget {
  const btnView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(width: 25.0),
        btnLoginSend(),
        SizedBox(width: 25.0),
        btnLoginClear(),
        SizedBox(width: 25.0),
        btnToRegisterPage()
      ],
    );
  }
}

// ignore: camel_case_types
class tbPassword extends StatelessWidget {
  const tbPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: TextFormField(
        controller: passwordStr,
        obscureText: true,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "Password",
          hintText: "Your account password",
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class btnLoginSend extends StatelessWidget {
  const btnLoginSend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 40.0,
      child: ElevatedButton(
        child: const Text("Login"),
        onPressed: () {
          sendUserData(context);
        },
      ),
    );
  }

  // 使用者比對部分
  Future<dynamic> sendUserData(BuildContext context) async {
    String? serverSource = serverSourceStr.text;
    String? username = usernameStr.text;
    String? password = passwordStr.text;

    final Uri uri = Uri.http(serverSource, "/Login");
    final response = await http.post(uri, body: {
      "username": username,
      "password": password
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);

    /*主迴圈*/
    if (data["code"] == "1") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            username: usernameStr.text,
            key: null,
          ),
        ),
      );
    } else if (data["code"] == "0") {
      // ignore: use_build_context_synchronously
      showSnackBar_FailLogin(context);
    } else if (data["code"] == "-1") {
      // ignore: use_build_context_synchronously
      showSnackBar_FailCN(context);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar_FailCN(context);
    }
  }

  //跳到下一頁
  void pushToHome(BuildContext context) {}

  // 顯示 SnackBar 訊息與自定義按鈕
  // ignore: non_constant_identifier_names
  void showSnackBar_FailLogin(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login Fail"), // 簡單基本訊息
        duration: Duration(seconds: 5), // 停留時間
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void showSnackBar_FailCN(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Connect Fail"), // 簡單基本訊息
        duration: Duration(seconds: 5), // 停留時間
      ),
    );
  }
}

// ignore: camel_case_types
class btnLoginClear extends StatelessWidget {
  const btnLoginClear({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
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
    usernameStr.text = "";
    passwordStr.text = "";
  }
}

// ignore: camel_case_types
class btnToRegisterPage extends StatelessWidget {
  const btnToRegisterPage({super.key});

  //跳回登入主頁
  void pushToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 40.0,
      child: ElevatedButton(
        child: const Text("Register"),
        onPressed: () {
          pushToRegister(context);
        },
      ),
    );
  }
}
