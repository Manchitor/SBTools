//
//  SBTools+Device.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/14.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools+Device.h"
#import <sys/utsname.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
@implementation SBTools (Device)
///获取手机 platform
+ (NSString *)curryPlatform{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
}
///获取手机型号
+ (NSString *)curryDeviceType{
    
    NSString *platform = [self curryPlatform];
    
    //------------------------------iPhone---------------------------
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"] ||
        [platform isEqualToString:@"iPhone3,2"] ||
        [platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"] ||
        [platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"] ||
        [platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"] ||
        [platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE 1";//1代
    
    if ([platform isEqualToString:@"iPhone9,1"] ||
        [platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"] ||
        [platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPhone10,1"] ||
        [platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"] ||
        [platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if ([platform isEqualToString:@"iPhone10,3"] ||
        [platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"] ||
        [platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE 2";//2代
    
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";

    if ([platform isEqualToString:@"iPhone14,2"]) return @"iPhone 13 Pro";
    if ([platform isEqualToString:@"iPhone14,3"]) return @"iPhone 13 Pro Max";
    if ([platform isEqualToString:@"iPhone14,4"]) return @"iPhone 13 mini";
    if ([platform isEqualToString:@"iPhone14,5"]) return @"iPhone 13";
    
    if ([platform isEqualToString:@"iPhone14,6"]) return @"iPhone SE 3";
    
    if ([platform isEqualToString:@"iPhone14,7"]) return @"iPhone 14";
    if ([platform isEqualToString:@"iPhone14,8"]) return @"iPhone 14 Plus";
    if ([platform isEqualToString:@"iPhone15,2"]) return @"iPhone 14 Pro";
    if ([platform isEqualToString:@"iPhone15,3"]) return @"iPhone 14 Pro Max";

    
    
    
    

    //------------------------------iPad--------------------------
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    
    if ([platform isEqualToString:@"iPad2,1"] ||
        [platform isEqualToString:@"iPad2,2"] ||
        [platform isEqualToString:@"iPad2,3"] ||
        [platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad3,1"] ||
        [platform isEqualToString:@"iPad3,2"] ||
        [platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"] ||
        [platform isEqualToString:@"iPad3,5"] ||
        [platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad6,11"] ||
        [platform isEqualToString:@"iPad6,12"]) return @"iPad 5";
    
    if ([platform isEqualToString:@"iPad7,5"] ||
        [platform isEqualToString:@"iPad7,6"]) return @"iPad 6";
   
    if ([platform isEqualToString:@"iPad7,11"] ||
        [platform isEqualToString:@"iPad7,12"]) return @"iPad 7";
    
    if ([platform isEqualToString:@"iPad11,6"] ||
        [platform isEqualToString:@"iPad11,7"]) return @"iPad 8";
    
    if ([platform isEqualToString:@"iPad12,1"] ||
        [platform isEqualToString:@"iPad12,2"]) return @"iPad 9";
    
    
    //------------------------------iPad Air-----------------------
    if ([platform isEqualToString:@"iPad4,1"] ||
        [platform isEqualToString:@"iPad4,2"] ||
        [platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad5,3"] ||
        [platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    
    if ([platform isEqualToString:@"iPad11,3"] ||
        [platform isEqualToString:@"iPa11,4"]) return @"iPad Air 3";
    
    if ([platform isEqualToString:@"iPad13,1"] ||
        [platform isEqualToString:@"iPad13,2"]) return @"iPad Air 4";
    
    if ([platform isEqualToString:@"iPad13,16"] ||
        [platform isEqualToString:@"iPad13,17"]) return @"iPad Air 5";
    
    
    //------------------------------iPad Pro-----------------------
    if ([platform isEqualToString:@"iPad6,3"] ||
        [platform isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7-inch";
    
    if ([platform isEqualToString:@"iPad6,7"] ||
        [platform isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9-inch 1";
    
    if ([platform isEqualToString:@"iPad7,1"] ||
        [platform isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
    
    if ([platform isEqualToString:@"iPad7,3"] ||
        [platform isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    
    if ([platform isEqualToString:@"iPad8,1"] ||
        [platform isEqualToString:@"iPad8,2"]||
        [platform isEqualToString:@"iPad8,3"]||
        [platform isEqualToString:@"iPad8,4"]) return @"iPad Pro 11-inch";
    
    if ([platform isEqualToString:@"iPad8,5"] ||
        [platform isEqualToString:@"iPad8,6"]||
        [platform isEqualToString:@"iPad8,7"] ||
        [platform isEqualToString:@"iPad8,8"]) return @"iPad Pro 12.9-inch 3";
    
    if ([platform isEqualToString:@"iPad8,9"] ||
        [platform isEqualToString:@"iPad8,10"]) return @"iPad Pro 11-inch 2";
    
    if ([platform isEqualToString:@"iPad8,11"] ||
        [platform isEqualToString:@"iPad8,12"]) return @"iPad Pro 12.9-inch 4";
    
    if ([platform isEqualToString:@"iPad13,4"] ||
        [platform isEqualToString:@"iPad13,5"]||
        [platform isEqualToString:@"iPad13,6"]||
        [platform isEqualToString:@"iPad13,7"]) return @"iPad Pro 11-inch 3";
    
    if ([platform isEqualToString:@"iPad13,8"] ||
        [platform isEqualToString:@"iPad13,9"]||
        [platform isEqualToString:@"iPad13,10"]||
        [platform isEqualToString:@"iPad13,11"]) return @"iPad Pro 12.9-inch 5";
    
    
    
    
    //------------------------------iPad Mini-----------------------
    if ([platform isEqualToString:@"iPad2,5"] ||
        [platform isEqualToString:@"iPad2,6"] ||
        [platform isEqualToString:@"iPad2,7"]) return @"iPad mini";
    
    if ([platform isEqualToString:@"iPad4,4"] ||
        [platform isEqualToString:@"iPad4,5"] ||
        [platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    
    if ([platform isEqualToString:@"iPad4,7"] ||
        [platform isEqualToString:@"iPad4,8"] ||
        [platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    
    if ([platform isEqualToString:@"iPad5,1"] ||
        [platform isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    
    if ([platform isEqualToString:@"iPad11,1"] ||
        [platform isEqualToString:@"iPad11,2"]) return @"iPad mini 5";
    
    if ([platform isEqualToString:@"iPad14,1"] ||
        [platform isEqualToString:@"iPad14,2"]) return @"iPad mini 6";
    
    
    
    //------------------------------iTouch------------------------
    if ([platform isEqualToString:@"iPod1,1"]) return @"iTouch";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iTouch 2";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iTouch 3";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iTouch 4";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iTouch 5";
    if ([platform isEqualToString:@"iPod7,1"]) return @"iTouch 6";
    if ([platform isEqualToString:@"iPod9,1"]) return @"iTouch 7";
    
    //------------------------------Apple TV------------------------
    if ([platform isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([platform isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";
    if ([platform isEqualToString:@"AppleTV6,2"])    return @"Apple TV 4K";
    if ([platform isEqualToString:@"AppleTV11,1"])    return @"Apple TV 4K 2";

    
    
    //------------------------------Samulitor-------------------------------------
    if ([platform isEqualToString:@"i386"] ||
        [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return @"Unknown";
}
+ (BOOL)isiPad{
    return [[[self curryPlatform] substringToIndex:4] isEqualToString:@"iPad"];
}

+ (BOOL)isiPhone{
    return [[[self curryPlatform] substringToIndex:6] isEqualToString:@"iPhone"];
}

+ (BOOL)isiPod{
    return [[[self curryPlatform] substringToIndex:4] isEqualToString:@"iPod"];
}

+ (BOOL)isSimulator{
    return [[self curryPlatform] isEqualToString:@"i386"] || [[self curryPlatform] isEqualToString:@"x86_64"];
}
/**
 判断设备是否为Retina屏

 @return YES即为Retina屏
 */
+ (BOOL)isRetina{
    return [[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)]
       && ([UIScreen mainScreen].scale == 2.0 || [UIScreen mainScreen].scale == 3.0);
}

/**
 判断设备是否为Retina HD屏
 
 @return YES即为Retina HD屏
 */
+ (BOOL)isRetinaHD{
    return [[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)]
    && ([UIScreen mainScreen].scale == 3.0);
}

/**
 当前设备是否有摄像头

 @return YES即为有摄像头
 */
+ (BOOL)isHasCamera{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
/**
 获取当前设备名称

 @return 当前设备名称
 */
+ (NSString *)curryDeviceName{
    return [[UIDevice currentDevice] name];
}

/**
 获取设备iOS版本号

 @return 版本号字符串
 */
+ (NSString *)curryiOSVersion{
    return [[UIDevice currentDevice] systemVersion];

}

/**
 获取当前设备cpu主频

 @return 当前设备cpu主频
 */
+ (NSUInteger)curryCPUFrequency{
    return  [self currySystemInfo:HW_CPU_FREQ];
}

/**
 获取当前设备总线带宽

 @return 当前设备总线带宽
 */
+ (NSUInteger)curryBusFrequency{
    return  [self currySystemInfo:HW_BUS_FREQ];

}

/**
 获取当前设备物理内存大小

 @return 当前设备物理内存大小
 */
+ (NSUInteger)curryRamSize{
    return [self currySystemInfo:HW_MEMSIZE];
}

/**
 获取当前设备cpu核数

 @return 当前设备cpu核数
 */
+ (NSUInteger)curryCPUNumber{
    return [self currySystemInfo:HW_NCPU];
}

/**
 获取当前设备mac地址
 
 @return 当前设备mac地址
 */
+ (NSString *)curryMacAddress{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

/**
 获取当前设备总内存

 @return 当前设备总内存
 */
+ (NSUInteger)curryTotalMemoryBytes{
    return [self currySystemInfo:HW_PHYSMEM];

}

/**
 获取当前设备内核内存

 @return 当前设备内核内存
 */
+ (NSUInteger)curryUserMemoryBytes{
    return [self currySystemInfo:HW_USERMEM];
}

/**
 获取当前设备总闪存大小

 @return 当前设备总闪存大小
 */
+ (NSNumber *)curryTotalDiskSpaceBytes{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

/**
  获取当前设备空闲闪存大小

 @return 当前设备空闲闪存大小
 */
+ (NSNumber *)curryFreeDiskSpaceBytes{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}


#pragma mark - Private
+ (NSUInteger)currySystemInfo:(uint)typeSpecifier {
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}
@end
