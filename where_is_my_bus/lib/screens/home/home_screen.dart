import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:where_is_my_bus/screens/home/widgets/settings_view.dart';
import 'package:where_is_my_bus/screens/home/widgets/timer_countdown.dart';
import 'package:where_is_my_bus/models/input_data.dart';

import '../../services/departure_time.dart';
import 'widgets/popups/cupertino_pop_up.dart';

class HomeScreen extends StatefulWidget {
  int timeToDeparture;
  HomeScreen(this.timeToDeparture);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late int _startCounter;
  late int _counter;

  void _decrementCounter() {
    setState(
      () {
        _counter--;
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        //TODO: implement android PopUp
        return const CupertinoPopUp();
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _counter = widget.timeToDeparture;
    _startCounter = _counter;

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _decrementCounter();
        if (_counter == 0) {
          timer.cancel();
          //_dialogBuilder(context);
        }
        //TODO: implement PopUp if wanted
      },
    );

    controller = AnimationController(
      value: _startCounter.toDouble(),
      lowerBound: 0,
      upperBound: _startCounter.toDouble(),
      reverseDuration: Duration(seconds: _counter),
      vsync: this,
    );
    controller.reverse();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 80,
              left: 40,
              child: GestureDetector(
                  child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SettingsView(
                        context: context,
                      ),
                    ),
                  );
                },
                child: SvgPicture.asset('assets/svg/settings-filled.svg'),
              ))),
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              'assets/svg/bushesAndStreet.svg',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            bottom: 160,
            left: 180 - controller.value,
            child: Lottie.asset(
              'assets/bus.json',
              width: 220,
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: SvgPicture.asset('assets/svg/shield.svg'),
          ),
          TimerCountdown(counter: _counter, startCounter: _startCounter),
        ],
      ),
    );
  }
}
