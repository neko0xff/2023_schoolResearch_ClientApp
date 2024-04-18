// ignore_for_file: avoid_web_libraries_in_flutter, use_key_in_widget_constructors, camel_case_types, depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:viewapp_master/pages/out/about.dart';
import 'package:viewapp_master/pages/user/forget.dart';
import 'package:viewapp_master/pages/user/login.dart';
import 'package:viewapp_master/pages/user/register.dart';
import 'package:viewapp_master/pages/user/updateUser.dart';


var focusedcolor = Colors.yellow;
var backcolor = Colors.black26;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PWAInstall().setup(installCallback: () {
    debugPrint('APP INSTALLED!');
  });
  // Check for PWA install prompt support (if necessary)
  if (defaultTargetPlatform == TargetPlatform.android) {
    //PWAInstall().promptInstall_();
  }else if(defaultTargetPlatform == TargetPlatform.iOS){
    //PWAInstall().promptInstall_();
  }

  runApp(viewAppMain());
  await Future.delayed(const Duration(seconds: 1));

}

class viewAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "View App master v3",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: focusedcolor, backgroundColor: backcolor),
          appBarTheme: AppBarTheme(
            color: focusedcolor,
            foregroundColor: backcolor,
            shadowColor: focusedcolor,
            surfaceTintColor: backcolor,
          ),
        ),
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/about': (context) => const AboutPage(),
          '/register': (context) => const RegisterPage(),
          '/forget': (context) => const forgetPage(),
          '/updateUser': (context) => const UpdateUserPage(),
        });
  }
}
