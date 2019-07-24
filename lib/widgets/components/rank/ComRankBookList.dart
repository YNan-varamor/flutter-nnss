import 'package:flutter/material.dart';
import 'package:ns/model/cg/CGbookInfo.dart';
import 'package:ns/notifier/rank/RankBookNotifier.dart';
import 'package:ns/notifier/rank/RankParamsNotifier.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';
import 'package:ns/widgets/items/End.dart';
import 'package:ns/widgets/items/None.dart';
import 'package:ns/widgets/items/RankItem.dart';
import 'package:provide/provide.dart';

class ComRankBookList extends StatefulWidget {
  @override
  _ComRankBookListState createState() => _ComRankBookListState();
}

class _ComRankBookListState extends State<ComRankBookList> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var bookList = Provide.value<RankBookNotifier>(context).bookList;
        var item = bookList.last.toString();
        // print(item);
        if (item != StringUtils.ITEM_END && item != StringUtils.ITEM_NONE) {
          Provide.value<RankParamsNotifier>(context).getMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provide<RankParamsNotifier>(
      builder: (context, child, nParams) {
        var nBookList = Provide.value<RankBookNotifier>(context);
        if (nParams.params.page == 1) nBookList.clear();
        nBookList.getBookList(nParams.params);
        return Provide<RankBookNotifier>(
          builder: (context, child, nBooks) {
            List books = nBooks.bookList;
            return ListView.separated(
              itemCount: books.length,
              itemBuilder: (context, i) => _buildBook(books[i]),
              separatorBuilder: (context, i) {
                return Divider(height: 1.0, color: ColorUtils.DIVIDER);
              },
              controller: _scrollController,
            );
          },
        );
      },
    );
  }

  Widget _buildBook(book) {
    switch (book.toString()) {
      case StringUtils.ITEM_NONE:
        return None();
      case StringUtils.ITEM_END:
        return End();
      default:
        return RankItem(CGBookInfo.fromMap(book));
    }
  }
}
