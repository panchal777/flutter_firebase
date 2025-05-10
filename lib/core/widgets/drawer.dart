import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/utils/app_string.dart';
import 'package:flutter_firebase/core/utils/globals.dart';

import 'logout_alert.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final List<String> drawerList = [AppString.logOut];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: [
                  DrawerHeader(
                    margin: EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.person),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: RichText(
                              text: TextSpan(
                                text: Globals.currentUserModel.email,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        RichText(text: TextSpan(text: 'Trail Period')),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      children:
                          drawerList.map((e) {
                            return ListTile(
                              title: Text(
                                e,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                closeDrawer(context);
                                navigation(context, e, drawerList.indexOf(e));
                              },
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              minimum: EdgeInsets.all(10.0),
              child: RichText(
                text: TextSpan(
                  text: "Version 1.0.0",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void closeDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void navigation(BuildContext context, String routeName, int index) {
    switch (drawerList[index]) {
      case AppString.logOut:
        showLogoutDialog(context);
        break;
      default:
    }
  }
}
