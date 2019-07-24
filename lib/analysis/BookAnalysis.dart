import 'package:ns/model/book/ChapterInfo.dart';
import 'package:ns/model/book/ChapterListInfo.dart';
import 'package:ns/model/book/ContentInfo.dart';
import 'package:ns/utils/common/HttpUtils.dart';

class BookAnalysis {
  static String _urlSearch = "";
  static String _urlDetail = "";
  //获取书籍标识
  static Future<String> getCode(String bookName, String author) async {
    var url = _urlSearch + bookName;
    var html = await HttpUtils.getHtml(url);

   //逻辑已删除
    return code;
  }
  //获取章节列表
  static Future<ChapterListInfo> getChapterList(
      String code, int page, int order) async {
    var url = _urlDetail + code + "_" + page.toString();
    if (order == 1) url = url + "_" + order.toString();
    var html = await HttpUtils.getHtml(url);

   
   //逻辑已删除
    return ChapterListInfo(int.parse(totalPage.group(2)), chapters);
  }
  //获取章节内容
  static Future<ContentInfo> getContent(String url) async {
    var nurl = _urlDetail + url;
    var html = await HttpUtils.getHtml(nurl);
    
   //逻辑已删除
    return ContentInfo(
      title,
      content,
      url,
      _checkUrl(forward),
      _checkUrl(next),
    );
  }
  //处理内容
  static String _dealContent(String content) {
   
   //逻辑已删除
    return content;
  }
  //检查是否是章节地址
  static String _checkUrl(String url) {
    
   //逻辑已删除
    return url;
  }
  //获取第一章节
  static Future<ContentInfo> getFirstContent(String code) async {
    var chapterList = await getChapterList(code, 1, 1);
    if (chapterList.total == 0 || chapterList.chapterlist.length == 0)
      return null;
    var chapter = chapterList.chapterlist.first;
    var content = getContent(chapter.url);
    return content;
  }
  //获取最后章节
  static Future<ChapterInfo> getLastContent(String code) async {
    var chapterList = await getChapterList(code, 1, 0);
    if (chapterList.total == 0 || chapterList.chapterlist.length == 0)
      return null;
    var chapter = chapterList.chapterlist.first;
    return chapter;
  }
}
