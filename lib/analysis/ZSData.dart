import 'package:ns/model/analysis/ZSParams.dart';
import 'package:ns/utils/common/HttpUtils.dart';
import 'package:ns/utils/const/UrlUtils.dart';

class ZSData {
  //获取分类列表
  static Future getCateList() async {
    return await HttpUtils.getAsync(UrlUtils.zs_cat);
  }

  //获取子分类
  static Future getSubCateList() async {
    return await HttpUtils.getAsync(UrlUtils.zs_subcate);
  }

  //获取书籍列表
  static Future getBookList(ZSParams params) async {
    //逻辑已删除

    return await HttpUtils.getAsync(UrlUtils.zs_category, params: parma);
  }
}
