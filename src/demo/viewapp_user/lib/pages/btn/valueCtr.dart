// ignore_for_file: camel_case_types, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:viewapp_user/pages/out/control.dart';
import 'package:viewapp_user/pages/widget/usercustomValue.dart';
import 'package:viewapp_user/pages/widget/wallpaper.dart';

class valueCtrPage extends StatelessWidget {
  const valueCtrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue, backgroundColor: Colors.white),
        ),
        home: Scaffold(
          body: ControlPage(),
        ));
  }
}

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10.0),
        btnGoBack(),
        SizedBox(height: 10.0),
        Text("使用者自訂值",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.0),
        Control2(),
        SizedBox(height: 5.0),
        wallpaperLogin(),
        SizedBox(height: 10.0),
      ],
    ));
  }
}

class Control2 extends StatelessWidget {
  const Control2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: UserCustomValue());
  }
}

class btnGoBack extends StatelessWidget {
  const btnGoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Control()));
      },
      child: const Text('Go Back'),
      style: ElevatedButton.styleFrom(minimumSize: const Size(100, 80)),
    );
  }
}
