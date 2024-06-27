import 'package:shared_preferences/shared_preferences.dart';

import 'cache_manager.dart';

class Cache<T extends CacheManager<T>> {
  final SharedPreferences prefs;
  final String keyword;

  Cache(this.prefs, this.keyword);

  /// Asynchronous constructor for [Cache], to already create the [prefs] attribute.
  static Future<Cache> initCache<T extends CacheManager<T>>(
    String keyword,
  ) async {
    return Cache<T>(await SharedPreferences.getInstance(), keyword);
  }

  T? getFromCache(T obj) {
    List<String>? args = prefs.getStringList(keyword);
    return (args != null) ? obj.createFromCache(args) : null;
  }

  void writeToCache(T obj) {
    prefs.setStringList(keyword, obj.toCache());
  }
}
