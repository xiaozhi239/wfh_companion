import 'package:flutter/material.dart';
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
        title: Text("Roar"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            infoPanel(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: recordIconPressed,
          child: Icon(this._isRecording ? Icons.stop : Icons.mic)),
    );
  }

  Widget infoPanel() {
    if (_isRecording) {
      return Text(
        'Come on, shout louder, you could do better!',
        style: TextStyle(fontSize: 18),
      );
    } else {
      return Text(
        _highestDb == 0 ? 'Press mic and start shouting!' : textWithDecibels(_highestDb),
        style: TextStyle(fontSize: 18),
      );
    }
  }

  String textWithDecibels(double decibels) {
    final noise = decibels.toStringAsFixed(1);
    if (decibels <= 60) {
      return 'You only made $noise dB noise, good for your neightborhood.';
    } else if (decibels >= 60 && decibels < 80) {
      return 'You made $noise dB noise, keep going!';
    } else {
      return 'You successfully made $noise dB noise, I think you are ready to conquer the world!';
    }
  }

  void recordIconPressed() {
    if (_isRecording) {
      stopRecorder();
    } else {
      startRecorder();
    }
  }

  double extractDecibels(String noiseReading) {
    final pattern = new RegExp(r'\s+(\d+.\d+)\s+'); // 800 is the size of each chunk
    double max = 0;
    pattern.allMatches(noiseReading).forEach((match) {
      var db = double.parse(match[0]);
      if (db > max) {
        max = db;
      }
    });
    return max;
  }

  void onNoiseData(NoiseReading noiseReading) {
    // [VolumeReading: 66.69737886870621 dB]
    double decibels = extractDecibels(noiseReading.toString());
    if (decibels > this._highestDb) {
      this._highestDb = decibels;
    }
  }

  void startRecorder() async {
    setState(() {
      this._isRecording = true;
      this._highestDb = 0;
    });
    try {
      _noiseMeter = new NoiseMeter();
      _noiseSubscription = _noiseMeter.noiseStream.listen(onNoiseData);
    } on NoiseMeterException catch (exception) {
      print(exception);
      stopRecorder();
    }
  }

  void stopRecorder() async {
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
}
