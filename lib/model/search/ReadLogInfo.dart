class ReadLogInfo {
  final String unionId;
  final String bookName;

  ReadLogInfo(this.unionId, this.bookName);

  ReadLogInfo.fromMap(Map<String, dynamic> map)
      : unionId = map["unionId"],
        bookName = map["bookName"];

  Map<String, dynamic> toJson() => {
        'unionId': unionId,
        'bookName': bookName,
      };
}
