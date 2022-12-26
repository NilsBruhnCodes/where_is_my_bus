import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_is_my_bus/constants.dart';
import 'package:where_is_my_bus/screens/home/home_screen.dart';
import 'package:where_is_my_bus/screens/home/widgets/settings_text_field.dart';
import 'package:where_is_my_bus/screens/loading_screen.dart';

import '../../../models/input_data.dart';

class SettingsView extends StatelessWidget {
  List textContent = [0, 0, 0];
  //0 is startText, 1 is endText, 2 is timeText
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
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        if (textContent[0] == 0 || textContent[1] == 0) {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return CupertinoAlertDialog(
                                title: Text('Achtung'),
                                content: Text(
                                    'Bitte gebe alle Daten ein und versuche es noche einmal.'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('Okay'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            }),
                          );
                        }
                        for (var i = 0; i < 3; i++) {
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
                            horizontal: 25,
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
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
