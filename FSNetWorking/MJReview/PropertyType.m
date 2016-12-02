//
//  PropertyType.m
//  FSNetWorking
//
//  Created by BOOM on 16/12/2.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "PropertyType.h"
#import "ExtensionConst.h"
#import "Foundation.h"

@implementation PropertyType

static NSMutableDictionary *s_types;

+ (void)initialize
{
    s_types = [NSMutableDictionary dictionary];
}

+ (instancetype)cacheTypeWithCode:(NSString *)code
{
    ExtensionAssertParamNotNil2(code, nil);
    
    @synchronized (self)
    {
        PropertyType *type = s_types[code];
        if (type == nil)
        {
            type = [[self alloc] init];
            type.code = code;
            s_types[code] = type;
        }
        
        return type;
    }
}

#pragma mark - 公共方法

- (void)setCode:(NSString *)code
{
    _code = code;
    
    ExtensionAssertParamNotNil(code);
    if ([code isEqualToString:PropertyTypeId])
    {
        _idType = YES;
    }
    else if (code.length == 0)
    {
        _kvcDisabled = YES;
    }
    else if (code.length > 3 && [code hasPrefix:@"@\""])
    {
        // 去掉@" 和 " 截取中间的类型名称
        _code = [code substringWithRange:NSMakeRange(2, code.length-3)];
        _typeClass = NSClassFromString(_code);
        _numberType = [_typeClass isSubclassOfClass:[NSNumber class]];
        _fromFoundation = [Foundation isClassFromFoundation:_typeClass];
    }
    else if ([code isEqualToString:PropertyTypeSEL] ||
             [code isEqualToString:PropertyTypeIvar] ||
             [code isEqualToString:PropertyTypeMethod])
    {
        _kvcDisabled = YES;
    }
    
    // 是否为数字类型
    NSString *lowerCode = _code.lowercaseString;
    NSArray *numberTypes = @[PropertyTypeInt, PropertyTypeShort, PropertyTypeBOOL1,
                             PropertyTypeBOOL2, PropertyTypeFloat, PropertyTypeDouble,
                             PropertyTypeLong, PropertyTypeLongLong, PropertyTypeChar];
    if ([numberTypes containsObject:lowerCode])
    {
        _numberType = YES;
    
        
    }
}

@end
