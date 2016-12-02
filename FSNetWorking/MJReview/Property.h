//
//  Property.h
//  FSNetWorking
//
//  Created by BOOM on 16/12/2.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 包装一个成员
@interface Property : NSObject

/**
 成员属性
 */
@property (nonatomic, assign) objc_property_t property;

@property (nonatomic, readonly) NSString *name;



@end

NS_ASSUME_NONNULL_END
