import 'package:flutter/widgets.dart';
import 'package:ns/model/book/ContentInfo.dart';
//当前章节
class BookChapterNotifier with ChangeNotifier {
  //章节信息
  ContentInfo _chapter = ContentInfo("", "", "", "", "");
  ContentInfo get chapter => _chapter;
  //设置章节
  void setChapter(ContentInfo content) {
    _chapter = content;
    notifyListeners();
  }
}
