// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable, duplicate_ignore, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:viewapp_v1/class/user.dart';
import 'package:viewapp_v1/modules/PreferencesUtil.dart';
import 'package:viewapp_v1/pages/out/main.dart';
import 'package:viewapp_v1/pages/out/sensor.dart';
import 'package:viewapp_v1/pages/updateUser.dart';

// ignore: must_be_immutable
@immutable
class HomePage extends StatelessWidget {
  String? username;
  String? LoginName;
  String? serverSource;

  final userData user;
  HomePage({required Key? key, required this.user}) : super(key: key) {
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
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(text: "Main"),
              Tab(text: "Sensor"),
              Tab(text: "Activity"),
              Tab(text: "Issues"),
            ],
          ),
        ),
        body: TabBarView(
          children: const <Widget>[
            Main(),
            Sensor(),
            Text("Activity"),
            Text("Issues"),
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

// ignore: must_be_immutable
@immutable
class DrawerMenu extends StatelessWidget {
  String? username;
  String? LoginName;
  String? serverSource;
  DrawerMenu(
      {required Key? key, this.username, this.LoginName, this.serverSource})
      : super(key: key);

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
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
          ),
          const BtnAbout(),
          const BtnUpdateUser(),
          const BtnLogOut(),
        ],
      ),
    );
  }
}

class BtnLogOut extends StatelessWidget {
  const BtnLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.arrow_back)),
      title: const Text('Logout'),
      onTap: () {
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
        toLoginPage(context);
      },
    );
  }

  void toLoginPage(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }
}
