abstract class StorageAdapter {
  Future<void> store(String key, dynamic data);
  Future<void> update(String key, dynamic data);
  Future<dynamic> read(String key);
  Future<void> delete(String key);
  Future<void> clean(String key);
}
