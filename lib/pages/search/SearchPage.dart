import 'package:flutter/material.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/widgets/custom/CAppBar.dart';

import 'HistoryPage.dart';
import 'SearchBookPage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        context,
        _buildSearchArea(),
        true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSearchArea() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: ColorUtils.WHITE,
      ),
      height: 32.0,
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "请输入书名或作者名",
          contentPadding: EdgeInsets.only(top: 4.0, left: 5.0),
        ),
        maxLines: 1,
        cursorColor: ColorUtils.MAIN,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onSubmitted: (keyword) {
          if (keyword.isNotEmpty) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SearchBookPage(keyword)),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: ColorUtils.MAIN,
      child: Container(
        margin: EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(
          color: ColorUtils.WHITE,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Column(
          children: [Expanded(child: HistoryPage())],
        ),
      ),
    );
  }
}
