import 'package:flutter/widgets.dart';
import 'package:ns/config/SetConf.dart';
import 'package:ns/model/book/SetInfo.dart';
import 'package:ns/utils/data/SetUtils.dart';
//阅读页设置
class BookSetNotifier with ChangeNotifier {
  SetInfo _setInfo = SetInfo(0, 15, false);
  SetInfo get setInfo => _setInfo;

  void initSet() async {
    _setInfo = await SetUtils.getSettings();
  }

  void setBgColor(bgColorIdx) {
    _setInfo.bgColorIdx = bgColorIdx;
    SetUtils.updateBgColor(bgColorIdx);
    notifyListeners();
  }

  void toggleNightMod() {
    _setInfo.nightMod = !_setInfo.nightMod;
    if (_setInfo.nightMod) {
      _setInfo
        ..srcBgColorIdx = _setInfo.bgColorIdx
        ..bgColorIdx = SetConf.bgColor.length - 1;
    } else {
      _setInfo.bgColorIdx = _setInfo.srcBgColorIdx;
    }
    notifyListeners();
  }

  void addFontSize() {
    _setInfo.fontSize++;
    SetUtils.updateFontSize(_setInfo.fontSize);
    notifyListeners();
  }

  void reduceFontSize() {
    _setInfo.fontSize--;
    SetUtils.updateFontSize(_setInfo.fontSize);
    notifyListeners();
  }
}
