import 'package:flutter/material.dart';
import 'package:wfh_companion/meditation/meditation_page.dart';
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
      case RouteDest.Meditation:
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeditationPage()));
        break;
      default:
    }
  }
}