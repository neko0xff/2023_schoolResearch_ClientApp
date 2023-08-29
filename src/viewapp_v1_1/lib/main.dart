// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:viewapp_v1_1/pages/out/about.dart';
import 'package:viewapp_v1_1/pages/user/forget.dart';
import 'package:viewapp_v1_1/pages/user/login.dart';
import 'package:viewapp_v1_1/pages/user/register.dart';
import 'package:viewapp_v1_1/pages/user/updateUser.dart';

void main() async {
  ui.platformViewRegistry.registerViewFactory(
      'WebApp', (_) => DivElement()..innerText = 'View App v1.1');
  ui.debugEmulateFlutterTesterEnvironment = false;

  runApp(viewAppMain());
  /* localNotifier: Only Windows,Linux.macOS */
  await localNotifier.setup(
    appName: 'View App v1.1',
    shortcutPolicy:
        ShortcutPolicy.requireCreate, // shortcutPolicy: 仅适用于 Windows
  );
}

class viewAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VisualDensity density = Theme.of(context).visualDensity;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "View App v1.1",
        theme: ThemeData(primarySwatch: Colors.green, visualDensity: density),
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/about': (context) => const AboutPage(),
          '/register': (context) => const RegisterPage(),
          '/forget': (context) => const forgetPage(),
          '/updateUser': (context) => const UpdateUserPage()
        });
  }
}
