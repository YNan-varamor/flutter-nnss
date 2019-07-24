import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ns/notifier/shelf/ShlefNotifier.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/widgets/components/shelf/ComShelfDrawer.dart';
import 'package:ns/widgets/custom/CDivider.dart';
import 'package:ns/widgets/custom/CSearchBtn.dart';
import 'package:ns/widgets/items/ShelfItem.dart';
import 'package:provide/provide.dart';

class ShelfPage extends StatefulWidget {
  @override
  _ShelfPageState createState() => _ShelfPageState();
}

class _ShelfPageState extends State<ShelfPage> {
  final _headerKey = GlobalKey<RefreshHeaderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("我的书架"),
        centerTitle: true,
        actions: [CSearchBtn()],
      ),
      drawer: ComShelfDrawer(),
      body: Provide<ShelfNotifier>(
        builder: (context, child, nShelf) {
          return EasyRefresh(
            refreshHeader: ClassicsHeader(
              key: _headerKey,
              refreshHeight: 40.0,
              bgColor: ColorUtils.WHITE,
              textColor: ColorUtils.MAIN,
            ),
            firstRefresh: true,
            onRefresh: () async {
              nShelf.getBooks();
            },
            behavior: ScrollOverBehavior(),
            child: nShelf.bookList.isEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height - 50.0 - 80.0,
                    child: Center(
                      child: Text(
                        "书架上什么都没有喔！",
                        style: TextStyle(
                          color: ColorUtils.FONT_TIP,
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: nShelf.bookList.length,
                    itemBuilder: (context, i) {
                      var book = nShelf.bookList[i];
                      return Slidable(
                        key: Key(book.unionId),
                        delegate: SlidableDrawerDelegate(),
                        actionExtentRatio: 0.25,
                        child: ShelfItem(book),
                        secondaryActions: [
                          IconSlideAction(
                            caption: "删除",
                            color: ColorUtils.RED,
                            icon: Icons.delete_forever,
                            onTap: () => nShelf.deleteBook(book),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, i) => CDivider(),
                  ),
          );
        },
      ),
    );
  }
}
