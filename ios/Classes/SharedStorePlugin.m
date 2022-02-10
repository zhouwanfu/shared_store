#import "SharedStorePlugin.h"
#import  "MMKV.h"

#define kMMKVId @"MMKVId"
#define kDefaultMMKVId @"default"

@interface SharedStorePlugin()
@property(nonatomic, strong)NSMutableDictionary *MMKVPool;
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

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.MMKVPool = [NSMutableDictionary dictionary];
  }
  return self;
}

- (id)createDefaultMMKV {
  if (_MMKVPool[kDefaultMMKVId]) {
    NSAssert(1, @"Repeat initialization");
    return @"false";
  }
  MMKV *defaultMMKV = [MMKV mmkvWithID:kDefaultMMKVId];
  [_MMKVPool setValue:defaultMMKV forKey:kDefaultMMKVId];
  return @"true";
}

- (id)addMMKV:(FlutterMethodCall *)call {
  NSString *result = @"true";
  NSString *mmkvId = call.arguments[kMMKVId];
  if (mmkvId == nil || _MMKVPool[mmkvId]) {
    result = @"false";
    NSAssert(1, @"Invalid MMKVId");
  }else {
    MMKV *customMMKV = [MMKV mmkvWithID:mmkvId];
    [_MMKVPool setValue:customMMKV forKey:mmkvId];
  }
  return result;
}

- (id)storeValueWithMMKVId:(NSString *)mmkvId key:(NSString *)key value:(NSString *)value type:(NSString *)type {
  NSString *result = @"true";
  MMKV *mmkv = _MMKVPool[mmkvId];
  switch (type.integerValue) {
    case 0:
      [mmkv setBool:[value isEqualToString:@"true"] forKey:key];
      break;
    case 1:
      [mmkv setInt64:value.intValue forKey:key];
      break;
    case 2:
      [mmkv setDouble:value.doubleValue forKey:key];
      break;
    case 3:
      [mmkv setString:value forKey:key];
      break;
    default:
      NSAssert(1, @"Invalid type");
      result = @"false";
      break;
  }
  return result;
}

- (id)storeValue:(FlutterMethodCall *)call {
  NSString *result = @"true";
  if (call.arguments[kMMKVId] && call.arguments[@"key"] && call.arguments[@"value"] && call.arguments[@"type"]) {
    [self storeValueWithMMKVId:call.arguments[kMMKVId] key:call.arguments[@"key"] value:call.arguments[@"value"] type:call.arguments[@"type"]];
  } else {
    result = @"false";
    NSAssert(1, @"Parameter is not complete");
  }
  return result;
}

- (NSString *)readValueWithMMKVId:(NSString *)mmkvId key:(NSString *)key type:(NSString *)type {
  NSString *result = @"";
  MMKV *mmkv = _MMKVPool[mmkvId];
  switch (type.integerValue) {
    case 0:
      result = [mmkv getBoolForKey:key] ? @"true" : @"false";
      break;
    case 1:
      result = [NSString stringWithFormat:@"%lld",[mmkv getInt64ForKey:key]];
      break;;
    case 2:
      result = [NSString stringWithFormat:@"%@",@([mmkv getDoubleForKey:key])];
      break;
    case 3:
      result = [mmkv getStringForKey:key];
    default:
      NSAssert(1, @"Invalid type");
      break;
  }
  return result;
}
- (id)readValue:(FlutterMethodCall *)call {
  NSString *result = @"";
  if (call.arguments[kMMKVId] && call.arguments[@"key"] && call.arguments[@"type"]) {
    result = [self readValueWithMMKVId:call.arguments[kMMKVId] key:call.arguments[@"key"] type:call.arguments[@"type"]];
  } else {
    NSAssert(1, @"Parameter is not complete");
  }
  return result;
}

- (void)removeValueWithKey:(NSString *)key MMKVId:(NSString *)MMKVId {
  MMKV *mmkv = _MMKVPool[MMKVId];
  [mmkv removeValueForKey:key];
}

- (id)removeValue:(FlutterMethodCall *)call {
  BOOL result = false;
  if (call.arguments[kMMKVId] && call.arguments[@"key"] && call.arguments[@"MMKVId"]) {
    [self removeValueWithKey:call.arguments[@"key"] MMKVId:call.arguments[@"MMKVId"]];
    result = true;
  } else {
    NSAssert(1, @"Parameter is not complete");
  }
  return result == true ? @"true" : @"false";
}
@end
