import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:where_is_my_bus/home/widgets/settings_text_field.dart';

import '../../constants.dart';

class SettingsView extends StatelessWidget {
  final BuildContext context;
  const SettingsView({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            builder: (context) {
              return Center(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  height: 550,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Einstellungen',
                              style: kAppTextStyle.copyWith(
                                  fontSize: 25,
                                  color: const Color.fromARGB(82, 0, 0, 0)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset('assets/svg/Shape.svg'),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            SizedBox(height: 100),
                            SettingsTextField(
                              text: 'Start',
                            ),
                            SizedBox(height: 20),
                            SettingsTextField(text: 'Ziel'),
                            SizedBox(height: 20),
                            SettingsTextField(text: 'Gehweg zur Haltestelle'),
                            SizedBox(height: 20)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            context: context);
      },
      child: SvgPicture.asset('assets/svg/hamburger.svg'),
    );
  }
}
