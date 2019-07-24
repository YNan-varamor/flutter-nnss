import 'package:flutter/material.dart';
import 'package:ns/model/analysis/ZSBookInfo.dart';
import 'package:ns/pages/search/SearchBookPage.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';

class StoreItem extends StatelessWidget {
  final ZSBookInfo _book;
  StoreItem(this._book);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: ColorUtils.WHITE,
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FadeInImage.assetNetwork(
              width: 60.0,
              height: 85.0,
              fit: BoxFit.fill,
              placeholder: StringUtils.IMAGE_BG,
              image: _book.avatar,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        _book.bookName,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.0),
                      child: Row(
                        children: [
                          Text(
                            _book.author,
                            style: TextStyle(fontSize: 13.0),
                            maxLines: 1,
                          ),
                          Text(" | "),
                          Text(
                            _book.catelog,
                            style: TextStyle(fontSize: 13.0),
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: Text(
                        _book.bookDesc,
                        style: TextStyle(fontSize: 13.0),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.0),
                      child: Row(
                        children: [
                          Text(
                            "${_book.follow}",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: ColorUtils.RED,
                            ),
                          ),
                          Text(
                            "人气",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          VerticalDivider(),
                          Text(
                            "${_book.ratio}",
                            style: TextStyle(
                              color: ColorUtils.RED,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            "读者留存",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SearchBookPage(_book.bookName),
          ),
        );
      },
    );
  }
}
