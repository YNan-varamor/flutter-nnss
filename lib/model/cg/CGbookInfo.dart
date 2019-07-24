class CGBookInfo {
  String bookName;
  String author;
  String unionId;
  String bookId;
  String bookDesc;
  String avatar;
  double words;
  int visits;
  String category;
  int score;
  int cgscore;
  String status;
  List<dynamic> label;

  CGBookInfo(
    this.bookName,
    this.author,
    this.unionId,
    this.bookId,
    this.bookDesc,
    this.avatar,
    this.words,
    this.visits,
    this.category,
    this.score,
    this.cgscore,
    this.status,
    this.label,
  );

  CGBookInfo.fromMap(Map<String, dynamic> map)
      : bookName = map["book_name"],
        author = map["author_name"],
        unionId = map["book_unique"],
        bookId = map["book_id"],
        bookDesc = map["brief_intro"],
        avatar = map["book_avatar"],
        words = double.tryParse(map["words"].toString()),
        visits = map["visits"],
        category = map["category"],
        score = map["star_score"],
        cgscore = map["chenggua_score"],
        status = map["update_status"] == 0 ? "连载中" : "已完结",
        label = map["label"];
}
