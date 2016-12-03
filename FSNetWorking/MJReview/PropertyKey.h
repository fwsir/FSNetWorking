//
//  PropertyKey.h
//  FSNetWorking
//
//  Created by BOOM on 16/12/3.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PropertyKeyType)
{
    PropertyKeyTypeDictionary = 0,
    PropertyKeyTypeArray
};

/**
    属性的key
 */
@interface PropertyKey : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) PropertyKeyType type;


- (id)valueInObject:(id)object;

@end
