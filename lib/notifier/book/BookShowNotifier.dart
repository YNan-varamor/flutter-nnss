import 'package:flutter/widgets.dart';

class BookShowNotifier with ChangeNotifier {
  bool _showAll = false;
  bool get showAll => _showAll;

  bool _showBgColor = false;
  bool _showOther = false;

  bool get showBgColor => _showBgColor;
  bool get showOther => _showOther;

  void hide() {
    _showAll = false;
    _showBgColor = false;
    _showOther = false;
  }

  void toggle() {
    _showAll = !_showAll;
    if (!_showAll) {
      _showBgColor = false;
      _showOther = false;
    }
    notifyListeners();
  }

  void toggleBgColor() {
    _showBgColor = !_showBgColor;
    if (_showBgColor) {
      _showOther = false;
    }
    notifyListeners();
  }

  void toggleOther() {
    _showOther = !_showOther;
    if (_showOther) {
      _showBgColor = false;
    }
    notifyListeners();
  }
}
