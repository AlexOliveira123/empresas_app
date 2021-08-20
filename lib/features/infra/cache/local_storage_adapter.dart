import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'protocols/fetch_secure_cache_storage.dart';
import 'protocols/save_secure_cache_storage.dart';

@singleton
class LocalStorageAdapter
    implements FetchSecureCacheStorage, SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({required this.secureStorage});

  Future<void> saveSecure({
    required String key,
    required String value,
  }) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> fetchSecure(String key) async {
    return await secureStorage.read(key: key);
  }
}
