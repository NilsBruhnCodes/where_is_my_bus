import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_is_my_bus/screens/home/widgets/settings_text_field.dart';
import 'package:where_is_my_bus/screens/loading_screen.dart';

import '../../../constants.dart';
import '../../../models/input_data.dart';

class SettingsView extends StatelessWidget {
  List textContent = [0, 0];
  //0 is startText, 1 is endText
  final BuildContext context;
  late String? startText;
  late String? endText;
  late String? timeText;
  SettingsView({
    Key? key,
    required this.context,
    this.startText,
    this.endText,
    this.timeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFffe34a),
                    ),
                    child: Text(
                      'Hier kannst du deinen Ort angeben, an dem du loslaufen wirst. Wir berechnen für dich automatisch, wann du von deinem Standort aus los musst, um pünktlich deinen Bus oder Bahn zu erreichen.',
                      style: kAppTextStyle.copyWith(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 70),
                  SettingsTextField(
                    text: 'Start',
                    hintText: 'Musterstraße1, 12345 Musterstadt',
                    onChanged: (value) {
                      textContent[0] = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  SettingsTextField(
                    text: 'Ziel',
                    hintText: 'Musterstraße 1, 12345 Musterstadt',
                    onChanged: (value) {
                      textContent[1] = value;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 75,
                    width: 120,
                    child: TextButton(
                      onPressed: () {
                        if (textContent[0] == 0 || textContent[1] == 0) {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return CupertinoAlertDialog(
                                title: const Text('Achtung'),
                                content: const Text(
                                    'Bitte gebe alle Daten ein und versuche es noche einmal.'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text('Okay'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            }),
                          );
                        }
                        for (var i = 0; i < 2; i++) {
                          Provider.of<InputData>(context, listen: false)
                              .changeText(i, textContent[i]);
                        }
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const LoadingScreen()),
                        );
                      },
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )),
                          child: Text(
                            'Okay →',
                            style: kAppTextStyle.copyWith(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        ),
      ),
    );
  }
}
