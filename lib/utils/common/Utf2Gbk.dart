import 'package:ns/utils/common/HttpUtils.dart';

class Utf2Gbk {
  static Future<String> encode(String src) async {
    var trans = await HttpUtils.getAsync(
        "http://api.book.lynunion.com/api/Utf8ToGb2312/$src");
    return trans;
  }
}
