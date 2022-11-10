import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:where_is_my_bus/home/widgets/settings_view.dart';
import 'package:where_is_my_bus/home/widgets/timer_countdown.dart';

import 'widgets/popups/cupertino_pop_up.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late int _startCounter;
  int _counter = 62;

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
                  showDialog(
                      builder: (context) {
                        return SettingsView(context: context);
                      },
                      context: context);
                },
                child: SvgPicture.asset('assets/svg/hamburger.svg'),
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
