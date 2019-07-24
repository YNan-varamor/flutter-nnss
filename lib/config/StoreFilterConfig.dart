import 'package:ns/model/store/StoreFilterInfo.dart';

//书库筛选配置
class StoreFilterConfig {
  static List<StoreFilterInfo> config = [
    StoreFilterInfo("热门", "hot"),
    StoreFilterInfo("新书", "new"),
    StoreFilterInfo("好评", "reputation"),
    StoreFilterInfo("完结", "over"),
    StoreFilterInfo("VIP", "monthly"),
  ];
}
