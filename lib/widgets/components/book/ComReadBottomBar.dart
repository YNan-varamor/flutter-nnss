import 'package:flutter/material.dart';
import 'package:ns/config/ReadPageBottomBarConfig.dart';
import 'package:ns/config/SetConf.dart';
import 'package:ns/model/book/BottomBtnInfo.dart';
import 'package:ns/notifier/book/BookChapterNotifier.dart';
import 'package:ns/notifier/book/BookSetNotifier.dart';
import 'package:ns/notifier/book/BookShowNotifier.dart';
import 'package:ns/notifier/shelf/ShlefNotifier.dart';
import 'package:ns/pages/book/ChapterPage.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/widgets/custom/CDivider.dart';
import 'package:provide/provide.dart';

class ComReadBottomBar extends StatefulWidget {
  final String unionId;
  ComReadBottomBar(this.unionId);

  @override
  _ComReadBottomBarState createState() => _ComReadBottomBarState();
}

class _ComReadBottomBarState extends State<ComReadBottomBar> {
  @override
  Widget build(BuildContext context) {
    Provide.value<BookShowNotifier>(context).hide();
    return Provide<BookShowNotifier>(
      builder: (context, child, nShow) {
        return Offstage(
          offstage: !nShow.showAll,
          child: Container(
            decoration: BoxDecoration(color: ColorUtils.BG_MENU, boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
              )
            ]),
            height: nShow.showBgColor || nShow.showOther ? 151.0 : 100.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _buildBgColorSet(nShow),
                _buildOtherSet(nShow),
                _buildChapterNav(),
                CDivider(),
                _buildBottomButtonBar(nShow),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBgColorSet(BookShowNotifier nShow) {
    return Offstage(
      offstage: !nShow.showBgColor,
      child: Column(
        children: [
          Container(
            height: 50.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildBgColorItem(),
              ),
            ),
          ),
          CDivider()
        ],
      ),
    );
  }

  List<Widget> _buildBgColorItem() {
    return SetConf.bgColor.map((color) {
      return GestureDetector(
        child: Container(
          width: 40.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        onTap: () {
          Provide.value<BookSetNotifier>(context).setBgColor(
            SetConf.bgColor.indexOf(color),
          );
        },
      );
    }).toList();
  }

  Widget _buildOtherSet(BookShowNotifier nShow) {
    return Offstage(
      offstage: !nShow.showOther,
      child: Column(
        children: [
          Container(
            height: 50.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Provide<BookSetNotifier>(
              builder: (context, child, nSet) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 10.0),
                        child: OutlineButton.icon(
                          borderSide: BorderSide(
                            color: ColorUtils.FONT_NORMAL,
                          ),
                          icon: ImageIcon(
                            AssetImage(
                              nSet.setInfo.nightMod
                                  ? "images/sun.png"
                                  : "images/moon.png",
                            ),
                            color: ColorUtils.FONT_NORMAL,
                            size: 15.0,
                          ),
                          label: Text(
                            nSet.setInfo.nightMod ? "日间模式" : "夜间模式",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: ColorUtils.FONT_NORMAL,
                            ),
                          ),
                          onPressed: () => nSet.toggleNightMod(),
                        ),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          OutlineButton(
                            borderSide: BorderSide(
                              color: ColorUtils.FONT_NORMAL,
                            ),
                            child: Text(
                              "Aa-",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: ColorUtils.FONT_NORMAL,
                              ),
                            ),
                            onPressed: () {
                              if (nSet.setInfo.fontSize > 14) {
                                nSet.reduceFontSize();
                              }
                            },
                          ),
                          OutlineButton(
                            borderSide: BorderSide(
                              color: ColorUtils.FONT_NORMAL,
                            ),
                            child: Text(
                              "Aa+",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: ColorUtils.FONT_NORMAL,
                              ),
                            ),
                            onPressed: () {
                              if (nSet.setInfo.fontSize < 35) {
                                nSet.addFontSize();
                              }
                            },
                          )
                        ],
                      ),
                      flex: 3,
                    ),
                  ],
                );
              },
            ),
          ),
          CDivider()
        ],
      ),
    );
  }

  Widget _buildChapterNav() {
    return Provide<BookChapterNotifier>(
      builder: (context, child, nChapter) {
        return Container(
          height: 40.0,
          child: Center(
            child: Text(
              nChapter.chapter.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.0,
                color: ColorUtils.FONT_NORMAL,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomButtonBar(BookShowNotifier nShow) {
    return Container(
      height: 40.0,
      child: Row(
        children: RBBottomBarConfig.bottomButton.map((btn) {
          return _buildBottomButton(btn, callback: () {
            switch (btn.id) {
              case 0:
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ChapterPage(widget.unionId),
                  ),
                );
                break;
              case 1:
                nShow.toggleBgColor();
                break;
              case 2:
                nShow.toggleOther();
                break;
              case 3:
                Provide.value<ShelfNotifier>(context).getBooks();
                Navigator.of(context).pop();
                break;
            }
          });
        }).toList(),
      ),
    );
  }

  Widget _buildBottomButton(BottomBtnInfo btn, {Function callback}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 3.0),
        child: IconButton(
          icon: Icon(btn.icon, color: ColorUtils.FONT_NORMAL),
          onPressed: () => callback(),
        ),
      ),
      flex: 1,
    );
  }
}
