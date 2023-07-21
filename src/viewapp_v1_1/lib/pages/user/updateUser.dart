// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types,use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewapp_v1_1/modules/PreferencesUtil.dart';

TextEditingController loginNameStr = TextEditingController();
TextEditingController passwordStr = TextEditingController();
TextEditingController ConfirmPasswordStr = TextEditingController();

class UpdateUserPage extends StatelessWidget {
  const UpdateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update User Page"),
        automaticallyImplyLeading: true,
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
          UpdateStr(),
          SizedBox(height: 10.0),
          btnView(),
          SizedBox(height: 10.0),
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
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: "Login Name",
          hintText: "Your account use a NickName",
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
          labelText: "New Password",
          hintText: "Your account New password",
        ),
      ),
    );
  }
}

class tbConfirmPassword extends StatelessWidget {
  const tbConfirmPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      child: TextFormField(
        controller: ConfirmPasswordStr,
        obscureText: true,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "Confirm Password",
          hintText: "Password Check",
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
    loginNameStr.text = "";
    passwordStr.text = "";
    ConfirmPasswordStr.text = "";
  }
}

class btnUpdateSend extends StatelessWidget {
  const btnUpdateSend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0,
      height: 40.0,
      child: ElevatedButton(
        child: const Text("Update"),
        onPressed: () {
          sendUserData(context);
        },
      ),
    );
  }

  // 使用者比對部分
  void sendUserData(BuildContext context) {
    String? password = passwordStr.text;
    String? ConfirmPassword = ConfirmPasswordStr.text;

    if (password != ConfirmPassword) {
      showSnackBar_FailPassword(context);
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

    final Uri uri = Uri.http(serverSource!, "/UpdateUserData");
    final response = await http.post(uri, body: {
      "username": username,
      "password": password,
      "LoginName": loginName
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    final result = response.body;
    final data = jsonDecode(result);

    if (data["code"] == "1") {
      showFinnshAlert(context);
    } else if (data["code"] == "0") {
      showSnackBar_FailUpdate(context);
    } else {
      showSnackBar_FailCN(context);
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
    PreferencesUtil.clear();
    Navigator.pushNamed(context, '/login');
  }

  // 顯示 SnackBar 訊息與自定義按鈕
  void showSnackBar_FailUpdate(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Update Fail"), // 簡單基本訊息
        duration: Duration(seconds: 5), // 停留時間
      ),
    );
  }

  void showSnackBar_FailCN(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Connect Fail"), // 簡單基本訊息
        duration: Duration(seconds: 5), // 停留時間
      ),
    );
  }

  void showSnackBar_FailPassword(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password Not Confirm"), // 簡單基本訊息
        duration: Duration(seconds: 5), // 停留時間
      ),
    );
  }
}
