// 将来的にはセキュアなストレージと一般的なローカルストレージを分ける実装にしたい
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppLocalStorage {
  final FlutterSecureStorage _secureStorage;

  const AppLocalStorage()
    : _secureStorage = const FlutterSecureStorage();

  // 書き出し / 更新
  Future<void> write({required String key, required dynamic value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  // 読み出し
  Future<dynamic> read({required String key}) async {
   return _secureStorage.read(key: key);
  }

  // 削除
  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  // 全削除
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
