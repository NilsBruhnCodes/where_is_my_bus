import 'package:flutter/material.dart';

import '../../constants.dart';

class SettingsTextField extends StatelessWidget {
  final String text;

  const SettingsTextField({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: kAppTextStyle.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 20),
        Material(
          child: TextField(
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: text,
                labelStyle: kAppTextStyle.copyWith(
                    fontSize: 20, color: const Color.fromARGB(82, 0, 0, 0))),
          ),
        ),
      ],
    );
  }
}
