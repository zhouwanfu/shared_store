import 'dart:async';
import 'package:flutter/services.dart';

enum valueType { boolType, intType, doubleType, stringType }

class SharedStore {
  static const MethodChannel _channel = MethodChannel('shared_store');

  static Future<String?> invoke(String method, Map<String, dynamic> paramters) async {
    final String? result = await _channel.invokeMethod(method, paramters);
    return result;
  }

  static Future<bool> initMMKV() async {
    await invoke("initMMKV", {});
    return true;
  }

  static Future<bool> addMMKVId(String MMKVId) async {
    if (MMKVId.isEmpty) {
      return false;
    }
    await invoke("addMMKV", {"MMKVId": MMKVId});
    return true;
  }

  static Future<String?> storeValue(String key, String value, valueType type, String MMKVId) async {
    return await invoke("store_value", {"key": key, "value": value, "type": type.index.toString(), "MMKVId": MMKVId});
  }

  static Future<String?> readValue(String key, valueType type, String MMKVId) async {
    String? result = await invoke("read_value", {"MMKVId": MMKVId, "key": key, "type": type.index.toString()});
    return result;
  }

  static void removeValue(String key, String MMKVId) {
    invoke("remove_value", {"key": key, "MMKVId": MMKVId});
  }
}
