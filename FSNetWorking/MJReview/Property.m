//
//  Property.m
//  FSNetWorking
//
//  Created by BOOM on 16/12/2.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "Property.h"
#import "Foundation.h"
#import "ExtensionConst.h"
#import <objc/message.h>

@interface Property ()

@property (nonatomic, strong) NSMutableDictionary *propertyKeysDict;
@property (nonatomic, strong) NSMutableDictionary *objectClassInArrayDict;

@end

@implementation Property

- (instancetype)init
{
    if (self = [super init])
    {
        _propertyKeysDict = [NSMutableDictionary dictionary];
        _objectClassInArrayDict = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark - 缓存

+ (instancetype)cachedPropertyWithProperty:(objc_property_t)property
{
    Property *propertyObj = objc_getAssociatedObject(self, property);
    if (property == nil)
    {
        propertyObj = [[self alloc] init];
        propertyObj.property = property;
        objc_setAssociatedObject(self, property, propertyObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return propertyObj;
}

#pragma mark - 公共方法

- (void)setProperty:(objc_property_t)property
{
    _property = property;
    
    ExtensionAssertParamNotNil(property);
    
    // 属性名
    _name = @(property_getName(property));
    
    // 成员类型
    NSString *attrs = @(property_getAttributes(property));
    NSUInteger dotLoc = [attrs rangeOfString:@","].location;
    NSString *code = nil;
    
    NSUInteger loc = 1;
    if (dotLoc == NSNotFound)
    {
        code = [attrs substringFromIndex:loc];
    }
    else
    {
        code = [attrs substringWithRange:NSMakeRange(loc, dotLoc-loc)];
    }
    
    _type = [PropertyType cacheTypeWithCode:code];
}

/**
 获取成员变量的值

 @param object 对象
 @return 返回结果
 */
- (id)valueForObject:(id)object
{
    if (self.type.kvcDisabled) return [NSNull null];
    
    return [object valueForObject:self.name];
}

/**
 设置成员变量的值

 @param value 设定的值
 @param object 设定的对象
 */
- (void)setValue:(id)value forObject:(id)object
{
    if (self.type.kvcDisabled || value == nil) return;
    
    [self setValue:value forKey:self.name];
}

- (NSArray *)propertykeysWithStringKey:(NSString *)stringKey
{
    if (stringKey.length == 0) return nil;
    
    NSMutableArray *propertyKeys = @[].mutableCopy;
    
    // 如果有多级映射
    NSArray *oldKeys = [stringKey componentsSeparatedByString:@"."];
    for (NSString *oldKey in oldKeys)
    {
        NSUInteger start = [oldKey rangeOfString:@"["].location;
        if (start != NSNotFound)
        {
            NSString *prefixKey = [oldKey substringToIndex:start];
            NSString *indexKey = prefixKey;
            if (prefixKey.length)
            {
                PropertyKey *propertyKey = [[PropertyKey alloc] init];
                propertyKey.name = prefixKey;
                [propertyKeys addObject:propertyKey];
                
                indexKey = [oldKey stringByReplacingOccurrencesOfString:prefixKey withString:@""];
            }
            
            // 解析索引
            // 元素
            NSArray *cmps = [[indexKey stringByReplacingOccurrencesOfString:@"[" withString:@""] componentsSeparatedByString:@"]"];
            for (NSInteger i = 0; i < cmps.count - 1; ++i)
            {
                PropertyKey *subPropertyKey = [[PropertyKey alloc] init];
                subPropertyKey.type = PropertyKeyTypeArray;
                subPropertyKey.name = cmps[i];
                [propertyKeys addObject:subPropertyKey];
            }
        }
        else
        {
            
        }
    }
    
    return nil;
}

@end
