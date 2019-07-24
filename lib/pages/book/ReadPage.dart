import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ns/analysis/BookAnalysis.dart';
import 'package:ns/config/SetConf.dart';
import 'package:ns/model/book/BookInfo.dart';
import 'package:ns/model/book/ContentInfo.dart';
import 'package:ns/model/search/ReadLogInfo.dart';
import 'package:ns/notifier/book/BookChapterNotifier.dart';
import 'package:ns/notifier/book/BookSetNotifier.dart';
import 'package:ns/notifier/book/BookShowNotifier.dart';
import 'package:ns/utils/common/SpfUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';
import 'package:ns/utils/data/BookUtils.dart';
import 'package:ns/widgets/components/book/ComReadBottomBar.dart';
import 'package:ns/widgets/components/book/ComReadContent.dart';
import 'package:ns/widgets/delegate/ContentDelegate.dart';
import 'package:provide/provide.dart';

class ReadPage extends StatefulWidget {
  final String unionId;
  ReadPage(this.unionId);

  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  BookInfo _bookInfo;
  List<ContentInfo> _contentList = [];

  bool isGet = false;

  @override
  void initState() {
    super.initState();

    _loadAsync();
  }

  void _loadAsync() async {
    _bookInfo = await BookUtils.getBookByUnionId(widget.unionId);
    _saveToReadLog(_bookInfo.bookName);
    _getContent();
  }

  @override
  Widget build(BuildContext context) {
    Provide.value<BookSetNotifier>(context).initSet();
    return Scaffold(
        body: Stack(
      children: [
        _buildContentArea(),
        Align(
          alignment: Alignment.bottomCenter,
          child: ComReadBottomBar(widget.unionId),
        )
      ],
    ));
  }

  Widget _buildContentArea() {
    if (_contentList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return Provide<BookSetNotifier>(builder: (context, child, nSet) {
      return GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: SetConf.bgColor[nSet.setInfo.bgColorIdx],
          child: ListView.custom(
            cacheExtent: 5.0,
            shrinkWrap: true,
            childrenDelegate: ContentDelegate(
              (context, i) => ComReadContent(_contentList[i]),
              childCount: _contentList.length,
              callback: (first, last) async {
                if (first == last && !isGet) {
                  var chapter = _contentList[first];
                  Provide.value<BookChapterNotifier>(context)
                      .setChapter(chapter);
                  BookUtils.updateChapter(
                    widget.unionId,
                    chapter.url,
                    chapter.title,
                    1,
                  );
                }

                if (first == last && _contentList.length > 1 && !isGet) {
                  isGet = true;

                  _getNext(_contentList.last);
                }
                if (first != last) {
                  isGet = false;
                }
              },
            ),
          ),
        ),
        onTapDown: (details) => _onTapDown(context, details),
      );
    });
  }

  void _onTapDown(
    BuildContext context,
    TapDownDetails details,
  ) {
    RenderBox box = context.findRenderObject();
    Offset localOffset = box.globalToLocal(details.globalPosition);
    var cut = box.size.height / 3;
    if (localOffset.dy < cut) {
      Provide.value<BookShowNotifier>(context).toggle();
    }
  }

  void _getContent() async {
    var cUrl = _bookInfo.cUrl;
    ContentInfo content;
    if (cUrl.isEmpty) {
      content = await BookAnalysis.getFirstContent(_bookInfo.code);
    } else {
      content = await BookAnalysis.getContent(cUrl);
    }
    if (content == null) {
      content = ContentInfo("", "暂无该书籍的章节信息", "", "", "");
    }
    if (content != null && content.nextUrl.isNotEmpty) {
      _getNext(content);
    }
    List<ContentInfo> tmp = []
      ..addAll(_contentList)
      ..add(content);
    setState(() => _contentList = tmp);
  }

  void _getNext(ContentInfo chapter) async {
    var url = chapter.nextUrl;
    if (url.isEmpty) {
      return;
    } else {
      BookAnalysis.getContent(url).then((content) {
        List<ContentInfo> tmp = []
          ..addAll(_contentList)
          ..add(content);
        setState(() => _contentList = tmp);
      });
    }
  }

  void _saveToReadLog(bookName) {
    var readLogs = SpfUtils.getStringList(StringUtils.KEY_READ_LOG);
    var log = ReadLogInfo(widget.unionId, bookName);
    var json = jsonEncode(log);
    readLogs.removeWhere((log) => log == json);
    readLogs.insert(0, json);
    if (readLogs.length > 20) readLogs.removeRange(20, readLogs.length);
    SpfUtils.putStringList(StringUtils.KEY_READ_LOG, readLogs);
  }
}
