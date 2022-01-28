#import "SharedStorePlugin.h"
#import  "MMKV.h"

#define kMMKVId @"mmkvId"
#define kDefaultMMKVId @"default"

@interface SharedStorePlugin()
@property(nonatomic, strong)NSDictionary *MMKVPool;
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
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
  
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
  
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.MMKVPool = [NSDictionary dictionary];
  }
  return self;
}

- (id)createDefaultMMKV{
  MMKV *defaultMMKV = [MMKV mmkvWithID:kDefaultMMKVId];
  [_MMKVPool setValue:defaultMMKV forKey:kDefaultMMKVId];
  return @"true";
}

- (id)addMMKV:(FlutterMethodCall *)call {
  NSString *result = @"true";
  NSString *mmkvId = call.arguments[kMMKVId];
  if (mmkvId == NULL) {
    result = @"false";
  }else {
    MMKV *customMMKV = [MMKV mmkvWithID:mmkvId];
    [_MMKVPool setValue:customMMKV forKey:mmkvId];
  }
  return result;
}

- (id)storeValueWithMMKVId:(NSString *)mmkvId key:(NSString *)key value:(NSString *)value type:(NSString *)type {
  NSString *result = @"true";
  MMKV *mmkv = _MMKVPool[kMMKVId];
  //bool int double string
  switch (type.integerValue) {
    case 0:
      [mmkv setBool:[value isEqualToString:@"true"] forKey:key];
      break;
    case 1:
      [mmkv setInt64:value.intValue forKey:key];
    case 2:
      [mmkv setFloat:value.floatValue forKey:key];
    case 3:
      [mmkv setValue:value forKey:key];
    default:
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
  }
  return result;
}

- (NSString *)readValueWithMMKVId:(NSString *)mmkvId key:(NSString *)key type:(NSString *)type {
  NSString *result = @"";
  MMKV *mmkv = _MMKVPool[kMMKVId];
  switch (type.integerValue) {
    case 0:
      result = [mmkv getBoolForKey:key] ? @"true" : @"false";
      break;
    case 1:
      result = [NSString stringWithFormat:@"%lld",[mmkv getInt64ForKey:key]];
      break;;
    case 2:
      result = [NSString stringWithFormat:@"%f",[mmkv getFloatForKey:key]];
      break;
    case 3:
      result = [mmkv getStringForKey:key];
    default:
      break;
  }
  return result;
}
- (id)readValue:(FlutterMethodCall *)call {
  NSString *result = @"";
  if (call.arguments[kMMKVId] && call.arguments[@"key"] && call.arguments[@"value"] && call.arguments[@"type"]) {
    result = [self readValueWithMMKVId:call.arguments[kMMKVId] key:call.arguments[@"key"] type:call.arguments[@"type"]];
  }
  return result;
}

@end
