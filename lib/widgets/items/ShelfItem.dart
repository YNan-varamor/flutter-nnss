import 'package:flutter/material.dart';
import 'package:ns/model/book/BookInfo.dart';
import 'package:ns/pages/book/DetailPage.dart';
import 'package:ns/pages/book/ReadPage.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';

class ShelfItem extends StatelessWidget {
  final BookInfo bookInfo;
  ShelfItem(this.bookInfo);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Container(
            color: ColorUtils.WHITE,
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                FadeInImage.assetNetwork(
                  width: 55,
                  height: 75,
                  fit: BoxFit.fill,
                  placeholder: StringUtils.IMAGE_BG,
                  image: bookInfo.avatar,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            bookInfo.bookName,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Text(
                            bookInfo.author,
                            style: TextStyle(fontSize: 13.0),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "上次看到：" +
                                (bookInfo.cTitle.isNotEmpty
                                    ? bookInfo.cTitle
                                    : "暂无阅读记录"),
                            style: TextStyle(fontSize: 13.0),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Text(
                            "最新章节：" +
                                (bookInfo.chapter != null
                                    ? bookInfo.chapter
                                    : "未获取到最新章节"),
                            style: TextStyle(fontSize: 13.0),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Offstage(
            offstage: (bookInfo.cTitle.isEmpty || bookInfo.chapter == null)
                ? true
                : (bookInfo.cTitle == bookInfo.chapter),
            child: Align(
              alignment: Alignment.topRight,
              child: Image(
                width: 35.0,
                image: AssetImage("images/new.png"),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ReadPage(bookInfo.unionId)),
        );
      },
      onLongPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailPage(bookInfo.unionId)),
        );
      },
    );
  }
}
