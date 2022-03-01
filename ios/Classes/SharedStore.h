//
//  SharedStore.h
//  shared_store
//
//  Created by sailor on 2022/3/1.
//

#import <Foundation/Foundation.h>

#define kMMKVId @"MMKVId"
#define kDefaultMMKVId @"default"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, valueType) {
  boolType,
  intType,
  doubleType,
  stringType,
};

@interface SharedStore : NSObject

- (id)createDefaultMMKV;

- (id)addMMKV:(NSString *)MMKVId;

- (id)storeValueWithMMKVId:(NSString *)MMKVId key:(NSString *)key value:(NSString *)value type:(valueType)type;

- (id)readValueWithMMKVId:(NSString *)mmkvId key:(NSString *)key type:(valueType)type;

- (id)removeMMKVWithKey:(NSString *)key MMKVId:(NSString *)MMKVId;

@end

NS_ASSUME_NONNULL_END
