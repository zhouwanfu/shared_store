import 'dart:async';
import 'package:flutter/services.dart';

enum valueType { boolType, intType, doubleType, stringType }

class SharedStore {
  static const MethodChannel _channel = MethodChannel('shared_store');

  static Future<String?> invoke(String method, Map<String, dynamic> paramters) async {
    final String? result = await _channel.invokeMethod(method, paramters);
    return result;
  }

  static Future<bool> initMMKV(List<String> MMKVIds) async {
    if (MMKVIds.isEmpty) {
      return false;
    }
    await invoke("initMMKV", {"MMKVIds": MMKVIds});
    return true;
  }

  static Future<bool> addMMKVId(List<String> MMKVIds) async {
    if (MMKVIds.isEmpty) {
      return false;
    }
    await invoke("addMMKVId", {"MMKVIds": MMKVIds});
    return true;
  }

  static void storeValue(String key, String value, valueType type, String MMKVId) async {
    await invoke("set_value", {"key": key, "value": value, "value_type": type, "MMKV_id": MMKVId});
  }

  static String? readValue(String key, String MMKVId) {
    String? result;
    invoke("get_value", {"MMKVId": MMKVId}).then((value) {
      result = value;
    });
    return result;
  }
}
