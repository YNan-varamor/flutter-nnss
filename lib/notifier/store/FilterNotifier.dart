import 'package:flutter/widgets.dart';

class FilterNotifier with ChangeNotifier {
  bool _show = false;
  bool get show => _show;

  void hide() {
    _show = false;
    notifyListeners();
  }

  void toggle() {
    _show = !show;
    notifyListeners();
  }
}
