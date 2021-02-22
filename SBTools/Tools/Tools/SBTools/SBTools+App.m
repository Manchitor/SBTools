//
//  SBTools+App.m
//  Tools
//
//  Created by 刘永吉 on 2021/2/22.
//  Copyright © 2021 lyj. All rights reserved.
//

#import "SBTools+App.h"

@implementation SBTools (App)

//MARK: - 相关App是否有安装检测

/**! 是否有安装QQ */
+(BOOL)isInstallForQQ{
   //QQ mqq:// 或 mqqiapi://
   if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
       if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqqiapi://"]]) {
           return NO;
       }
   }
   
   return YES;
}

/**! 是否有安装微信 */
+(BOOL)isInstallForWechat {
   //微信 weixin:// 或 wechat://
   if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
       if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]]) {
           return NO;
       }
   }
   
   return YES;
}

/**! 是否有安装新浪微博 */
+(BOOL)isInstallForSina {
   //新浪微博 weibo:// 或 sinaweibo://
   if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]]) {
       if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]]) {
           return NO;
       }
   }
   
   return YES;
}

/**! 是否有安装支付宝 */
+(BOOL)isInstallForAliPay {
   //支付宝 alipay://
   if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
       return NO;
   }
   
   return YES;
}
@end
