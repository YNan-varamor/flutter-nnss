import 'package:flutter/material.dart';
import 'package:ns/model/cg/CGbookInfo.dart';
import 'package:ns/pages/book/DetailPage.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';

class RankItem extends StatelessWidget {
  final CGBookInfo _book;
  RankItem(this._book);

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
              width: 45.0,
              height: 70.0,
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
                      child: Text(
                        _book.author,
                        style: TextStyle(fontSize: 13.0),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Text(
                            _book.category,
                            style: TextStyle(fontSize: 14.0),
                          ),
                          VerticalDivider(),
                          Offstage(
                            offstage: _book.cgscore == 0,
                            child: Text(
                              (_book.cgscore / 10).toString(),
                              style: TextStyle(
                                color: ColorUtils.RED,
                                fontSize: 15.0,
                              ),
                            ),
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
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailPage(_book.unionId),
        ),
      ),
    );
  }
}
