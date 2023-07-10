import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:viewapp_v1/pages/out/about.dart';
import 'package:viewapp_v1/pages/user/login.dart';
import 'package:viewapp_v1/pages/user/register.dart';

void main() async {
  runApp(viewAppMain());
  await localNotifier.setup(
    appName: 'View App v1',
    // 参数 shortcutPolicy 仅适用于 Windows
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );
}

// ignore: use_key_in_widget_constructors, camel_case_types
class viewAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "View App v1",
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/about': (context) => const AboutPage(),
          '/register': (context) => const RegisterPage(),
        });
  }
}
