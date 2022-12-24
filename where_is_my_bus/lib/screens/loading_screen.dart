import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:where_is_my_bus/screens/home/home_screen.dart';

import '../models/input_data.dart';
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
    getTime();
  }

  void getTime() async {
    TimeModel timeModel = TimeModel(
        context: context,
        startLocation: Provider.of<InputData>(context, listen: false).startText,
        endLocation: Provider.of<InputData>(context, listen: false).endText);
    try {
      var timeToDeparture = await timeModel.getDepartureTime();
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) {
          return HomeScreen(timeToDeparture);
        }),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: ((context) {
          return CupertinoAlertDialog(
            title: Text('Achtung!'),
            content: Text(
                ' Wir konnten kein Ergebnis mit deinen Angaben finden. Bitte gebe deine Daten erneut ein und versuche es noche einmal.'),
            actions: [
              CupertinoDialogAction(
                child: Text('Okay'),
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
