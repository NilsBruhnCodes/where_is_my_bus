import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_is_my_bus/constants.dart';
import 'package:where_is_my_bus/screens/home/widgets/settings_view1.dart';
import 'package:where_is_my_bus/screens/home/widgets/timer_countdown.dart';

import '../loading_screen.dart';

class HomeScreen extends StatefulWidget {
  late int timeToDeparture;
  late String startStation;
  late String stopStation;
  HomeScreen(
      {required this.timeToDeparture,
      required this.startStation,
      required this.stopStation});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late AnimationController controller;
  late int _startCounter;
  late int _counter;
  late String _startStation;
  late String _stopStation;

  void _decrementCounter() {
    setState(
      () {
        _counter--;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _counter = widget.timeToDeparture;
    _startStation = widget.startStation;
    _stopStation = widget.stopStation;
    _startCounter = _counter;

    WidgetsBinding.instance.addObserver(this);

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _decrementCounter();
        if (_counter == 0) {
          timer.cancel();
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) {
              return const LoadingScreen();
            }),
          );
        }
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
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    final prefs = await SharedPreferences.getInstance();
    if (state == AppLifecycleState.resumed &&
        DateTime.now().millisecondsSinceEpoch -
                (prefs.getInt('timeStampForRefresh') ?? 0) >
            10) {
      await prefs.setInt(
          'timeStampForRefresh', DateTime.now().millisecondsSinceEpoch);
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => const LoadingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 40,
            child: GestureDetector(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const LoadingScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset('assets/svg/refresh.svg'),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 40,
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
              ),
            ),
          ),
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
          Column(
            children: [
              TimerCountdown(counter: _counter, startCounter: _startCounter),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFffe34a),
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 10,
                            width: MediaQuery.of(context).size.width - 20),
                        Text('Start Haltestelle:',
                            style: kAppTextStyle.copyWith(fontSize: 20)),
                        Text(
                          _startStation,
                          style: kAppTextStyle.copyWith(fontSize: 25),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            height: 20,
                            width: MediaQuery.of(context).size.width - 20),
                        Text('Stop Haltestelle:',
                            style: kAppTextStyle.copyWith(fontSize: 20)),
                        const SizedBox(height: 5),
                        Text(_stopStation,
                            style: kAppTextStyle.copyWith(fontSize: 25))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
