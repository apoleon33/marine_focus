abstract class CacheManager<T extends CacheManager<T>> {
  List<String> toCache();

  T createFromCache(List<String> args);
}
