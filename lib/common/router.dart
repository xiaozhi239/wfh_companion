import 'package:flutter/material.dart';
import 'package:wfh_companion/roar/roar_page.dart';

enum RouteDest {
  Movies,
  Sports,
  Meditation,
  Roar,
}

class Router {

  void route(BuildContext context, RouteDest destination) async {
    switch (destination) {
      case RouteDest.Roar:
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoarPage()));
        break;
      default:
    }
  }
}