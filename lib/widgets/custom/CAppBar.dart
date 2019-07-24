import 'package:flutter/material.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext scontext;
  final Widget title;
  final bool isBack;
  final Widget leading;
  final List<Widget> actions;
  CAppBar(this.scontext, this.title, this.isBack, {this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: title,
      centerTitle: true,
      actions: actions == null ? [] : actions,
      leading: !isBack
          ? Offstage(
              offstage: leading == null,
              child: leading == null ? Container() : leading,
            )
          : IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(scontext),
            ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
