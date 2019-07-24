import 'package:ns/model/book/BookInfo.dart';
import 'package:ns/utils/common/DbUtils.dart';

class BookUtils {
  static void saveToDb(Map<String, dynamic> book) {
    new DbUtils().insert("tShelf", book);
  }

  static void checkIsAddShelf(String unionId, Function callback) {
    new DbUtils()
        .rawQuery("select count(1) cnt from tShelf where unionId = '$unionId'")
        .then((retData) {
      callback(retData[0]["cnt"] == 1);
    });
  }

  static void checkIsFollow(String unionId, Function callback) {
    new DbUtils()
        .rawQuery("select follow from tShelf where unionId = '$unionId'")
        .then((retData) {
      callback(retData[0]["follow"] > 0);
    });
  }

  static void updateFollow(String unionId, bool isfollow) {
    int follow = isfollow ? 1 : 0;
    var sql = "update tShelf set follow = $follow where unionId = '$unionId'";
    new DbUtils().update(sql);
  }

  static Future<BookInfo> getBookByUnionId(String unionId) async {
    var sql = "select * from tShelf where unionId = '$unionId'";
    var retData = await new DbUtils().rawQuery(sql);
    return BookInfo.fromMap(retData[0]);
  }

  static void getFollowBook(Function callback) {
    var sql = "select * from tShelf where follow = 1";
    new DbUtils().rawQuery(sql).then((retData) {
      callback(retData);
    });
  }

  static void updateCode(String unionId, String code) {
    var sql = "update tShelf set code = '$code' where unionId = '$unionId'";
    new DbUtils().update(sql);
  }

  static void updateSource(String unionId, int sourceId) {
    var sql =
        "update tShelf set sourceId = $sourceId,code = '' where unionId = '$unionId'";
    new DbUtils().update(sql);
  }

  static Future<bool> updateChapter(
    String unionId,
    String url,
    String title,
    int page,
  ) async {
    var sql =
        "update tShelf set cUrl = '$url',cTitle = '$title',cPage = '$page' where unionId = '$unionId'";
    return await DbUtils().update(sql) > 0;
  }

  static void deleteBook(String unionId, Function callback) {
    var sql = "delete from tShelf where unionId = '$unionId'";
    new DbUtils().update(sql).then((retData) {
      callback(retData > 0);
    });
  }
}
