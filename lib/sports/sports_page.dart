import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class SportsPage extends StatefulWidget {

  final actionNumber = 8;
  final repLowBound = 8;
  final repUpBound = 30;
  final List actions = [
    "Squads",
    "Mountain climbers",
    "Push ups",
    "Jumping jacks",
    "High knees",
    "Jump squads",
    "Sit ups",
    "Jump lunges",
    "Top jumps",
    "Lunges",
  ];

  @override
  _State createState() => new _State();
}

class _State extends State<SportsPage> {

  Random _random = new Random(DateTime.now().millisecondsSinceEpoch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home workout"),
      ),
      body: Center(
          child: new RefreshIndicator(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: widget.actionNumber,
                itemBuilder: (context, index) => _randomWorkout()
            ),
            onRefresh: _refreshActions,
          )
      ),
    );
  }

  Card _randomWorkout() {
    int choice = _random.nextInt(widget.actions.length - 1);
    int reps = widget.repLowBound + _random.nextInt(widget.repUpBound - widget.repLowBound);
    return Card(
      child: ListTile(
        title: Text(widget.actions[choice]),
        trailing: Text("$reps Reps")
      )
    );
  }

  Future<void> _refreshActions() {
    setState(() {
      _random = new Random(DateTime.now().millisecondsSinceEpoch);
    });
    return Future.value(null);
  }
}