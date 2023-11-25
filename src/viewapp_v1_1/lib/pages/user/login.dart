// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, must_be_immutable, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_notifier/local_notifier.dart';
import 'package:viewapp_v1_1/class/user.dart';
import 'package:viewapp_v1_1/modules/PreferencesUtil.dart';
import 'package:viewapp_v1_1/pages/home.dart';

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
        title: const Text("Login"),
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
          LoginStr(),
          SizedBox(height: 15.0),
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
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green)
          )
        ),
      ),
    );
  }
}

class tbUsername extends StatelessWidget {
  const tbUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: usernameStr,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: "Username",
          hintText: "Your account username",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green)
            )
        ),
      ),
    );
  }
}

class tbPassword extends StatelessWidget {
  const tbPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: passwordStr,
        obscureText: true,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "Password",
          hintText: "Your account password",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green)
            )
        ),
      ),
    );
  }
}

class btnView extends StatelessWidget {
  const btnView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 15.0),
            btnLoginSend(),
            SizedBox(width: 15.0),
            btnToRegisterPage(),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 15.0),
            btnToforgetPage(),
            SizedBox(width: 15.0),
            btnClear(),
            SizedBox(width: 15.0),
          ],
        )
      ],
    ));
  }
}

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
          checkInputNull(context);
          sendUserData(context);
        },
      ),
    );
  }

  void checkInputNull(BuildContext context) {
    String? serverSource = serverSourceStr.text;
    String? username = usernameStr.text;
    String? password = passwordStr.text;

    if (serverSource == "" || username == "" || password == "") {
      showFailAlert(context);
    }
  }

  // 使用者比對部分
  Future<dynamic> sendUserData(BuildContext context) async {
    String? serverSource = serverSourceStr.text;
    String? username = usernameStr.text;
    String? password = passwordStr.text;

    final Uri uri = Uri.http(serverSource, "/auth/Login");
    final response = await http.post(uri, body: {
      "username": username,
      "password": password
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);
    final code = data["code"];
    final userData user = userData(
        serverSource: serverSourceStr.text,
        LoginName: data["LoginName"],
        username: data["username"]);
    LocalNotification notification = LocalNotification(
      title: "Tip",
      body: "Now Login User: ${data["LoginName"]} ",
    );

    /*主迴圈*/
    if (code == "1") {
      /*save Str in local*/
      PreferencesUtil.saveString('serverSource', serverSourceStr.text);
      PreferencesUtil.saveString('username', data["username"]);
      PreferencesUtil.saveString('LoginName', data["LoginName"]);
      notification.show(); //for Windows,Linux.macOS
      //Go To HomePage
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              key: null,
              user: user,
            ),
          ));
    } else if (code == "0") {
      showFailPasswordAlert(context);
    } else if (code == "-1") {
      showFailCNAlert(context);
    }
  }

  //輸出註冊失敗
  Future<void> showFailAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Fail!'),
          content: const Text('Please check you are Input Data!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushToLogin(context);
              },
            ),
          ],
        );
      },
    );
  }

  //輸入密碼失敗
  Future<void> showFailPasswordAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Fail!'),
          content: const Text('Please check you are Password!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushToLogin(context);
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
          title: const Text('Network Connection Fail!'),
          content: const Text('Please check you are Network & Server!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushToLogin(context);
              },
            ),
          ],
        );
      },
    );
  }

  //跳回登入主頁
  void pushToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}

class btnClear extends StatelessWidget {
  const btnClear({super.key});

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

class btnToRegisterPage extends StatelessWidget {
  const btnToRegisterPage({super.key});

  //跳回登入主頁
  void pushToRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
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

class btnToforgetPage extends StatelessWidget {
  const btnToforgetPage({super.key});

  //跳回登入主頁
  void pushToforget(BuildContext context) {
    Navigator.pushNamed(context, '/forget');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 40.0,
      child: ElevatedButton(
        child: const Text("Forget"),
        onPressed: () {
          pushToforget(context);
        },
      ),
    );
  }
}
