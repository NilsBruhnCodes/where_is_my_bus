import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputData extends ChangeNotifier {
  late String startText;
  late String endText;

  void changeText(text, textContent) async {
    final prefs = await SharedPreferences.getInstance();
    switch (text) {
      case 0:
        startText = textContent;
        await prefs.setString('startText', startText);
        break;
      case 1:
        endText = textContent;
        await prefs.setString('endText', endText);
        break;
    }
    notifyListeners();
  }
}
