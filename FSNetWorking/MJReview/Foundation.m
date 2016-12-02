//
//  Foundation.m
//  FSNetWorking
//
//  Created by BOOM on 16/12/2.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "Foundation.h"
#import "ExtensionConst.h"
#import <CoreData/CoreData.h>

@implementation Foundation

static NSSet *s_classes;

+ (NSSet *)foundationClasses
{
    if (s_classes == nil)
    {
        // 集合中没有NSObject,应为几乎所有的类型都是继承自NSObject
        // 具体是不是NSObject类型需要特殊判断
        s_classes = [NSSet setWithObjects:
                     [NSURL class],
                     [NSDate class],
                     [NSValue class],
                     [NSData class],
                     [NSError class],
                     [NSArray class],
                     [NSDictionary class],
                     [NSString class],
                     [NSAttributedString class] ,nil];
    }
    
    return s_classes;
}

+ (BOOL)isClassFromFoundation:(Class)c
{
    if (c == [NSObject class] || c == [NSManagedObject class]) return YES;
    
    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop)
    {
        if ([c isSubclassOfClass:foundationClass])
        {
            result = YES;
            *stop = YES;
        }
    }];
    
    return result;
}

@end
