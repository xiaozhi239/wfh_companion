import 'package:flutter/material.dart';
import 'package:wfh_companion/common/router.dart';
import 'package:wfh_companion/home/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work from home companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(router: Router()),
    );
  }
}
