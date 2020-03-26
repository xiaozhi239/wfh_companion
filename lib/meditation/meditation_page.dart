import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

class MeditationPage extends StatefulWidget {

  @override
  _PageState createState() => new _PageState();
}

class _PageState extends State<MeditationPage> {
  bool _isStarted = true;
  Duration _duration = Duration(hours: 0, minutes: 0);

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
          onPressed: () {
            setState(() {
              _isStarted = !_isStarted;
            });
          },
          child: Icon(this._isStarted ? Icons.stop : Icons.play_circle_filled)),
    );
  }
}