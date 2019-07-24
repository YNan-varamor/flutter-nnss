import 'package:flutter/material.dart';
import 'package:ns/model/book/BottomBtnInfo.dart';
//阅读页底部菜单
class RBBottomBarConfig {
  static List<BottomBtnInfo> bottomButton = [
    BottomBtnInfo(0, "章节", Icons.library_books),
    BottomBtnInfo(1, "背景", Icons.color_lens),
    BottomBtnInfo(2, "更多", Icons.settings),
    BottomBtnInfo(3, "返回", Icons.exit_to_app),
  ];
}
