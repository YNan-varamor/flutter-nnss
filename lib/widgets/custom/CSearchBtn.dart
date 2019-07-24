import 'package:flutter/material.dart';
import 'package:ns/pages/search/SearchPage.dart';

class CSearchBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ImageIcon(AssetImage("images/search.png")),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      },
    );
  }
}
