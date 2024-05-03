// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types,use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_master/modules/PreferencesUtil.dart';
import 'package:viewapp_master/pages/widget/wallpaper.dart';

TextEditingController loginNameStr = TextEditingController();
TextEditingController passwordStr = TextEditingController();
TextEditingController ConfirmPasswordStr = TextEditingController();
TextEditingController EmailStr = TextEditingController();

var focusedcolor = Colors.yellow;
var enablecolor = Colors.black;

class UpdateUserPage extends StatelessWidget {
  const UpdateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("更改使用者資料",
            style: TextStyle(
              color: Colors.black, // 設置文字顏色為黑色
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        backgroundColor: Colors.white,
        body: InputGet());
  }
}

class InputGet extends StatelessWidget {
  const InputGet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 5.0),
          const UpdateStr(),
          const SizedBox(height: 10.0),
          const btnView(),
          const SizedBox(height: 10.0),
          const SizedBox(height: 5.0),
          wallpaperLogin(),
        ],
      ),
    );
  }
}

class UpdateStr extends StatelessWidget {
  const UpdateStr({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        tbloginName(),
        tbEmail(),
        tbPassword(),
        tbConfirmPassword(),
      ],
    );
  }
}

class tbloginName extends StatelessWidget {
  const tbloginName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: loginNameStr,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            labelText: "Login Name",
            hintText: "Your account use a NickName",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: enablecolor)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: focusedcolor))),
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
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            labelText: "Email",
            hintText: "You are use a Email?",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: enablecolor)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: focusedcolor))),
      ),
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
      width: 150.0,
      height: 100.0,
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
    loginNameStr.text = "";
    EmailStr.text = "";
    passwordStr.text = "";
    ConfirmPasswordStr.text = "";
  }
}

class btnUpdateSend extends StatelessWidget {
  const btnUpdateSend({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      height: 100.0,
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
    String? loginName = loginNameStr.text;
    String? email = EmailStr.text;

    if (loginName == "" ||
        ConfirmPassword == "" ||
        password == "" ||
        email == "") {
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
    String? loginName = loginNameStr.text;
    String? password = passwordStr.text;
    String? email = EmailStr.text;

    final Uri uri = Uri.http(serverSource!, "/auth/UpdateUserData");
    final response = await http.post(uri, body: {
      "username": username,
      "password": password,
      "LoginName": loginName,
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
                pushToUpdateUser(context);
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
                pushToUpdateUser(context);
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
                pushToUpdateUser(context);
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
  void pushToUpdateUser(BuildContext context) {
    Navigator.pushNamed(context, '/updateUser');
  }
}
