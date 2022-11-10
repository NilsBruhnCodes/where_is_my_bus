import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPopUp extends StatelessWidget {
  const CupertinoPopUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Geh jetzt!'),
      content: const Text('Du musst jetzt rausgehen, sonst kommst du zu spät!'),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Okay!'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
