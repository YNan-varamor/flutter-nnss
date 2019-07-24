import 'package:flutter/material.dart';
import 'package:ns/pages/shelf/ExplainPage.dart';
import 'package:ns/utils/common/ToastUtils.dart';
import 'package:ns/utils/const/ColorUtils.dart';

class ComShelfDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(237, 237, 237, 1),
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(18, 143, 214, 1),
              ),
              child: Center(
                child: Text(
                  "",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: ColorUtils.WHITE,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: ImageIcon(
                      AssetImage("images/update.png"),
                      size: 25,
                      color: ColorUtils.FONT_NORMAL,
                    ),
                    title: Text(
                      "检查更新",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: ColorUtils.FONT_NORMAL,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      ToastUtils.showToast("已经是最新版本了！");
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: ImageIcon(
                      AssetImage("images/explain.png"),
                      size: 25,
                      color: ColorUtils.FONT_NORMAL,
                    ),
                    title: Text(
                      "免责声明",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: ColorUtils.FONT_NORMAL,
                      ),
                    ),
                    onTap: () {
                      _navigateToExplain(
                        context,
                        "免责声明",
                        "explain",
                      );
                    },
                  ),
                  Divider(
                    color: ColorUtils.DIVIDER,
                    height: 1,
                  ),
                  ListTile(
                    leading: ImageIcon(
                      AssetImage("images/agreement.png"),
                      size: 25,
                      color: ColorUtils.FONT_NORMAL,
                    ),
                    title: Text(
                      "权利人保护协议",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: ColorUtils.FONT_NORMAL,
                      ),
                    ),
                    onTap: () {
                      _navigateToExplain(
                        context,
                        "权利人保护协议",
                        "agreement",
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: ImageIcon(
                      AssetImage("images/about.png"),
                      size: 25,
                      color: ColorUtils.FONT_NORMAL,
                    ),
                    title: Text(
                      "关于软件",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: ColorUtils.FONT_NORMAL,
                      ),
                    ),
                    onTap: () {
                      _navigateToExplain(
                        context,
                        "关于软件",
                        "about",
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToExplain(BuildContext context, String title, String url) {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ExplainPage(title, url)),
    );
  }
}
