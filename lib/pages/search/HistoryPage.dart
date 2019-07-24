import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ns/model/search/ReadLogInfo.dart';
import 'package:ns/pages/book/DetailPage.dart';
import 'package:ns/utils/common/SpfUtils.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';
import 'package:ns/widgets/custom/CDivider.dart';

import 'SearchBookPage.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> histories = List();
  List<String> readlogs = List();

  @override
  void initState() {
    super.initState();

    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildHistory(),
            _buildReadLog(),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("搜索历史", style: TextStyle(color: ColorUtils.FONT_LABEL)),
              IconButton(
                icon: ImageIcon(AssetImage("images/delete.png"), size: 20.0),
                onPressed: () => _clear(StringUtils.KEY_SEARCH_HISTORY),
              )
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Wrap(
              spacing: 15.0,
              children: _buildHistoryItems(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHistoryItems() {
    return histories
        .map((history) => ActionChip(
            backgroundColor: ColorUtils.BG_WRAP,
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            label: Text(
              history,
              style: TextStyle(color: ColorUtils.FONT_LABEL),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchBookPage(history),
                ),
              );
            }))
        .toList();
  }

  void _initData() async {
    setState(() {
      histories = SpfUtils.getStringList(StringUtils.KEY_SEARCH_HISTORY);
      if (histories == null) histories = List();
      readlogs = SpfUtils.getStringList(StringUtils.KEY_READ_LOG);
      if (readlogs == null) readlogs = List();
    });
  }

  Widget _buildReadLog() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("阅读记录", style: TextStyle(color: ColorUtils.FONT_LABEL)),
              IconButton(
                icon: ImageIcon(AssetImage("images/delete.png"), size: 20.0),
                onPressed: () => _clear(StringUtils.KEY_READ_LOG),
              )
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Wrap(
              spacing: 15.0,
              children: _buildReadLogItem(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildReadLogItem() {
    return readlogs.map((log) {
      Map<String, dynamic> map = jsonDecode(log);
      var searchlog = ReadLogInfo.fromMap(map);
      return Column(
        children: [
          ListTile(
            title: Text(searchlog.bookName),
            dense: true,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPage(searchlog.unionId),
                ),
              );
            },
          ),
          CDivider(),
        ],
      );
    }).toList();
  }

  void _clear(String key) {
    SpfUtils.remove(key);
    _initData();
  }
}
