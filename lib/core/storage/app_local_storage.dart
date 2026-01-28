// In the future, want to separate secure storage and general local storage implementations
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppLocalStorage {
  final FlutterSecureStorage _secureStorage;

  const AppLocalStorage()
    : _secureStorage = const FlutterSecureStorage();

  // Write / Update
  Future<void> write({required String key, required dynamic value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  // Read
  Future<dynamic> read({required String key}) async {
   return _secureStorage.read(key: key);
  }

  // Delete
  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  // Delete all
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
