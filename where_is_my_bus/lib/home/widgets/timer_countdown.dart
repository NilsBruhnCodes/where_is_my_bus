import 'package:flutter/material.dart';
import 'package:where_is_my_bus/constants.dart';

class TimerCountdown extends StatelessWidget {
  final int _counter;

  const TimerCountdown({
    Key? key,
    required int counter,
    required int startCounter,
  })  : _counter = counter,
        super(key: key);

  String getContentOnCounter(bool time) {
    if (_counter ~/ 60 > 0) {
      if (time == true) {
        return (_counter ~/ 60).toString();
      }
      return 'min';
    }
    if (time == true) {
      return _counter.toString();
    }
    return 'sec';
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(height: 180),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  getContentOnCounter(true),
                  style: kAppTextStyle,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  getContentOnCounter(false),
                  style: kAppTextStyle.copyWith(
                    fontSize: 20,
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
