import 'package:flutter/material.dart';
import 'package:wfh_companion/common/themes.dart';

class RoarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Roar")
          ],
        ),
      ),
    );
  }
}
