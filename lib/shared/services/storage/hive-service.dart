import 'package:hive/hive.dart';
import 'package:night_kanban/shared/services/storage/interfaces/storage-adapter.dart';

class HiveService implements StorageAdapter {
  Box box;

  HiveService() {
    box = Hive.box('myBox');
  }

  @override
  Future<void> clean(String key) async {
    await box.clear();
  }

  @override
  Future<void> delete(String key) async {
    await box.delete(key);
  }

  @override
  read(String key) async {
    final result = await box.get(key);
    return result;
  }

  @override
  Future<void> store(String key, data) async {
    await box.put(key, data);
  }

  @override
  Future<void> update(String key, data) async {
    await box.put(key, data);
  }
}
