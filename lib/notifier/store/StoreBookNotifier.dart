import 'package:flutter/widgets.dart';
import 'package:ns/analysis/ZSData.dart';
import 'package:ns/model/analysis/ZSParams.dart';
import 'package:ns/utils/const/StringUtils.dart';

class StoreBookNotifier with ChangeNotifier {
  List _bookList = [];
  List get bookList => _bookList;

  void getBookList(ZSParams params) {
    ZSData.getBookList(params).then((retData) {
      var data = retData;

      List<dynamic> books = [];
      if (data["total"] == 0)
        books.add(StringUtils.ITEM_NONE);
      else {
        books..addAll(_bookList)..addAll(data["books"]);
        if (books.length >= data["total"]) books.add(StringUtils.ITEM_END);
      }
      _bookList = books;
      notifyListeners();
    });
  }

  void clear() {
    _bookList.clear();
    notifyListeners();
  }
}
