package com.sailor.shared_store;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.sailor.shared_store.SharedStore;

/** SharedStorePlugin */
public class SharedStorePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private SharedStore sharedStore;


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "shared_store");
    channel.setMethodCallHandler(this);
    this.sharedStore = new SharedStore();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("initMMKV")) {
      result.success(createDefaultMMKV());
    }
    else if (call.method.equals("addMMKV")) {
      result.success(addMMKV(call));
    }else if (call.method.equals("store_value")) {
      result.success(storeVale(call));
    }else if (call.method.equals("read_value")) {
      result.success(readValue(call));
    }else if (call.method.equals("remove_value")) {
      result.success(removeValue(call));
    }else {
      assert false : "notImplemented";
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  private String createDefaultMMKV() {
    return this.sharedStore.createDefaultMMKV();
  }

  private String addMMKV(MethodCall call) {
    String MMKVId = call.argument("MMKVId");
    return this.sharedStore.addMMKV(MMKVId);
  }

  private String storeVale(MethodCall call) {
    String MMKVId = call.argument("MMKVId");
    int type = Integer.parseInt(call.argument("type"));
    String key = call.argument("key");
    String value = call.argument("value");
    return this.sharedStore.storeVale(MMKVId, type, key, value);
  }

  private String readValue(MethodCall call) {
    String MMKVId = call.argument("MMKVId");
    int type = Integer.parseInt(call.argument("type"));
    String key = call.argument("key");
    return this.sharedStore.readValue(MMKVId, type, key);
  }

  private String removeValue(MethodCall call) {
    String MMKVId = call.argument("MMKVId");
    String key = call.argument("key");
    return this.sharedStore.removeValue(MMKVId, key);
  }
}
