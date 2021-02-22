//
//  SBTools+NetWork.h
//  Tools
//
//  Created by 刘永吉 on 2021/1/18.
//  Copyright © 2021 lyj. All rights reserved.
//

#import "SBTools.h"
#import <SystemConfiguration/CaptiveNetwork.h>


NS_ASSUME_NONNULL_BEGIN

@interface SBTools (NetWork)


#pragma mark 获取Wifi信息
+ (id)sb_NetWorkGetWifiInfo;

#pragma mark 获取WIFI名字
+ (NSString *)sb_NetWorkGetWifiName;


#pragma mark 获取WIFI的MAC地址
+ (NSString *)sb_NetWorkGetWifiAddress;

#pragma mark ----------获取网络连接类型
+ (NSString *)sb_NetWorkGetNetworkType;

@end

NS_ASSUME_NONNULL_END
