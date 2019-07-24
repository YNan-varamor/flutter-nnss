import 'package:flutter/widgets.dart';
import 'package:ns/model/rank/MenuParams.dart';
import 'package:ns/utils/common/HttpUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';
import 'package:ns/utils/const/UrlUtils.dart';

class RankBookNotifier with ChangeNotifier {
  List _bookList = [];
  List get bookList => _bookList;

  void clear() {
    _bookList.clear();
    notifyListeners();
  }

  void getBookList(MenuParams menu) {
    Map<String, dynamic> params = new Map();
    params["start_time"] = _calcDate();
    params["end_time"] = _calcDate();
    params["menu_id"] = menu.menuId;
    params["page"] = menu.page;
    params["page_size"] = 20;
    params["ver"] = "v1";

    HttpUtils.getAsync(UrlUtils.cg_rank, params: params).then((retData) {
      var result = retData["result"];
      var totalCnt = result["total"];

      List books = [];
      if (totalCnt == 0 || result["rank"] == null) {
        books.add(StringUtils.ITEM_NONE);
      } else {
        if (menu.page == 1) _bookList.clear();
        books..addAll(_bookList)..addAll(result["rank"]);
        if (books.length >= totalCnt) books.add(StringUtils.ITEM_END);
      }
      _bookList = books;
      notifyListeners();
    });
  }

  String _calcDate() {
    var now = new DateTime.now();
    var date = now.year.toString() +
        "-" +
        now.month.toString() +
        "-" +
        now.day.toString();
    return date;
  }
}
