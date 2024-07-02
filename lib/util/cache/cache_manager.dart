/// All class being cache-able **have** to implements this interface.
abstract class CacheManager {
  /// How the object should be putted in the cache.
  List<String> toCache();

  /// How, given a [List<String>] object coming from the cache, should the [T] object be re-created.
  CacheManager createFromCache(List<String> args);
}
