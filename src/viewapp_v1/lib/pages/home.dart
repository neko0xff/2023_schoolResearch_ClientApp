// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable, duplicate_ignore

import 'package:flutter/material.dart';

// ignore: must_be_immutable
@immutable
class HomePage extends StatelessWidget {
  String? username;
  HomePage({required Key? key, this.username}) : super(key: key);

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
              Tab(text: "Home"),
              Tab(text: "Repo"),
              Tab(text: "Activity"),
              Tab(text: "Issues"),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Text("Home"),
            Text("Repo"),
            Text("Activity"),
            Text("Issues"),
          ],
        ),
        drawer: DrawerMenu(
          key: null,
          username: username,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
@immutable
class DrawerMenu extends StatelessWidget {
  String? username;
  DrawerMenu({required Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('$username'),
            accountEmail: const Text(''),
            //設定大頭照
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
          ),
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
    Navigator.pushNamed(context, '/login');
  }
}
