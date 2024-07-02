import 'package:shared_preferences/shared_preferences.dart';

import 'cache_manager.dart';

class Cache {
  final SharedPreferences prefs;
  final String keyword;
  final CacheManager cacheManager;

  Cache(this.prefs, this.keyword, this.cacheManager);

  /// Asynchronous constructor for [Cache], to already create the [prefs] attribute.
  static Future<Cache> initCache(
    String keyword,
    CacheManager cacheManager,
  ) async {
    return Cache(await SharedPreferences.getInstance(), keyword, cacheManager);
  }

  CacheManager? getFromCache() {
    List<String>? args = prefs.getStringList(keyword);
    return (args != null) ? cacheManager.createFromCache(args) : null;
  }

  void writeToCache() {
    prefs.setStringList(keyword, cacheManager.toCache());
  }

  void clearCache() {
    int? monInt = 3;
    monInt.toInt();
    prefs.remove(keyword);
  }

  bool get isCacheWritten => prefs.getStringList(keyword) != null;
}
