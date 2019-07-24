import 'package:flutter/widgets.dart';
import 'package:ns/analysis/BookAnalysis.dart';
import 'package:ns/model/book/BookInfo.dart';
import 'package:ns/model/book/ChapterInfo.dart';
import 'package:ns/utils/data/BookUtils.dart';

class ShelfNotifier with ChangeNotifier {
  List<BookInfo> _bookList = [];
  List<BookInfo> get bookList => _bookList;

  ShelfNotifier();

  void deleteBook(BookInfo book) {
    BookUtils.deleteBook(book.unionId, (ret) {
      _bookList.remove(book);
      notifyListeners();
    });
  }

  void getBooks() {
    _bookList = [];
    BookUtils.getFollowBook((retData) async {
      var tmp = retData as List<Map<String, dynamic>>;
      _bookList.addAll(tmp.map((book) => BookInfo.fromMap(book)).toList());
      notifyListeners();

      for (var i = 0; i < _bookList.length; i++) {
        var book = _bookList[i];
        BookAnalysis.getLastContent(book.code).then((ChapterInfo retData) {
          if (retData == null)
            _bookList[i].chapter = "暂无章节信息";
          else
            _bookList[i].chapter = retData.title;
          notifyListeners();
        });
      }
    });
  }
}
