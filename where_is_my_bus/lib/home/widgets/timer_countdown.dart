import 'package:flutter/material.dart';

class TimerCountdown extends StatelessWidget {
  const TimerCountdown({
    Key? key,
    required int counter,
    required int startCounter,
  })  : _counter = counter,
        _startCounter = startCounter,
        super(key: key);

  final int _counter;
  final int _startCounter;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(height: 180),
          SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: _counter / _startCounter,
                  color: Colors.black,
                  strokeWidth: 20,
                ),
                Center(
                  child: Text(
                    _counter.toString(),
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
