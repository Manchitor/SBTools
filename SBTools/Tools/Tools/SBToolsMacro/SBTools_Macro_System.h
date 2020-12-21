//
//  SBTools_Macro_System.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/14.
//  Copyright © 2020 lyj. All rights reserved.
//

#ifndef SBTools_Macro_System_h
#define SBTools_Macro_System_h

/**
 *  手机系统的版本
 */
#define SB_SYSTEM_VERSION      [[UIDevice currentDevice] systemVersion]

/**
 *  手机系统的语言
 */
#define SB_SYSTEM_LANGUAGE     ([[NSLocale preferredLanguages] objectAtIndex:0])

/**
 *  APP Bundle 版本
 */
#define SB_APP_BUNDLE_VERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/**
 *  APP 版本
 */
#define SB_APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


/**
 *  系统版本是ios11
 */
#define SB_TARGET_IOS11X       [[[UIDevice currentDevice] systemVersion] floatValue] >=11.0f

/**
 *  系统版本是ios10
 */
#define SB_TARGET_IOS10X       [[[UIDevice currentDevice] systemVersion] floatValue] >=10.0f

/**
 *  系统版本是ios9
 */
#define SB_TARGET_IOS9X        [[[UIDevice currentDevice] systemVersion] floatValue] >=9.0f

/**
 *  系统版本是ios8
 */
#define SB_TARGET_IOS8X        [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f

/**
 *  系统版本是ios7
 */
#define SB_TARGET_IOS7X        [[[UIDevice currentDevice] systemVersion] floatValue] >=7.0f



#endif /* SBTools_Macro_System_h */
