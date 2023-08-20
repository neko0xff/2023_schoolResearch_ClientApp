// ignore_for_file: non_constant_identifier_names,use_build_context_synchronously, camel_case_types, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// 定義輸入元件
TextEditingController serverSourceStr = TextEditingController();
TextEditingController usernameStr = TextEditingController();
TextEditingController loginNameStr = TextEditingController();
TextEditingController EmailStr = TextEditingController();
TextEditingController passwordStr = TextEditingController();
TextEditingController ConfirmPasswordStr = TextEditingController();

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
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
          RegisterStr(),
          SizedBox(height: 10.0),
          btnView(),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class RegisterStr extends StatelessWidget {
  const RegisterStr({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        tbServerSource(),
        tbloginName(),
        tbEmail(),
        tbUsername(),
        tbPassword(),
        tbConfirmPassword(),
      ],
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
        ),
      ),
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
          labelText: "Password",
          hintText: "Your account password",
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
        btnRegisterSend(),
        SizedBox(width: 20.0),
        btnClear(),
        SizedBox(width: 20.0),
        btnToLoginPage(),
        SizedBox(width: 20.0),
      ],
    );
  }
}

class btnRegisterSend extends StatelessWidget {
  const btnRegisterSend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0,
      height: 40.0,
      child: ElevatedButton(
        child: const Text("Register"),
        onPressed: () {
          checkInputNull(context);
          sendUserData(context);
        },
      ),
    );
  }

  void checkInputNull(BuildContext context) {
    String? serverSource = serverSourceStr.text;
    String? loginName = loginNameStr.text;
    String? username = usernameStr.text;
    String? password = passwordStr.text;
    String? email = EmailStr.text;
    String? ConfirmPassword = ConfirmPasswordStr.text;

    if (serverSource == "" ||
        loginName == "" ||
        username == "" ||
        password == "" ||
        email == "" ||
        ConfirmPassword == "") {
      showFailAlert(context);
    }
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
    String? serverSource = serverSourceStr.text;
    String? loginName = loginNameStr.text;
    String? username = usernameStr.text;
    String? password = passwordStr.text;
    String? email = EmailStr.text;

    final Uri uri = Uri.http(serverSource, "/CreateUser");
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
      showFailAlert(context);
    }
  }

  //輸出成功註冊
  Future<void> showFinnshAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register Finnish!'),
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

  //輸出註冊失敗
  Future<void> showFailAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register Fail!'),
          content: const Text('Please check you are Input Data!'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                pushToRegister(context);
              },
            ),
          ],
        );
      },
    );
  }

  //輸出註冊失敗
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
                pushToRegister(context);
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

  //跳回註冊主頁
  void pushToRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  // 顯示 SnackBar 訊息與自定義按鈕
  void showSnackBar_FailLogin(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login Fail"), // 簡單基本訊息
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

  void showSnackBar_FailCN(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Connect Fail"), // 簡單基本訊息
        duration: Duration(seconds: 5), // 停留時間
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
    loginNameStr.text = "";
    EmailStr.text = "";
    usernameStr.text = "";
    passwordStr.text = "";
    ConfirmPasswordStr.text = "";
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
