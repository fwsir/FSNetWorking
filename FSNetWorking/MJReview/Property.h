//
//  Property.h
//  FSNetWorking
//
//  Created by BOOM on 16/12/2.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

#import "PropertyKey.h"
#import "PropertyType.h"

NS_ASSUME_NONNULL_BEGIN

// 包装一个成员
@interface Property : NSObject

/**
 成员属性
 */
@property (nonatomic, assign) objc_property_t property;

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly) PropertyType *type;

@property (nonatomic, assign) Class srcClass;


- (void)setOriginKey:(id)originKey forClass:(Class)c;

- (NSArray *)propertyKeysForClass:(Class)c;

- (void)setObjectClassInArray:(Class)objectClass forClass:(Class)c;
- (Class)objectClassInArrayForClass:(Class)c;

- (void)setValue:(id)value forObject:(id)object;

- (id)valueForObject:(id)object;

+ (instancetype)cachedPropertyWithProperty:(objc_property_t)property;

@end

NS_ASSUME_NONNULL_END
