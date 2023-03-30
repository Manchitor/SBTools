//
//  SBAddressBookViewController.h
//  Tools
//  通讯录
//  Created by 刘永吉 on 2021/1/26.
//  Copyright © 2021 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RITLContactObject;

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (RITLContactFile)


/**
 根据RITLContactObject初始化AlertController

 @param contactObject RITLContactObject对象

 @return 创建好的UIAlertController对象
 */
+(instancetype)alertControllerWithContactObject:(RITLContactObject *)contactObject;

@end

NS_ASSUME_NONNULL_END
