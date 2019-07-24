import 'package:flutter/material.dart';
import 'package:ns/config/HomePageBottomBarConfig.dart';
import 'package:ns/utils/common/SpfUtils.dart';
import 'package:ns/utils/const/ColorUtils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _tabIndex = 0;

  @override
  void initState() {
    super.initState();

    loadAsync();
  }

  void loadAsync() async {
    await SpfUtils.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: ColorUtils.MAIN),
      home: Scaffold(
        body: IndexedStack(
          index: _tabIndex,
          children: HomePageBottomBarConfig.config.map((item) {
            return item.page;
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabIndex,
          items: HomePageBottomBarConfig.config.map((item) {
            return BottomNavigationBarItem(
              title: Text(item.title),
              icon: ImageIcon(AssetImage(item.icon)),
            );
          }).toList(),
          onTap: (i) => setState(() => _tabIndex = i),
        ),
      ),
    );
  }
}
