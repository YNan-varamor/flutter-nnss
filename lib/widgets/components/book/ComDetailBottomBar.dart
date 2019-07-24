import 'package:flutter/material.dart';
import 'package:ns/notifier/book/BookFollowNotifier.dart';
import 'package:ns/notifier/shelf/ShlefNotifier.dart';
import 'package:ns/pages/book/ChapterPage.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:provide/provide.dart';

class ComDetailBottomBar extends StatelessWidget {
  final String unionId;
  ComDetailBottomBar(this.unionId);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      shape: CircularNotchedRectangle(),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: ImageIcon(
                AssetImage("images/chapters.png"),
                color: ColorUtils.MAIN,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChapterPage(unionId)),
                );
              },
            ),
            Provide<BookFollowNotifier>(
              builder: (context, child, notifier) {
                return IconButton(
                  icon: ImageIcon(
                    AssetImage(notifier.isFollow
                        ? "images/followed.png"
                        : "images/follow.png"),
                    color: notifier.isFollow ? ColorUtils.RED : ColorUtils.MAIN,
                  ),
                  onPressed: () {
                    if (!notifier.isFollow) {
                      notifier.changeFollow(unionId);
                      Provide.value<ShelfNotifier>(context).getBooks();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
