import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ns/model/cg/CGbookInfo.dart';
import 'package:ns/utils/common/HttpUtils.dart';
import 'package:ns/utils/common/SpfUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';
import 'package:ns/utils/const/UrlUtils.dart';
import 'package:ns/widgets/custom/CAppBar.dart';
import 'package:ns/widgets/custom/CDivider.dart';
import 'package:ns/widgets/items/End.dart';
import 'package:ns/widgets/items/None.dart';
import 'package:ns/widgets/items/SearchItem.dart';

class SearchBookPage extends StatefulWidget {
  final String keyword;
  SearchBookPage(this.keyword);

  @override
  _SearchBookPageState createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  var _scrollController = ScrollController();
  var _page = 1;
  var _bookList = [];

  @override
  void initState() {
    super.initState();

    _getBookList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var item = _bookList.last.toString();
        if (item != StringUtils.ITEM_END && item != StringUtils.ITEM_NONE) {
          _page++;
          _getBookList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(context, Text("关键字 - ${widget.keyword}"), true),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_bookList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      child: ListView.separated(
        itemCount: _bookList.length,
        itemBuilder: (context, i) => _buildItem(_bookList[i]),
        separatorBuilder: (context, i) => CDivider(),
        controller: _scrollController,
      ),
    );
  }

  Widget _buildItem(book) {
    switch (book.toString()) {
      case StringUtils.ITEM_END:
        return End();
      case StringUtils.ITEM_NONE:
        return None();
      default:
        return SearchItem(CGBookInfo.fromMap(book));
    }
  }

  void _getBookList() async {
    _setToHistory(widget.keyword);

    var url = UrlUtils.cg_search;
    Map<String, dynamic> params = Map();
    params["keyword"] = widget.keyword;
    params["page"] = _page;
    params["size"] = 20;

    var json = await HttpUtils.getAsync(url, params: params);
    var retData = jsonDecode(json.toString());
    var datas = retData["result"];
    var totalCnt = datas["total"];
    var books = datas["books"];

    var tmp = [];
    if (totalCnt == 0 || books == null) {
      tmp.add(StringUtils.ITEM_NONE);
    } else {
      tmp.addAll(_bookList);
      tmp.addAll(books);
      if (tmp.length >= totalCnt) tmp.add(StringUtils.ITEM_END);
    }
    setState(() => _bookList = tmp);
  }

  void _setToHistory(keyword) async {
    var histories = SpfUtils.getStringList(StringUtils.KEY_SEARCH_HISTORY);
    if (!histories.contains(keyword)) histories.insert(0, keyword);
    if (histories.length > 10) histories.removeRange(10, histories.length);
    SpfUtils.putStringList(StringUtils.KEY_SEARCH_HISTORY, histories);
  }
}
