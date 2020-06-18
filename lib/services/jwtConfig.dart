import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JWTConfig {
  void storeJWTToken(String key, String value) async {
    var storage = FlutterSecureStorage();
    storage.write(key: key, value: value);
  }

  void deleteJWTToken() {
    var storage = FlutterSecureStorage();
    storage.delete(key: "jwt");
  }

  Future<String> readJWTToken({String key}) async {
//    debugPrint("Key: "+key);
    var storage = FlutterSecureStorage();
    var value = await storage.read(key: key);
    return value;
  }
}
