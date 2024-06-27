/// All class being cache-able **have** to implements this interface.
abstract class CacheManager<T extends CacheManager<T>> {
  /// How the object should be putted in the cache.
  List<String> toCache();

  /// How, given a [List<String>] object coming from the cache, should the [T] object be re-created.
  T createFromCache(List<String> args);
}
