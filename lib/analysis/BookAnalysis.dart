import 'package:ns/model/book/ChapterInfo.dart';
import 'package:ns/model/book/ChapterListInfo.dart';
import 'package:ns/model/book/ContentInfo.dart';
import 'package:ns/utils/common/HttpUtils.dart';

class BookAnalysis {
  static String _urlSearch = "https://m.kuxiaoshuo.com/s.php?keyword=";
  static String _urlDetail = "https://m.kuxiaoshuo.com/";
  //获取书籍标识
  static Future<String> getCode(String bookName, String author) async {
    var url = _urlSearch + bookName;
    var html = await HttpUtils.getHtml(url);

    var regex = RegExp('<p class="line">(.*?)</p>');
    var list = regex.allMatches(html);
    var code = "";
    if (list.any((book) => book.group(1).contains(author))) {
      var book = list.firstWhere((book) {
        return book.group(1).contains(author);
      }).group(1);
      regex = new RegExp("href=\"([^\"]+)");
      code = regex.allMatches(book).toList()[1].group(1);
      code = code.replaceAll("/", "");
    }
    return code;
  }
  //获取章节列表
  static Future<ChapterListInfo> getChapterList(
      String code, int page, int order) async {
    var url = _urlDetail + code + "_" + page.toString();
    if (order == 1) url = url + "_" + order.toString();
    var html = await HttpUtils.getHtml(url);

    var regex = RegExp('<ul class="chapter">([^\"]+)</ul>');
    var chapter = regex
        .firstMatch(html)
        .group(1)
        .replaceAll("<span>", "")
        .replaceAll("</span>", "");
    regex = new RegExp("<a href='(.*?)'>(.*?)</a>");
    var chapterList = regex.allMatches(chapter).toList();

    var chapters = List<ChapterInfo>();
    chapterList.forEach((chapter) {
      var url = chapter.group(1);
      var title = chapter.group(2);
      chapters.add(ChapterInfo(title, url));
    });

    regex = RegExp("(第" + page.toString() + "/(.*?)页)");
    var totalPage = regex.firstMatch(html);
    return ChapterListInfo(int.parse(totalPage.group(2)), chapters);
  }
  //获取章节内容
  static Future<ContentInfo> getContent(String url) async {
    var nurl = _urlDetail + url;
    var html = await HttpUtils.getHtml(nurl);
    //获取标题
    var regex = RegExp('<div class="title">(.*?)</div>');
    var title = regex.firstMatch(html).group(1);
    //获取正文
    regex = RegExp(r'<div class="text">([\s\S]+?)<div class="navigator-no">');
    var content = regex.firstMatch(html).group(1);
    content = _dealContent(content);
    //获取翻页
    regex = RegExp(r'<div class="navigator-nobutton">([\s\S]+?)</div>');
    var div = regex.firstMatch(html).group(1);
    //翻页链接
    regex = new RegExp("href=\"([^\"]+)");
    var urls = regex.allMatches(div).toList();
    var forward = urls.first.group(1);
    var next = urls.last.group(1);

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
    var firstIdx;
    var lastIdx;
    var first;
    var last;
    while (content.contains("div")) {
      firstIdx = content.indexOf("<div ");
      if (firstIdx > -1) {
        first = content.substring(0, firstIdx);
        last = content.substring(firstIdx);

        lastIdx = last.indexOf("</div>");
        if (lastIdx > -1) {
          last = last.substring(lastIdx + "</div>".length);
        }
        content = first + last;
      } else {
        lastIdx = content.indexOf("</div>");
        content = content.substring(0, lastIdx);
      }
      content = content.replaceAll("<div>", "");
    }
    return content;
  }
  //检查是否是章节地址
  static String _checkUrl(String url) {
    if (!url.contains("html")) return "";
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
