import 'package:flutter/widgets.dart';
import 'package:ns/model/rank/MenuParams.dart';

class RankParamsNotifier with ChangeNotifier {
  MenuParams _params = MenuParams(1208, "连载榜", 1);
  MenuParams get params => _params;

  void setMenuid(menuid, title) {
    _params.menuId = menuid;
    _params.title = title;
    _params.page = 1;
    notifyListeners();
  }

  void getMore() {
    _params.page++;
    notifyListeners();
  }
}
