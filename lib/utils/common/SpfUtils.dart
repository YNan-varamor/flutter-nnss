import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpfUtils {
  static SpfUtils _spfUtils;
  static SharedPreferences _spf;
  static Lock _lock = Lock();

  static Future<SpfUtils> getInstance() async {
    if (_spfUtils == null) {
      await _lock.synchronized(() async {
        if (_spfUtils == null) {
          var spfUtils = SpfUtils._();
          await spfUtils._init();
          _spfUtils = spfUtils;
        }
      });
    }
    return _spfUtils;
  }

  SpfUtils._();
  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  /// put object.
  static Future<bool> putObject(String key, Object value) {
    if (_spf == null) return null;
    return _spf.setString(key, value == null ? "" : json.encode(value));
  }

  /// get obj.
  static T getObj<T>(String key, T f(Map v), {T defValue}) {
    Map map = getObject(key);
    return map == null ? defValue : f(map);
  }

  /// get object.
  static Map getObject(String key) {
    if (_spf == null) return null;
    String _data = _spf.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  /// put object list.
  static Future<bool> putObjectList(String key, List<Object> list) {
    if (_spf == null) return null;
    List<String> _dataList = list?.map((value) {
      return json.encode(value);
    })?.toList();
    return _spf.setStringList(key, _dataList);
  }

  /// get obj list.
  static List<T> getObjList<T>(String key, T f(Map v),
      {List<T> defValue = const []}) {
    List<Map> dataList = getObjectList(key);
    List<T> list = dataList?.map((value) {
      return f(value);
    })?.toList();
    return list ?? defValue;
  }

  /// get object list.
  static List<Map> getObjectList(String key) {
    if (_spf == null) return null;
    List<String> dataLis = _spf.getStringList(key);
    return dataLis?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
  }

  /// get string.
  static String getString(String key, {String defValue = ''}) {
    if (_spf == null) return defValue;
    return _spf.getString(key) ?? defValue;
  }

  /// put string.
  static Future<bool> putString(String key, String value) {
    if (_spf == null) return null;
    return _spf.setString(key, value);
  }

  /// get bool.
  static bool getBool(String key, {bool defValue = false}) {
    if (_spf == null) return defValue;
    return _spf.getBool(key) ?? defValue;
  }

  /// put bool.
  static Future<bool> putBool(String key, bool value) {
    if (_spf == null) return null;
    return _spf.setBool(key, value);
  }

  /// get int.
  static int getInt(String key, {int defValue = 0}) {
    if (_spf == null) return defValue;
    return _spf.getInt(key) ?? defValue;
  }

  /// put int.
  static Future<bool> putInt(String key, int value) {
    if (_spf == null) return null;
    return _spf.setInt(key, value);
  }

  /// get double.
  static double getDouble(String key, {double defValue = 0.0}) {
    if (_spf == null) return defValue;
    return _spf.getDouble(key) ?? defValue;
  }

  /// put double.
  static Future<bool> putDouble(String key, double value) {
    if (_spf == null) return null;
    return _spf.setDouble(key, value);
  }

  /// get string list.
  static List<String> getStringList(String key) {
    if (_spf == null) return [];
    return _spf.getStringList(key) ?? [];
  }

  /// put string list.
  static Future<bool> putStringList(String key, List<String> value) {
    if (_spf == null) return null;
    return _spf.setStringList(key, value);
  }

  /// get dynamic.
  static dynamic getDynamic(String key, {Object defValue}) {
    if (_spf == null) return defValue;
    return _spf.get(key) ?? defValue;
  }

  /// have key.
  static bool haveKey(String key) {
    if (_spf == null) return null;
    return _spf.getKeys().contains(key);
  }

  /// get keys.
  static Set<String> getKeys() {
    if (_spf == null) return null;
    return _spf.getKeys();
  }

  /// remove.
  static Future<bool> remove(String key) {
    if (_spf == null) return null;
    return _spf.remove(key);
  }

  /// clear.
  static Future<bool> clear() {
    if (_spf == null) return null;
    return _spf.clear();
  }

  ///Sp is initialized.
  static bool isInitialized() {
    return _spf != null;
  }
}
