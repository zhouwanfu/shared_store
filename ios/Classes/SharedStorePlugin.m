#import "SharedStorePlugin.h"
#import "MMKV.h"
#import "SharedStore.h"

@interface SharedStorePlugin()

@property(nonatomic, strong)SharedStore *sharedStore;

@end

@implementation SharedStorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"shared_store"
            binaryMessenger:[registrar messenger]];
  SharedStorePlugin* instance = [[SharedStorePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"initMMKV" isEqualToString:call.method]) {
    result([self createDefaultMMKV]);
  }
  else if ([@"addMMKV" isEqualToString:call.method]) {
    result([self addMMKV:call]);
  }
  else if ([@"store_value" isEqualToString:call.method]) {
    result([self storeValue:call]);
  }
  else if([@"read_value" isEqualToString:call.method]) {
    result([self readValue:call]);
  }
  else if([@"remove_value" isEqualToString:call.method]) {
    result([self removeValue:call]);
  }else {
    NSAssert(1, @"FlutterMethodNotImplemented");
    result(FlutterMethodNotImplemented);
  }
}

- (SharedStore *)sharedStore {
  if (_sharedStore == nil) {
    _sharedStore = [[SharedStore alloc]init];
  }
  return _sharedStore;
}

- (id)createDefaultMMKV {
  return [self.sharedStore createDefaultMMKV];
}

- (id)addMMKV:(FlutterMethodCall *)call {
  NSString *MMKVId = call.arguments[kMMKVId];
  return [self.sharedStore addMMKV:MMKVId];
}

- (id)storeValue:(FlutterMethodCall *)call {
  NSString *MMKVId = call.arguments[kMMKVId];
  NSString *key = call.arguments[@"key"];
  NSString *value = call.arguments[@"value"];
  valueType type = [call.arguments[@"type"] integerValue];
  return [self.sharedStore storeValueWithMMKVId:MMKVId key:key value:value type:type];
}

- (id)readValue:(FlutterMethodCall *)call {
  NSString *MMKVId = call.arguments[kMMKVId];
  NSString *key = call.arguments[@"key"];
  valueType type = [call.arguments[@"type"] integerValue];
  return [self.sharedStore readValueWithMMKVId:MMKVId key:key type:type];
}

- (id)removeValue:(FlutterMethodCall *)call {
  NSString *MMKVId = call.arguments[kMMKVId];
  NSString *key = call.arguments[@"key"];
 return [self.sharedStore removeMMKVWithKey:key MMKVId:MMKVId];
}
@end
