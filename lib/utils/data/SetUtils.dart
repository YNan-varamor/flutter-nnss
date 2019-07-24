import 'package:ns/model/book/SetInfo.dart';
import 'package:ns/utils/common/DbUtils.dart';

class SetUtils {
  static Future<SetInfo> getSettings() async {
    var sql = "select * from tSet";
    var retData = await DbUtils().rawQuery(sql);
    var settings = retData[0];
    var info = new SetInfo(
      settings["bgColor"],
      settings["fontSize"],
      false,
    );
    return info;
  }

  static void updateFontSize(double fontSize) {
    var sql = "update tSet set fontSize = $fontSize";
    new DbUtils().update(sql);
  }

  static void updateBgColor(int bgColor) {
    var sql = "update tSet set bgColor = $bgColor";
    new DbUtils().update(sql);
  }
}
