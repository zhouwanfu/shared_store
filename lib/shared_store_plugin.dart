import 'package:shared_store/shared_store.dart';

class SharedStorePlugin {
  static void initMMKV() {
    SharedStore.initMMKV();
  }

  static void addMMKV(String MMKVId) {
    SharedStore.addMMKVId(MMKVId);
  }

  static Future<String?> storeInt(String key, int value, {String MMKVId = "default"}) {
    return SharedStore.storeValue(key, value.toString(), valueType.intType, MMKVId);
  }

  static Future<int?> readInt(String key, {String MMKVId = "default"}) async {
    int? intResult;
    String? intString = await SharedStore.readValue(key, valueType.intType, MMKVId);
    if (intString != null) {
      intResult = int.parse(intString);
    }
    return intResult;
  }

  static Future<String?> storeString(String key, String value, {String MMKVId = "default"}) {
    return SharedStore.storeValue(key, value, valueType.stringType, MMKVId);
  }

  static Future<String?> readString(String key, {String MMKVId = "default"}) async {
    String? stringResult = await SharedStore.readValue(key, valueType.stringType, MMKVId);
    return stringResult;
  }

  static Future<String?> storeDouble(String key, double value, {String MMKVId = "default"}) {
    return SharedStore.storeValue(key, value.toString(), valueType.doubleType, MMKVId);
  }

  static Future<double?> readDouble(String key, {String MMKVId = "default"}) async {
    double? doubleResult;
    String? doubleString = await SharedStore.readValue(key, valueType.doubleType, MMKVId);
    if (doubleString != null) {
      doubleResult = double.parse(doubleString);
    }
    return doubleResult;
  }

  static Future<String?> storeBool(String key, bool value, {String MMKVId = "default"}) {
    return SharedStore.storeValue(key, value.toString(), valueType.boolType, MMKVId);
  }

  static Future<bool?> readBool(String key, {String MMKVId = "default"}) async {
    bool? boolResult;
    String? boolString = await SharedStore.readValue(key, valueType.boolType, MMKVId);
    if (boolString != null) {
      boolResult = boolString == "true" ? true : false;
    }
    return boolResult;
  }

  static void removeValue(String key, {String MMKVId = "default"}) {
    SharedStore.removeValue(key, MMKVId);
  }
}
