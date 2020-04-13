import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';

import 'package:wfh_companion/roar/listening.dart';

class RoarPage extends StatefulWidget {
  @override
  _RoarPageState createState() => new _RoarPageState();
}

class _RoarPageState extends State<RoarPage> with SingleTickerProviderStateMixin {

  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;
  double _highestDb = 0;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
            new CustomPaint(
              painter: new ListeningIndicator(_animationController),
              child: new SizedBox(
                width: 200.0,
                height: 200.0,
              ),
            ),
            _infoPanel(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _recordIconPressed,
          child: Icon(this._isRecording ? Icons.stop : Icons.mic)),
    );
  }

  Widget _infoPanel() {
    final colors = [Colors.green, Colors.yellow[700], Colors.red[400]];
    return Visibility (
      visible: !_isRecording,
      child: Text(
        _highestDb == 0 ? "Press mic and start roaring" :
        "You made highest ${_highestDb.toStringAsFixed(1)} dB noise",
        style: TextStyle(fontSize: 18, color: colors[_noiseLevel(_highestDb)]),
      )
    );
  }

  int _noiseLevel(double decibels) {
    if (decibels < 70) {
      return 0;
    } else if (decibels >= 70 && decibels < 90) {
      return 1;
    } else {
      return 2;
    }
  }

  void _recordIconPressed() {
    if (_isRecording) {
      stopRecorder();
    } else {
      startRecorder();
    }
  }

  double _extractDecibels(String noiseReading) {
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

  void _onNoiseData(NoiseReading noiseReading) {
    // [VolumeReading: 66.69737886870621 dB]
    double decibels = _extractDecibels(noiseReading.toString());
    if (decibels > this._highestDb) {
      this._highestDb = decibels;
    }
  }

  void startRecorder() async {
    setState(() {
      this._isRecording = true;
      this._highestDb = 0;
    });
    _startAnimation();
    try {
      _noiseMeter = new NoiseMeter();
      _noiseSubscription = _noiseMeter.noiseStream.listen(_onNoiseData);
    } on NoiseMeterException catch (exception) {
      print(exception);
      stopRecorder();
    }
  }

  void stopRecorder() async {
    _stopAnimation();
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

  void _startAnimation() {
    _stopAnimation();
    _animationController.repeat(
      period: Duration(seconds: 1),
    );
  }

  void _stopAnimation() {
    _animationController.stop();
    _animationController.reset();
  }
}
