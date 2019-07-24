import 'package:flutter/material.dart';
import 'package:ns/notifier/rank/RankParamsNotifier.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:provide/provide.dart';
import 'dart:convert';

class ComMenu extends StatefulWidget {
  @override
  _ComMenuState createState() => _ComMenuState();
}

class _ComMenuState extends State<ComMenu> {
  var _menuJson = "json/RankMenu.json";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      color: ColorUtils.BG_MAIN,
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(_menuJson),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          List menus = jsonDecode(snapshot.data);
          return Provide<RankParamsNotifier>(
            builder: (context, child, nParams) {
              var menuid = nParams.params.menuId;
              return ListView.builder(
                itemCount: menus.length,
                itemBuilder: (context, i) {
                  var menu = menus[i];
                  return GestureDetector(
                    child: Container(
                      height: 50.0,
                      color: menu["code"] == menuid
                          ? ColorUtils.WHITE
                          : ColorUtils.BG_MAIN,
                      child: Center(
                        child: Text(
                          menu["name"],
                          style: TextStyle(
                            color: menu["code"] == menuid
                                ? ColorUtils.MAIN
                                : ColorUtils.FONT_LABEL,
                          ),
                        ),
                      ),
                    ),
                    onTap: () => nParams.setMenuid(menu["code"], menu["name"]),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
