import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class MeditationPage extends StatefulWidget {

  @override
  _PageState createState() => new _PageState();
}

class _PageState extends State<MeditationPage> {
  bool _isStarted = false;
  Duration _duration = Duration(hours: 0, minutes: 0);
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take a pause"),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isStarted ?
            Image.asset("assets/images/meditation.jpg") :
            new Expanded(
                child: DurationPicker(
                  duration: _duration,
                  onChange: (val) {
                    this.setState(() => _duration = val);
                  },
                  snapToMins: 1.0,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: toggleState,
          child: Icon(this._isStarted ? Icons.stop : Icons.play_circle_filled)),
    );
  }


  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  void toggleState() {
    if (!_isStarted) {
      if (_duration.inMinutes < 1) {
        return;
      }
      playBell();
      timer = new Timer(_duration, handleTimeout);
    } else {
      timer.cancel();
    }
    setState(() {
      _isStarted = !_isStarted;
    });
  }

  void playBell() {
    // TODO: change to a consistent bell sound.
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.bell,
      volume: 0.5, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
  }

  void handleTimeout() {
    playBell();
    setState(() {
      _isStarted = false;
    });
  }
}