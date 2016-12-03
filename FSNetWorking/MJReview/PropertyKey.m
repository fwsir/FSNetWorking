//
//  PropertyKey.m
//  FSNetWorking
//
//  Created by BOOM on 16/12/3.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "PropertyKey.h"

@implementation PropertyKey

- (id)valueInObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]] && self.type == PropertyKeyTypeDictionary)
    {
        return object[self.name];
    }
    else if ([object isKindOfClass:[NSArray class]] && self.type == PropertyKeyTypeArray)
    {
        NSArray *array = object;
        NSUInteger index = self.name.integerValue;
        if (index < array.count)
        {
            return array[index];
        }
        
        return nil;
    }
    
    return nil;
}

@end
