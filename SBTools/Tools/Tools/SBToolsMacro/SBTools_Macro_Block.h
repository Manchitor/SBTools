//
//  SBTools_Macro_Block.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/19.
//  Copyright © 2020 lyj. All rights reserved.
//

#ifndef SBTools_Macro_Block_h
#define SBTools_Macro_Block_h

typedef void (^SBErrorBlock)(NSError *error);

typedef void (^SBVoidBlock)(void);

typedef void (^SBNotificationBlock)(NSNotification *notification);

typedef void (^SBBoolBlock)(BOOL result);

typedef void (^SBBoolMsgBlock)(BOOL result, NSString *errorMsg);

typedef void (^SBArrayBlock)(NSArray *resultList);

typedef void (^SBArrayMsgBlock)(NSArray *resultList, NSString *errorMsg);

typedef void (^SBDictionaryBlock)(NSDictionary *resultDict);

typedef void (^SBDictionaryMsgBlock)(NSDictionary *resultDict, NSString *errorMsg);

typedef void (^SBNumberBlock)(NSNumber *resultNumber);

typedef void (^SBNumberMsgBlock)(NSNumber *resultNumber, NSString *errorMsg);

typedef void (^SBIntegerBlock)(NSInteger resultNumber);

typedef void (^SBIntegerMsgBlock)(NSInteger resultNumber, NSString *errorMsg);

typedef void (^SBStringBlock)(NSString *result);

typedef void (^SBStringMsgBlock)(NSString *result, NSString *errorMsg);

typedef void (^SBObjectBlock)(id sender);

typedef void (^SBObjectMsgBlock)(id result, NSString *errorMsg);

typedef void (^SBDoubleBlock)(double resultDouble);

#endif /* SBTools_Macro_Block_h */
