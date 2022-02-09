package com.sailor.shared_store;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;
import com.tencent.mmkv.MMKV;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** SharedStorePlugin */
public class SharedStorePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Map<String, MMKV> _MMKVPool;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "shared_store");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("initMMKV")) {
      createDefaultMMKV();
      result.success("true");
    }
    else if (call.method.equals("addMMKV")) {
      boolean success = addMMKV(call);
      if (success) {
        result.success("true");
      } else {
        result.success("false");
      }
    }else if (call.method.equals("store_value")) {
      boolean success = storeVale(call);
      if (success) {
        result.success("true");
      } else {
        result.success("false");
      }

    }else if (call.method.equals("read_value")) {
      result.success(readValue(call));
    }else if (call.method.equals("remove_value")) {
      boolean success = removeValue(call);
      if (success) {
        result.success("true");
      } else {
        result.success("false");
      }
    }else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  private void createDefaultMMKV() {
    this._MMKVPool = new HashMap<>();
    MMKV defaultMMKV = MMKV.mmkvWithID("defaultMMKV");
    this._MMKVPool.put("defaultMMKV", defaultMMKV);
  }

  private boolean addMMKV(MethodCall call) {
    boolean result = false;
    String MMKVId = call.argument("MMKVId");
    if (this._MMKVPool != null && MMKVId != null) {
      MMKV customMMKV = MMKV.mmkvWithID(MMKVId);
      this._MMKVPool.put(MMKVId, customMMKV);
      result = true;
    }
    return result;
  }

  private boolean storeVale(MethodCall call) {
    boolean result = false;
    String MMKVId = call.argument("MMKVId");
    int type = Integer.parseInt(call.argument("type"));
    String key = call.argument("key");
    String value = call.argument("value");
    MMKV mmkv = this._MMKVPool.get(MMKVId);
    if (mmkv != null && key != null && value != null) {
      switch (type) {
        case 0 :
          mmkv.putBoolean(key, value == "true" ? true : false);
          break;
        case 1:
          mmkv.putInt(key, Integer.parseInt(value));
          break;
        case 2:
          mmkv.putFloat(key, Float.parseFloat(value));
          break;
        case 3:
          mmkv.putString(key, value);
      }
      result = true;
    }
    return result;
  }

  private String readValue(MethodCall call) {
    String result = "";
    String MMKVId = call.argument("MMKVId");
    int type = Integer.parseInt(call.argument("type"));
    String key = call.argument("key");
    MMKV mmkv = this._MMKVPool.get(MMKVId);
    if (mmkv != null && key != null ) {
      switch (type) {
        case 0:
          result = mmkv.getBoolean(key, false) == true ? "true" : "false";
          break;
        case 1:
          result = Integer.toString(mmkv.getInt(key, Integer.MIN_VALUE));
          break;
        case 2:
          result = Float.toString(mmkv.getFloat(key, Float.MIN_VALUE));
          break;
        case 3:
          result = mmkv.getString(key,null);
      }
    }
    return result;
  }

  private boolean removeValue(MethodCall call) {
    boolean result = false;
    String MMKVId = call.argument("MMKVId");
    String key = call.argument("key");
    MMKV mmkv = this._MMKVPool.get(MMKVId);
    if (key != null && mmkv != null) {
      mmkv.removeValueForKey(key);
      result = true;
    }
    return result;
  }
}
