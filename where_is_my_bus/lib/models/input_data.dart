import 'package:flutter/foundation.dart';

class InputData extends ChangeNotifier {
  String startText = 'Staffelbergblick 13, 96148 Baunach';
  String endText = 'Bonn Hauptbahnhof';

  void changeText(text, textContent) {
    switch (text) {
      case 0:
        startText = textContent;
        break;
      case 1:
        endText = textContent;
        break;
    }
    notifyListeners();
  }
}
