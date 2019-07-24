import 'package:flutter/material.dart';
import 'package:ns/utils/const/ColorUtils.dart';

class End extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Text(
          "已经到最底下了哟~",
          style: TextStyle(
            fontSize: 13.0,
            color: ColorUtils.FONT_TIP,
          ),
        ),
      ),
    );
  }
}
