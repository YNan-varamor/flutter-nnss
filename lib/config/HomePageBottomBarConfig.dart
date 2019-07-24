import 'package:ns/model/home/HomePageBottomBarItem.dart';
import 'package:ns/pages/store/StorePage.dart';
import 'package:ns/pages/rank/RankPage.dart';
import 'package:ns/pages/shelf/ShelfPage.dart';
//首页底部栏
class HomePageBottomBarConfig{
  static List<HomePageBottomBarItem> config = [
    HomePageBottomBarItem("书架", "images/shelf.png", ShelfPage()),
    HomePageBottomBarItem("书库", "images/store.png", StorePage()),
    HomePageBottomBarItem("榜单", "images/rank.png", RankPage()),
  ];
}
