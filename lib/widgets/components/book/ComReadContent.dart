import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ns/config/SetConf.dart';
import 'package:ns/model/book/ContentInfo.dart';
import 'package:ns/notifier/book/BookSetNotifier.dart';
import 'package:provide/provide.dart';

class ComReadContent extends StatelessWidget {
  final ContentInfo content;
  ComReadContent(this.content);

  @override
  Widget build(BuildContext context) {
    return Provide<BookSetNotifier>(
      builder: (context, child, nSet) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: Text(
                  content.title,
                  style: TextStyle(
                    fontSize: nSet.setInfo.fontSize + 4,
                    fontWeight: FontWeight.w500,
                    color: SetConf.fontColor[nSet.setInfo.bgColorIdx],
                  ),
                ),
              ),
            ),
            Container(
              child: Html(
                data: content.content,
                padding: const EdgeInsets.all(10.0),
                defaultTextStyle: TextStyle(
                  fontSize: nSet.setInfo.fontSize,
                  color: SetConf.fontColor[nSet.setInfo.bgColorIdx],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
