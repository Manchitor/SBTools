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
+(BOOL)sb_install_QQ{
   //QQ mqq:// 或 mqqiapi://
   if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
       if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqqiapi://"]]) {
           return YES;
       }
   }
   return NO;
}


/**! 是否有安装微信 */
+(BOOL)sb_install_Wechat{
   //微信 weixin:// 或 wechat://
   if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
       if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]]) {
           return YES;
       }
   }
   return NO;
}


/**! 是否有安装新浪微博 */
+(BOOL)sb_install_Sina{
   //新浪微博 weibo:// 或 sinaweibo://
   if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]]) {
       if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]]) {
           return YES;
       }
   }
   return NO;
}


/**! 是否有安装支付宝 */
+(BOOL)sb_install_AliPay {
   //支付宝 alipay://
   if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
       return YES;
   }
   return NO;
}


/**! 是否有安装高德地图 */
+(BOOL)sb_install_GaodeMap{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        return YES;
    }
    return NO;
}


/**! 是否有安装百度地图 */
+(BOOL)sb_install_BaiduMap{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]){
        return YES;
    }
    return NO;
}

/**! 是否有安装腾讯地图 */
+(BOOL)sb_install_TencentMap{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]){
        return YES;
    }
    return NO;
}

@end
