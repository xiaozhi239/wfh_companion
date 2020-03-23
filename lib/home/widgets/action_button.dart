import 'package:flutter/material.dart';
import 'package:wfh_companion/common/router.dart';

class ActionButton extends StatelessWidget {

  final Router router;
  final String text;
  final RouteDest routeDest;

  ActionButton({this.router, this.text, this.routeDest});

  @override
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 250,
      height: 80,
      child: FlatButton(
        padding: EdgeInsets.all(8.0),
        color: Colors.blue,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        splashColor: Colors.blueAccent,
        onPressed: () {
          router.route(context, routeDest);
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}