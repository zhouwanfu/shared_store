import 'package:shared_store/shared_store.dart';

class SharedStorePlugin {
  static void initMMKV({List<String> MMKVIds = const ["default"]}) {
    SharedStore.initMMKV(MMKVIds);
  }

  static void addMMKV(List<String> MMKVIds) {
    SharedStore.addMMKVId(MMKVIds);
  }

  static void storeInt(String key, int value, {String MMKVId = "default"}) {
    SharedStore.storeValue(key, value.toString(), valueType.intType, MMKVId);
  }

  static int? readInt(String key, {String MMKVId = "default"}) {
    int? intResult;
    String? intString = SharedStore.readValue(key, MMKVId);
    if (intString != null) {
      intResult = int.parse(intString);
    }
    return intResult;
  }

  static void storeString(String key, String value, {String MMKVId = "default"}) {
    SharedStore.storeValue(key, value, valueType.stringType, MMKVId);
  }

  static String? readString(String key, {String MMKVId = "default"}) {
    String? stringResult = SharedStore.readValue(key, MMKVId);
    return stringResult;
  }

  static void storeDouble(String key, double value, {String MMKVId = "default"}) {
    SharedStore.storeValue(key, value.toString(), valueType.doubleType, MMKVId);
  }

  static double? readDouble(String key, {String MMKVId = "default"}) {
    double? doubleResult;
    String? doubleString = SharedStore.readValue(key, MMKVId);
    if (doubleString != null) {
      doubleResult = double.parse(doubleString);
    }
    return doubleResult;
  }

  static void storeBool(String key, bool value, {String MMKVId = "default"}) {
    SharedStore.storeValue(key, value.toString(), valueType.boolType, MMKVId);
  }

  static bool? readBool(String key, {String MMKVId = "default"}) {
    bool? boolResult;
    String? boolString = SharedStore.readValue(key, MMKVId);
    if (boolString != null) {
      boolResult = boolString == "true" ? true : false;
    }
    return boolResult;
  }
}
