import 'package:flutter/material.dart';
import 'package:wfh_companion/common/themes.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';

class RoarPage extends StatefulWidget {
  @override
  _RoarPageState createState() => new _RoarPageState();
}

class _RoarPageState extends State<RoarPage> {

  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;
  double _highestDb = 0;

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
            Text(
              infoText(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: recordIconPressed,
          child: Icon(this._isRecording ? Icons.stop : Icons.mic)),
    );
  }

  String infoText() {
    if (_isRecording) {
      return 'Come on, shout louder, you could do better!';
    } else {
      return _highestDb == 0 ? 'Press mic and start shouting!' : textWithGrade(_highestDb);
    }
  }

  String textWithGrade(double score) {
    if (score < 70) {
      return 'You only made {$score} DB noise, hope you do better in your life';
    } else if (score >= 70 && score < 100) {
      return 'You made {$score} DB noise, keep going!';
    } else {
      return 'You successfully made {$score} DB noise, I think you are ready to conquer the world!';
    }
  }

  void recordIconPressed() {
    if (_isRecording) {
      stopRecorder();
    } else {
      startRecorder();
    }
  }

  void onData(NoiseReading noiseReading) {
    print(noiseReading.toString());
    // Update highest db.
  }

  void startRecorder() async {
    print('***NEW RECORDING***');
    setState(() {
      this._isRecording = true;
    });
    try {
      _noiseMeter = new NoiseMeter();
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } on NoiseMeterException catch (exception) {
      print(exception);
      stopRecorder();
    }
  }

  void stopRecorder() async {
    print('***STOP RECORDING***');
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
