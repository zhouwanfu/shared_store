//
//  SharedStore.m
//  shared_store
//
//  Created by sailor on 2022/3/1.
//

#import "SharedStore.h"
#import  "MMKV.h"

@interface SharedStore()

@property(nonatomic, strong)NSMutableDictionary *MMKVPool;

@end

@implementation SharedStore

- (NSMutableDictionary *)MMKVPool {
  if (_MMKVPool == nil) {
    _MMKVPool = [NSMutableDictionary dictionary];
  }
  return _MMKVPool;
}

- (id)createDefaultMMKV {
  MMKV *defaultMMKV = [MMKV mmkvWithID:kDefaultMMKVId];
  [self.MMKVPool setValue:defaultMMKV forKey:kDefaultMMKVId];
  return @"true";
}

- (id)addMMKV:(NSString *)MMKVId {
  NSString *result = @"true";
  if (MMKVId == nil || self.MMKVPool[MMKVId]) {
    result = @"false";
    NSAssert(1, @"Invalid MMKVId");
  }else {
    MMKV *customMMKV = [MMKV mmkvWithID:MMKVId];
    [self.MMKVPool setValue:customMMKV forKey:MMKVId];
  }
  return result;
}

- (id)storeValueWithMMKVId:(NSString *)MMKVId key:(NSString *)key value:(NSString *)value type:(valueType)type {
  NSString *result = @"true";
  MMKV *mmkv = [self getMMKVWithMMKVId:MMKVId];
  switch (type) {
    case boolType:
      [mmkv setBool:[value isEqualToString:@"true"] forKey:key];
      break;
    case intType:
      [mmkv setInt64:value.intValue forKey:key];
      break;
    case doubleType:
      [mmkv setDouble:value.doubleValue forKey:key];
      break;
    case stringType:
      [mmkv setString:value forKey:key];
      break;
    default:
      NSAssert(1, @"Invalid type");
      result = @"false";
      break;
  }
  return result;
}

- (id)readValueWithMMKVId:(NSString *)mmkvId key:(NSString *)key type:(valueType)type {
  NSString *result = @"";
  MMKV *mmkv = self.MMKVPool[mmkvId];
  switch (type) {
    case boolType:
      result = [mmkv getBoolForKey:key] ? @"true" : @"false";
      break;
    case intType:
      result = [NSString stringWithFormat:@"%lld",[mmkv getInt64ForKey:key]];
      break;;
    case doubleType:
      result = [NSString stringWithFormat:@"%@",@([mmkv getDoubleForKey:key])];
      break;
    case stringType:
      result = [mmkv getStringForKey:key];
    default:
      NSAssert(1, @"Invalid type");
      break;
  }
  return result;
}

- (id)removeMMKVWithKey:(NSString *)key MMKVId:(NSString *)MMKVId {
  MMKV *mmkv = self.MMKVPool[MMKVId];
  [mmkv removeValueForKey:key];
  return @"true";
}

- (MMKV *)getMMKVWithMMKVId:(NSString *)MMKVId {
  if (self.MMKVPool == nil) {
    return nil;
  }
  if (MMKVId == nil) {
    return nil;
  }
  return self.MMKVPool[MMKVId];
}
@end
