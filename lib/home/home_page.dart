import 'package:flutter/material.dart';
import 'package:wfh_companion/common/router.dart';
import 'package:wfh_companion/home/widgets/action_button.dart';

class HomePage extends StatelessWidget {

  final Router router;

  HomePage({this.router});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WFH Companion"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ActionButton(router: router, text: "Movies", routeDest: RouteDest.Movies),
            ActionButton(router: router, text: "Sports", routeDest: RouteDest.Sports),
            ActionButton(router: router, text: "Meditation", routeDest: RouteDest.Meditation),
            ActionButton(router: router, text: "Roar", routeDest: RouteDest.Roar),
          ],
        ),
      ),
    );
  }
}
