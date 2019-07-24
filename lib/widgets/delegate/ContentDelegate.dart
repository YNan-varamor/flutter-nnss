import 'package:flutter/material.dart';

class ContentDelegate extends SliverChildBuilderDelegate {
  Function callback;

  ContentDelegate(
    builder, {
    int childCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    this.callback,
  }) : super(
          builder,
          childCount: childCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        );

  @override
  void didFinishLayout(int firstIndex, int lastIndex) {
    super.didFinishLayout(firstIndex, lastIndex);
    callback(firstIndex, lastIndex);
  }
}
