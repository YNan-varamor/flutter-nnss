import 'package:flutter/material.dart';
import 'package:ns/model/store/StoreTabBarInfo.dart';
import 'package:ns/pages/Store/CatelogPage.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/widgets/custom/CAppBar.dart';
import 'package:ns/widgets/custom/CSearchBtn.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final _tabs = [
    StoreTabBarInfo("男生", "male"),
    StoreTabBarInfo("女生", "female"),
    StoreTabBarInfo("出版", "press"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: CAppBar(
          context,
          tabBar(),
          false,
          actions: [CSearchBtn()],
        ),
        body: TabBarView(
          children: _tabs.map((tab) => CatelogPage(tab.type)).toList(),
        ),
      ),
    );
  }

  Widget tabBar() {
    return TabBar(
      isScrollable: false,
      indicatorColor: ColorUtils.WHITE,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(fontSize: 16.0),
      tabs: _tabs.map((tab) {
        return Tab(
          text: tab.title,
        );
      }).toList(),
    );
  }
}
