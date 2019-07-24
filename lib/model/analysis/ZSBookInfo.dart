import 'package:ns/utils/const/UrlUtils.dart';

class ZSBookInfo {
  String bookName;
  String avatar;
  String author;
  String bookDesc;
  String catelog;
  String follow;
  String ratio;

  ZSBookInfo(
    this.bookName,
    this.avatar,
    this.author,
    this.bookDesc,
    this.catelog,
    this.follow,
    this.ratio,
  );
  ZSBookInfo.fromMap(Map<String, dynamic> map)
      : bookName = map["title"],
        avatar = UrlUtils.zs_avatar + map["cover"],
        author = map["author"],
        bookDesc = map["shortIntro"],
        catelog = map["minorCate"],
        follow = map["latelyFollower"] > 10000
            ? (map["latelyFollower"] / 10000).toStringAsFixed(1) + "万"
            : map["latelyFollower"].toString(),
        ratio = "${map["retentionRatio"].toString()}%";
}
