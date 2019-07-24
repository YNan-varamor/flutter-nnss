import 'package:flutter/widgets.dart';
import 'package:ns/model/analysis/ZSParams.dart';

class StoreParamsNotifier with ChangeNotifier {
  ZSParams _params = ZSParams("", "hot", "", "全部", 0, 20);
  ZSParams get params => _params;

  void setParams(type, catelog) {
    _params.gender = type;
    _params.major = catelog;
    _params.start = 0;
    _params.type = "hot";
    _params.minor = "全部";
    notifyListeners();
  }

  void setFilterType(type) {
    _params.type = type;
    _params.start = 0;
    notifyListeners();
  }

  void setSubcate(subcate) {
    _params.minor = subcate;
    _params.start = 0;
    notifyListeners();
  }

  void getMore() {
    _params.start = _params.start + _params.limit;
    notifyListeners();
  }
}
