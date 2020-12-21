//
//  SBTools+Device.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/14.
//  Copyright © 2020 lyj. All rights reserved.
//


#import "SBTools.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBTools (Device)

/**
 设备识别码
 
 例如:"iPhone3,2"

 @return 设备平台类型
*/
+ (NSString *)curryPlatform;
/**
 根据系统平台类型获取设备名

 例如:"iPhone 4"

 @return 设备名字符串
*/
+ (NSString *)curryDeviceType;

/**
 判断设备是否为iPad
 @return YES即为iPad
*/
+ (BOOL)isiPad;

/**
 判断设备是否为iPhone

 @return YES即为iPhone
*/
+ (BOOL)isiPhone;

/**
 判断设备是否为iPod

 @return YES即为iPod
*/
+ (BOOL)isiPod;

/**
 判断设备是否为模拟器

 @return YES即为模拟器
*/
+ (BOOL)isSimulator;
/**
 判断设备是否为Retina屏

 @return YES即为Retina屏
 */
+ (BOOL)isRetina;

/**
 判断设备是否为Retina HD屏
 
 @return YES即为Retina HD屏
 */
+ (BOOL)isRetinaHD;

/**
 当前设备是否有摄像头

 @return YES即为有摄像头
 */
+ (BOOL)isHasCamera;

/**
 获取当前设备名称

 @return 当前设备名称
 */
+ (NSString *)curryDeviceName;

/**
 获取设备iOS版本号

 @return 版本号字符串
 */
+ (NSString *)curryiOSVersion;

/**
 获取当前设备cpu主频

 @return 当前设备cpu主频
 */
+ (NSUInteger)curryCPUFrequency;

/**
 获取当前设备总线带宽

 @return 当前设备总线带宽
 */
+ (NSUInteger)curryBusFrequency;

/**
 获取当前设备物理内存大小

 @return 当前设备物理内存大小
 */
+ (NSUInteger)curryRamSize;

/**
 获取当前设备cpu核数

 @return 当前设备cpu核数
 */
+ (NSUInteger)curryCPUNumber;

/**
 获取当前设备mac地址
 
 @return 当前设备mac地址
 */
+ (NSString *)curryMacAddress;

/**
 获取当前设备总内存

 @return 当前设备总内存
 */
+ (NSUInteger)curryTotalMemoryBytes;

/**
 获取当前设备内核内存

 @return 当前设备内核内存
 */
+ (NSUInteger)curryUserMemoryBytes;

/**
 获取当前设备总闪存大小

 @return 当前设备总闪存大小
 */
+ (NSNumber *)curryTotalDiskSpaceBytes;

/**
  获取当前设备空闲闪存大小

 @return 当前设备空闲闪存大小
 */
+ (NSNumber *)curryFreeDiskSpaceBytes;
@end

NS_ASSUME_NONNULL_END
