import 'package:flutter/material.dart';
import 'package:ns/model/analysis/ZSBookInfo.dart';
import 'package:ns/notifier/store/StoreParamsNotifier.dart';
import 'package:ns/notifier/store/StoreBookNotifier.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/utils/const/StringUtils.dart';
import 'package:ns/widgets/items/End.dart';
import 'package:ns/widgets/items/None.dart';
import 'package:ns/widgets/items/StoreItem.dart';
import 'package:provide/provide.dart';

class ComStoreBookList extends StatefulWidget {
  @override
  _ComStoreBookListState createState() => _ComStoreBookListState();
}

class _ComStoreBookListState extends State<ComStoreBookList> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var bookList = Provide.value<StoreBookNotifier>(context).bookList;
        var item = bookList.last.toString();
        if (item != StringUtils.ITEM_END && item != StringUtils.ITEM_NONE) {
          Provide.value<StoreParamsNotifier>(context).getMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provide<StoreParamsNotifier>(
      builder: (context, child, nParams) {
        var nBookList = Provide.value<StoreBookNotifier>(context);
        if (nParams.params.start == 0) nBookList.clear();
        nBookList.getBookList(nParams.params);
        return Provide<StoreBookNotifier>(
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
        return StoreItem(ZSBookInfo.fromMap(book));
    }
  }
}
