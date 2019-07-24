import 'package:flutter/material.dart';
import 'package:ns/analysis/BookAnalysis.dart';
import 'package:ns/model/cg/CGbookInfo.dart';
import 'package:ns/notifier/book/BookFollowNotifier.dart';
import 'package:ns/pages/search/SearchBookPage.dart';
import 'package:ns/utils/common/HttpUtils.dart';
import 'package:ns/utils/common/ToastUtils.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';
import 'package:ns/utils/const/UrlUtils.dart';
import 'package:ns/utils/data/BookUtils.dart';
import 'package:ns/widgets/components/book/ComDetailBottomBar.dart';
import 'package:ns/widgets/custom/CAppBar.dart';
import 'package:provide/provide.dart';

import 'ReadPage.dart';

class DetailPage extends StatefulWidget {
  final String unionId;
  DetailPage(this.unionId);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(context, Text("书籍详情"), true),
      body: FutureBuilder(
        future: _getBookDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            if (snapshot.hasData) {
              var book = snapshot.data as CGBookInfo;
              return Column(
                children: [
                  _buildBookInfo(book),
                  _divider(),
                  _buildBookDesc(book),
                ],
              );
            } else {
              ToastUtils.showToast("书籍详情获取失败,请检查网络后重试...");
              return Container();
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: ImageIcon(AssetImage("images/read.png")),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ReadPage(widget.unionId),
          ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ComDetailBottomBar(widget.unionId),
    );
  }

  //生成书籍信息
  Widget _buildBookInfo(CGBookInfo book) {
    var row = Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: FadeInImage.assetNetwork(
            width: 80.0,
            height: 120.0,
            fit: BoxFit.fill,
            image: book.avatar,
            placeholder: StringUtils.IMAGE_BG,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.bookName,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: _calcStars(book.score),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        (book.score / 10).toString() + " 分",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Offstage(
                      offstage: book.category.isEmpty,
                      child: Text(book.category),
                    ),
                    Offstage(
                      offstage: book.category.isEmpty,
                      child: Text(" | "),
                    ),
                    _buildAuchor(book.author)
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${book.words}万字"),
                    VerticalDivider(),
                    Text(
                      book.status,
                      style: TextStyle(
                        color: ColorUtils.RED,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 3),
                child: Text("人气：${book.visits}"),
              )
            ],
          ),
        ),
      ],
    );
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: ColorUtils.WHITE,
      child: row,
    );
  }

//计算星星
  List<Widget> _calcStars(scores) {
    List<Widget> stars = List();

    var score = (scores / 100 * 5).round();
    for (var i = 0; i < 5; i++) {
      var star = Icon(
        Icons.star,
        color: i <= score ? Colors.orangeAccent : Colors.grey,
        size: 18.0,
      );
      stars.add(star);
    }
    return stars;
  }

  //生成可点击作者
  Widget _buildAuchor(author) {
    return GestureDetector(
      child: Text(
        author,
        style: TextStyle(
          color: ColorUtils.MAIN,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SearchBookPage(author)),
        );
      },
    );
  }

//生成书籍详情区
  Widget _buildBookDesc(CGBookInfo book) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Offstage(
              offstage: book.label.length == 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: ColorUtils.WHITE,
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                  spacing: 7.0,
                  runSpacing: 7.0,
                  children: _calcLabel(book.label),
                ),
              ),
            ),
            _divider(),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              color: ColorUtils.WHITE,
              child: Text(book.bookDesc),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _calcLabel(List<dynamic> labels) {
    return labels
        .map((label) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
                color: labels.indexOf(label) < 5
                    ? ColorUtils.WRAP_LIST[labels.indexOf(label)]
                    : ColorUtils.WRAP_LIST[labels.indexOf(label) % 5],
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 15.0,
              ),
              child: Text(
                labels[labels.indexOf(label)],
                style: TextStyle(
                  color: ColorUtils.WHITE,
                ),
              ),
            ))
        .toList();
  }

  //分割符
  Widget _divider() {
    return Container(
      height: 10.0,
    );
  }

  Future<CGBookInfo> _getBookDetail() async {
    var url = UrlUtils.cg_detail + widget.unionId;
    var retData = await HttpUtils.getAsync(url);
    var result = retData["result"];
    var book = CGBookInfo.fromMap(result["book_detail"]);
    _checkIsAddShelf(book);
    var code = await BookAnalysis.getCode(book.bookName, book.author);
    if (code.isEmpty)
      ToastUtils.showToast("书源中无该书籍");
    else
      BookUtils.updateCode(book.unionId, code);
    return book;
  }

  void _checkIsAddShelf(CGBookInfo book) {
    BookUtils.checkIsAddShelf(widget.unionId, (bool isAdd) {
      if (!isAdd) {
        Map<String, dynamic> bookInfo = Map();
        bookInfo["bookId"] = book.bookId;
        bookInfo["unionId"] = book.unionId;
        bookInfo["bookName"] = book.bookName;
        bookInfo["avatar"] = book.avatar;
        bookInfo["author"] = book.author;
        bookInfo["code"] = "";
        bookInfo["cTitle"] = "";
        bookInfo["cUrl"] = "";
        bookInfo["cPage"] = 1;
        bookInfo["follow"] = 0;
        BookUtils.saveToDb(bookInfo);
      }
      Provide.value<BookFollowNotifier>(context).checkIsFollow(widget.unionId);
    });
  }
}
