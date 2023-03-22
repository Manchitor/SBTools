//
//  SBTools+Device.h
//  Tools
//  https://www.theiphonewiki.com/wiki/Models
//  Created by 刘永吉 on 2020/8/14.
//  Copyright © 2020 lyj. All rights reserved.
//


#import "SBTools.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBTools (Device)

/// 设备识别码 例如:"iPhone3,2"
+ (NSString *)sb_device_platform;

/// 获取设备型号：iPhone 5、iPhone 5s、iPhone 6...
/// 官方wiki文档：https://www.theiphonewiki.com/wiki/Models
+ (NSString *)sb_device_model_name;

/// 判断设备是否为Retina显示屏
+ (BOOL)sb_device_retina;

/// 判断设备是否为RetinaHD高清显示屏
+ (BOOL)sb_device_hd_retina;

/// 当前设备是否有摄像头
+ (BOOL)sb_device_camera;

/// 获取当前设备名称
+ (NSString *)sb_device_Name;

/// 获取设备iOS版本号
+ (NSString *)sb_device_version;

/// 获取当前设备cpu主频
+ (NSUInteger)sb_device_cpu_frequency;

/// 获取当前设备总线带宽
+ (NSUInteger)sb_device_bus_frequency;

/// 获取当前设备物理内存大小
+ (NSUInteger)sb_device_ram_size;

/// 获取当前设备cpu核数
+ (NSUInteger)sb_device_cpu_num;

/// 获取当前设备mac地址
+ (NSString *)sb_device_mac_address;

/// 获取当前设备总内存
+ (NSUInteger)sb_device_total_memory;

/// 获取当前设备内核内存
+ (NSUInteger)sb_device_user_memory;

/// 获取当前设备总闪存大小
+ (NSNumber *)sb_device_total_disk_space;

// 获取当前设备空闲闪存大小
+ (NSNumber *)sb_device_total_free_disk_space;
@end

NS_ASSUME_NONNULL_END
