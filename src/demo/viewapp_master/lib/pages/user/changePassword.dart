// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types,use_build_context_synchronously, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/class/user.dart';
import 'package:viewapp_master/modules/PreferencesUtil.dart';

TextEditingController passwordStr = TextEditingController();
TextEditingController ConfirmPasswordStr = TextEditingController();

var focusedcolor = Colors.yellow;
var enablecolor = Colors.black;

class changePasswordPage extends StatelessWidget {
  String? username;
  String? LoginName;
  String? serverSource;
  String? email;
  final userMeta user;
  changePasswordPage({required super.key, required this.user}) {
    username = user.username;
    LoginName = user.LoginName;
    serverSource = user.serverSource;
    email = user.email;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("忘記密碼",
          style: TextStyle(
            color: Colors.black, // 設置文字顏色為黑色
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white,
      body: InputGet(
          key: null,
          username: username,
          LoginName: LoginName,
          serverSource: serverSource,
          email: email),
    );
  }
}

class InputGet extends StatelessWidget {
  String? username;
  String? LoginName;
  String? serverSource;
  String? email;
  InputGet(
      {required super.key,
      this.username,
      this.LoginName,
      this.serverSource,
      this.email});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          UpdateStr(
            key: null,
            username: username,
            LoginName: LoginName,
            serverSource: serverSource,
            email: email,
          ),
          const SizedBox(height: 10.0),
          const btnView(),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class UpdateStr extends StatelessWidget {
  String? username;
  String? LoginName;
  String? serverSource;
  String? email;
  UpdateStr(
      {required super.key,
      this.username,
      this.LoginName,
      this.serverSource,
      this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const SizedBox(
          width: 10,
          height: 20,
        ),
        InputTip(
            key: null,
            username: username,
            LoginName: LoginName,
            serverSource: serverSource,
            email: email),
        const tbPassword(),
        const tbConfirmPassword(),
      ],
    );
  }
}

class InputTip extends StatelessWidget {
  String? username;
  String? LoginName;
  String? serverSource;
  String? email;
  InputTip(
      {required super.key,
      this.username,
      this.LoginName,
      this.serverSource,
      this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(children: [
          const Text("查詢結果",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text("帳戶: $username ",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("顯示別名: $LoginName ",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("email: $email ",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
        ]),
        const SizedBox(height: 10),
        const Column(
          children: [
            Text("請輸新的密碼，且按下Update進行生效!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 10)
          ],
        )
      ],
    );
  }
}

class tbPassword extends StatefulWidget {
  const tbPassword({super.key});

  @override
  _tbPasswordState createState() => _tbPasswordState();
}

class _tbPasswordState extends State<tbPassword> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: passwordStr,
        obscureText: _isObscure, // Set obscureText based on _isObscure.
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          labelText: "Password",
          hintText: "Your account password",
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
      ),
    );
  }
}

class tbConfirmPassword extends StatefulWidget {
  const tbConfirmPassword({super.key});

  @override
  _tbConfirmPasswordState createState() => _tbConfirmPasswordState();
}

class _tbConfirmPasswordState extends State<tbConfirmPassword> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: ConfirmPasswordStr,
        obscureText: _isObscure, // Set obscureText based on _isObscure.
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          labelText: "Confirm Password",
          hintText: "Password Check",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enablecolor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedcolor),
          ),
          suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
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
        btnUpdateSend(),
        SizedBox(width: 20.0),
        btnClear(),
        SizedBox(width: 20.0),
      ],
    );
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
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
        ),
        child: const Text("Clear",
            style: TextStyle(color: Colors.black)
        ),
        onPressed: () {
          clearInput();
        },
      ),
    );
  }

  void clearInput() {
    passwordStr.text = "";
    ConfirmPasswordStr.text = "";
  }
}

class btnUpdateSend extends StatelessWidget {
  const btnUpdateSend({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 40.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
        ),
        child: const Text("Update",
            style: TextStyle(color: Colors.black)
        ),
        onPressed: () {
          sendUserData(context);
        },
      ),
    );
  }

  //確認使用者是否少填資料
  void checkInputNull(BuildContext context) {
    String? ConfirmPassword = ConfirmPasswordStr.text;
    String? password = passwordStr.text;

    if (ConfirmPassword == "" || password == "") {
      showFailAlert(context);
    }
  }

  // 使用者比對部分
  void sendUserData(BuildContext context) {
    String? password = passwordStr.text;
    String? ConfirmPassword = ConfirmPasswordStr.text;

    if (password != ConfirmPassword) {
      showFailPasswordAlert(context);
    } else {
      cnServer(context);
    }
  }

  Future<dynamic> cnServer(BuildContext context) async {
    final String? serverSource =
        await PreferencesUtil.getString("serverSource");
    final String? username = await PreferencesUtil.getString("username");
    final String? LoginName = await PreferencesUtil.getString("LoginName");
    final String? email = await PreferencesUtil.getString("email");
    String? password = passwordStr.text;

    final Uri uri = Uri.http(serverSource!, "/auth/UpdateUserData");
    final response = await http.post(uri, body: {
      "username": username,
      "password": password,
      "LoginName": LoginName,
      "email": email
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);

    if (data["code"] == "1") {
      showFinnshAlert(context);
    } else if (data["code"] == "0") {
      showFailAlert(context);
    } else {
      showFailCNAlert(context);
    }
  }

  //輸出成功註冊
  Future<void> showFinnshAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update User Finnish!'),
          content: const Text('Please Go to Login Page,You now can Login!'),
          backgroundColor: Colors.yellow,
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

  //輸出更新資料失敗
  Future<void> showFailAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Data Update Fail!'),
          content: const Text('Please check you are Input Data!'),
          backgroundColor: Colors.yellow,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushTochangePassword(context);
              },
            ),
          ],
        );
      },
    );
  }

  //連線失敗
  Future<void> showFailCNAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Network Connection Fail!'),
          content: const Text('Please check you are Network & Server!'),
          backgroundColor: Colors.yellow,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushTochangePassword(context);
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
          backgroundColor: Colors.yellow,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushTochangePassword(context);
              },
            ),
          ],
        );
      },
    );
  }

  //跳回登入主頁
  void pushToLogin(BuildContext context) {
    PreferencesUtil.clear();
    Navigator.pushNamed(context, '/login');
  }

  //跳回使用者資料更新主頁
  void pushTochangePassword(BuildContext context) {
    Navigator.of(context).pop();
  }
}
