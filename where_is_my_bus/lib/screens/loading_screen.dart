import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_is_my_bus/screens/home/home_screen.dart';

import '../services/departure_time.dart';
import 'home/widgets/settings_view.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getTimeAndStartStation();
  }

  void getTimeAndStartStation() async {
    final prefs = await SharedPreferences.getInstance();
    TimeModel timeModel = TimeModel(
        context: context,
        startLocation: prefs.getString('startText') ?? 'Berlin',
        endLocation: prefs.getString('endText') ?? 'München');
    try {
      int timeToDeparture = await timeModel.getDepartureTime();
      while (timeToDeparture <= 0) {
        timeToDeparture = await timeModel.getDepartureTime();
      }
      var startStation = await timeModel.getStartStation();
      var stopStation = await timeModel.getStopStation();

      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) {
          return HomeScreen(
            timeToDeparture: timeToDeparture,
            startStation: startStation,
            stopStation: stopStation,
          );
        }),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: ((context) {
          return CupertinoAlertDialog(
            title: const Text('Achtung!'),
            content: const Text(
                ' Wir konnten kein Ergebnis mit deinen Angaben finden. Bitte gebe deine Daten erneut ein und überprüfe deine Internet Verbindung.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) {
                      return SettingsView(context: context);
                    }),
                  );
                },
              )
            ],
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}
