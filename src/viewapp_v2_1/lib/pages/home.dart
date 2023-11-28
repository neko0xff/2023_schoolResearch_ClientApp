// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable, duplicate_ignore, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:viewapp_v2_1/class/user.dart';
import 'package:viewapp_v2_1/modules/PreferencesUtil.dart';
import 'package:viewapp_v2_1/pages/out/control.dart';
import 'package:viewapp_v2_1/pages/out/main.dart';
import 'package:viewapp_v2_1/pages/out/news.dart';
import 'package:viewapp_v2_1/pages/out/view.dart';
import 'package:viewapp_v2_1/pages/user/updateUser.dart';

// ignore: must_be_immutable
@immutable
class HomePage extends StatelessWidget {
  String? username;
  String? LoginName;
  String? serverSource;

  final userData user;
  HomePage({required super.key, required this.user}) {
    username = user.username;
    LoginName = user.LoginName;
    serverSource = user.serverSource;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: const TabBar(
            labelColor: Colors.white,
            dividerColor: Colors.white,
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home), text: "Main"),
              Tab(icon: Icon(Icons.list), text: "Data"),
              Tab(icon: Icon(Icons.switch_right_sharp), text: "Control"),
              Tab(icon: Icon(Icons.account_balance_outlined), text: "News"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Main(),
            ViewData(),
            Control(),
            NewsData(),
          ],
        ),
        drawer: DrawerMenu(
          key: null,
          username: username,
          LoginName: LoginName,
          serverSource: serverSource,
        ),
      ),
    );
  }
}

@immutable
class DrawerMenu extends StatelessWidget {
  String? username;
  String? LoginName;
  String? serverSource;
  DrawerMenu(
      {required super.key, this.username, this.LoginName, this.serverSource});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('$LoginName'),
            accountEmail: Text('$username@$serverSource'),
            //設定大頭照
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/twitter.webp"),
            ),
          ),
          const BtnAbout(),
          const BtnUpdateUser(),
          BtnLogOut(),
        ],
      ),
    );
  }
}

class BtnLogOut extends StatelessWidget {
  BtnLogOut({super.key});
  LocalNotification notification = LocalNotification(
    title: "Tip",
    body: "Now Logout",
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.arrow_back)),
      title: const Text('Logout'),
      onTap: () {
        notification.show(); //for Windows,Linux.macOS
        toLoginPage(context);
      },
    );
  }

  void toLoginPage(BuildContext context) {
    PreferencesUtil.clear();
    Navigator.pushNamed(context, '/login');
  }
}

class BtnUpdateUser extends StatelessWidget {
  const BtnUpdateUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.account_circle_outlined)),
      title: const Text('Update User data'),
      onTap: () {
        toUpdateUserPage(context);
      },
    );
  }

  void toUpdateUserPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpdateUserPage()));
  }
}

class BtnAbout extends StatelessWidget {
  const BtnAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.info)),
      title: const Text('About'),
      onTap: () {
        toAboutPage(context);
      },
    );
  }

  void toAboutPage(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }
}
