//
//  ExtensionConst.h
//  FSNetWorking
//
//  Created by BOOM on 16/12/2.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define ExtensionAssertParamNotNil(param)  \
        ExtensionAssertParamNotNil2(param, )


#define ExtensionAssertParamNotNil2(param, returnValue) \
        ExtensionAssert2((param) != nil, returnValue)

#define ExtensionAssert2(condition, returnValue) \
        if ((condition) == NO) return returnValue;

/**
 *  类型（属性类型）
 */
UIKIT_EXTERN NSString *const  PropertyTypeInt;
UIKIT_EXTERN NSString *const  PropertyTypeShort;
UIKIT_EXTERN NSString *const  PropertyTypeFloat;
UIKIT_EXTERN NSString *const  PropertyTypeDouble;
UIKIT_EXTERN NSString *const  PropertyTypeLong;
UIKIT_EXTERN NSString *const  PropertyTypeLongLong;
UIKIT_EXTERN NSString *const  PropertyTypeChar;
UIKIT_EXTERN NSString *const  PropertyTypeBOOL1;
UIKIT_EXTERN NSString *const  PropertyTypeBOOL2;
UIKIT_EXTERN NSString *const  PropertyTypePointer;

UIKIT_EXTERN NSString *const  PropertyTypeIvar;
UIKIT_EXTERN NSString *const  PropertyTypeMethod;
UIKIT_EXTERN NSString *const  PropertyTypeBlock;
UIKIT_EXTERN NSString *const  PropertyTypeClass;
UIKIT_EXTERN NSString *const  PropertyTypeSEL;
UIKIT_EXTERN NSString *const  PropertyTypeId;
