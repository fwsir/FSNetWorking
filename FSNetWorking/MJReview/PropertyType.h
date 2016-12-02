//
//  PropertyType.h
//  FSNetWorking
//
//  Created by BOOM on 16/12/2.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *   包装一种类型
 */
@interface PropertyType : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, readonly, getter=isIdType) BOOL idType;

@property (nonatomic, readonly, getter=isNumberType) BOOL numberType;

@property (nonatomic, readonly, getter=isBoolType) BOOL boolType;

@property (nonatomic, readonly) Class typeClass;

@property (nonatomic, readonly, getter=isFromFoundation) BOOL fromFoundation;

@property (nonatomic, readonly, getter=isKVCDisabled) BOOL kvcDisabled;


+ (instancetype)cacheTypeWithCode:(NSString *)code;

@end
