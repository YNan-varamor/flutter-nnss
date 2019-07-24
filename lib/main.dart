import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'notifier/book/BookChapterNotifier.dart';
import 'notifier/book/BookFollowNotifier.dart';
import 'notifier/book/BookSetNotifier.dart';
import 'notifier/book/BookShowNotifier.dart';
import 'notifier/rank/RankBookNotifier.dart';
import 'notifier/rank/RankParamsNotifier.dart';
import 'notifier/shelf/ShlefNotifier.dart';
import 'notifier/store/StoreBookNotifier.dart';
import 'notifier/store/FilterNotifier.dart';
import 'notifier/store/StoreParamsNotifier.dart';
import 'pages/home/HomePage.dart';

void main() {
  var providers = Providers()
    ..provide(Provider<FilterNotifier>.value(FilterNotifier()))
    ..provide(Provider<StoreParamsNotifier>.value(StoreParamsNotifier()))
    ..provide(Provider<StoreBookNotifier>.value(StoreBookNotifier()))
    ..provide(Provider<RankBookNotifier>.value(RankBookNotifier()))
    ..provide(Provider<RankParamsNotifier>.value(RankParamsNotifier()))
    ..provide(Provider<BookFollowNotifier>.value(BookFollowNotifier()))
    ..provide(Provider<BookSetNotifier>.value(BookSetNotifier()))
    ..provide(Provider<BookShowNotifier>.value(BookShowNotifier()))
    ..provide(Provider<BookChapterNotifier>.value(BookChapterNotifier()))
    ..provide(Provider<ShelfNotifier>.value(ShelfNotifier()));

  runApp(ProviderNode(child: HomePage(), providers: providers));
}
