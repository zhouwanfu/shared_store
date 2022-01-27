
import 'dart:async';

import 'package:flutter/services.dart';

class SharedStore {
  static const MethodChannel _channel = MethodChannel('shared_store');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
