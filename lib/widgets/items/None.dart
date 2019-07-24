import 'package:flutter/material.dart';
import 'package:ns/utils/const/ColorUtils.dart';

class None extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Center(
        child: Text(
          "没有找到相关书籍~",
          style: TextStyle(
            fontSize: 13.0,
            color: ColorUtils.FONT_TIP,
          ),
        ),
      ),
    );
  }
}
