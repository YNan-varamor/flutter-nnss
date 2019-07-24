import 'package:dio/dio.dart';
import 'package:gbk2utf8/gbk2utf8.dart';

class HttpUtils {
  static Future getAsync(String url, {Map<String, dynamic> params}) async {
    try {
      if (params != null && params.isNotEmpty) {
        var sb = new StringBuffer();
        params.forEach((key, value) {
          sb.write("$key=$value&");
        });
        url = url + (url.contains("?") ? "&" : "?") + sb.toString();
      }
      var dio = new Dio();
      var res = await dio.get(url);
      return res.data;
    } catch (e) {
      return null;
    }
  }

  static Future getHtml(String url, {Map<String, dynamic> params}) async {
    try {
      if (params != null && params.isNotEmpty) {
        var sb = new StringBuffer();
        params.forEach((key, value) {
          sb.write("$key=$value&");
        });
        url = url + (url.contains("?") ? "&" : "?") + sb.toString();
      }
      var dio = new Dio();
      Response res;
      dio.options.responseType = ResponseType.bytes;
      res = await dio.get(url);
      var bytes = res.data;
      return decodeGbk(bytes);
    } catch (e) {
      return null;
    }
  }
}
