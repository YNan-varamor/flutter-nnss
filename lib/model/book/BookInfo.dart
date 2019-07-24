class BookInfo {
  String bookId;
  String unionId;
  String bookName;
  String avatar;
  String author;
  String code;
  bool follow;
  String cTitle;
  String cUrl;
  int cPage;
  String chapter;

  BookInfo(
    this.bookId,
    this.unionId,
    this.bookName,
    this.avatar,
    this.author,
    this.code,
    this.follow,
    this.cTitle,
    this.cUrl,
    this.cPage,
  );

  BookInfo.fromMap(Map<String, dynamic> map)
      : bookId = map["bookId"],
        unionId = map["unionId"],
        bookName = map["bookName"],
        avatar = map["avatar"],
        author = map["author"],
        code = map["code"],
        follow = map["follow"] > 0,
        cTitle = map["cTitle"],
        cUrl = map["cUrl"],
        cPage = map["cPage"];
}
