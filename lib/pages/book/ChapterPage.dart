import 'package:flutter/material.dart';
import 'package:ns/analysis/BookAnalysis.dart';
import 'package:ns/model/book/ChapterListInfo.dart';
import 'package:ns/utils/common/ToastUtils.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';
import 'package:ns/utils/data/BookUtils.dart';
import 'package:ns/widgets/custom/CAppBar.dart';
import 'package:ns/widgets/custom/CDivider.dart';
import 'package:ns/widgets/items/End.dart';
import 'package:ns/widgets/items/None.dart';

import 'ReadPage.dart';

class ChapterPage extends StatefulWidget {
  final String unionId;
  ChapterPage(this.unionId);

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  var _scrollController = ScrollController();
  var _code = "";
  var _chapterList = [];
  var _page = 1;
  var _order = 1;
  var _showNone = false;
  var _totalPage = 0;
  var _cTitle = "";

  @override
  void initState() {
    super.initState();

    loadAsync();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var item = _chapterList.last.toString();
        if (item != StringUtils.ITEM_END && item != StringUtils.ITEM_NONE) {
          _page++;
          _getChapterList();
        }
      }
    });
  }

  void loadAsync() async {
    var bookInfo = await BookUtils.getBookByUnionId(widget.unionId);
    _code = bookInfo.code;
    _page = bookInfo.cPage;
    _cTitle = bookInfo.cTitle;
    _getChapterList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(context, Text("章节列表"), true),
      body: _buildList(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildList() {
    if (_showNone) {
      return Container(
        child: Center(
          child: Text(
            "暂无章节信息，请更换其他源。",
            style: TextStyle(
              color: ColorUtils.FONT_TIP,
            ),
          ),
        ),
      );
    } else {
      if (_chapterList.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      return ListView.separated(
        itemCount: _chapterList.length,
        itemBuilder: (context, i) => _buildItem(_chapterList[i]),
        separatorBuilder: (context, i) => CDivider(),
        controller: _scrollController,
      );
    }
  }

  void _getChapterList() async {
    ChapterListInfo chapter =
        await BookAnalysis.getChapterList(_code, _page, _order);
    var tmp = [];
    if (chapter.chapterlist.length == 0)
      tmp.add(StringUtils.ITEM_NONE);
    else {
      tmp.addAll(_chapterList);
      tmp.addAll(chapter.chapterlist);
      if (_page == chapter.total) {
        tmp.add(StringUtils.ITEM_END);
      }
    }
    setState(() {
      _chapterList = tmp;
      _totalPage = chapter.total;
    });
  }

  Widget _buildItem(chapter) {
    switch (chapter.toString()) {
      case StringUtils.ITEM_END:
        return End();
      case StringUtils.ITEM_NONE:
        setState(() => _showNone = true);
        return None();
      default:
        return ListTile(
          dense: true,
          title: Text(
            chapter.title,
            style: TextStyle(
              fontSize: 15.0,
              color: ColorUtils.FONT_NORMAL,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Offstage(
            offstage: chapter.title != _cTitle,
            child: ImageIcon(
              AssetImage("images/location.png"),
              color: ColorUtils.RED,
              size: 18.0,
            ),
          ),
          onTap: () async {
            var suc = await BookUtils.updateChapter(
              widget.unionId,
              chapter.url,
              chapter.title,
              _page,
            );
            if (!suc) {
              ToastUtils.showToast("章节切换失败！请重试...");
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ReadPage(widget.unionId),
                ),
              );
            }
          },
        );
    }
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: ImageIcon(
                AssetImage("images/navigate.png"),
                color: _totalPage == 0
                    ? ColorUtils.FONT_DISABLED
                    : ColorUtils.MAIN,
              ),
              onPressed: () {
                if (_totalPage > 1) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => _buildNavigateDialog(),
                  );
                }
              },
            ),
            IconButton(
              icon: ImageIcon(
                AssetImage(
                  _order == 1 ? "images/order-up.png" : "images/order-down.png",
                ),
                color: ColorUtils.MAIN,
              ),
              onPressed: () {
                setState(() {
                  _page = 1;
                  _order = _order == 0 ? 1 : 0;
                  _chapterList.clear();
                });
                _getChapterList();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigateDialog() {
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height / 2,
      child: ListView(children: _buildNavigateItem()),
    );
  }

  List<Widget> _buildNavigateItem() {
    var list = List<Widget>();
    for (var i = 1; i <= _totalPage; i++) {
      var tile = ListTile(
        title: Text(
          "第${i.toString()}页",
          style: TextStyle(
            fontSize: 15.0,
            color: ColorUtils.FONT_NORMAL,
          ),
        ),
        trailing: Offstage(
          offstage: _page != i,
          child: ImageIcon(
            AssetImage("images/location.png"),
            color: ColorUtils.RED,
            size: 18.0,
          ),
        ),
        onTap: () {
          setState(() {
            _page = i;
            _chapterList.clear();
          });
          _getChapterList();
          Navigator.pop(context);
        },
      );
      list.add(tile);
    }
    return list;
  }
}
