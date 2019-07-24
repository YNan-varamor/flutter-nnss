import 'package:flutter/widgets.dart';
import 'package:ns/utils/data/BookUtils.dart';

//判断书籍是否已收藏
class BookFollowNotifier with ChangeNotifier {
  bool _isFollow = false;
  bool get isFollow => _isFollow;

  void checkIsFollow(unionId) {
    BookUtils.checkIsFollow(unionId, (bool follow) {
      _isFollow = follow;
      notifyListeners();
    });
  }

  void changeFollow(unionId) {
    _isFollow = !_isFollow;
    BookUtils.updateFollow(unionId, _isFollow);
    notifyListeners();
  }
}
