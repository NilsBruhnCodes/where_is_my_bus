import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:where_is_my_bus/constants.dart';
import 'package:where_is_my_bus/home/widgets/settings_text_field.dart';

class SettingsView extends StatelessWidget {
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
        height: 550,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/svg/Shape.svg'),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SettingsTextField(
                    text: 'Start',
                    onChanged: (value) {
                      startText = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  SettingsTextField(
                    text: 'Ziel',
                    onChanged: (value) {
                      endText = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  SettingsTextField(
                    text: 'Gehweg in Minuten',
                    onChanged: (value) {
                      timeText = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      print(startText);
                      print(endText);
                      print(timeText);
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
                          'Okay',
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
    );
  }
}
