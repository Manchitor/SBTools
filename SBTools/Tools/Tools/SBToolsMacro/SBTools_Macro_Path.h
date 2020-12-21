//
//  SBTools_Macro_Path.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/14.
//  Copyright © 2020 lyj. All rights reserved.
//

#ifndef SBTools_Macro_Path_h
#define SBTools_Macro_Path_h

/**
 *  沙盒home地址
 */
#define SB_PATH_APP_HOME_PATH       NSHomeDirectory()

/**
 *  沙盒CACH地址
 */
#define SB_PATH_APP_CACHE_PATH      [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]

/**
 *  沙盒DOCUMENT地址
 */
#define SB_PATH_APP_DOCUMENT_PATH   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
/**
 *  沙盒DOCUMENT地址
 */
#define SB_PATH_APP_DOCUMENT_PATH2  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
/**
 *  沙盒LIBRARY地址
 */
#define SB_PATH_APP_LIBRARY_PATH    [NSHomeDirectory() stringByAppendingPathComponent:@"Library"]

/**
 *  沙盒TMP地址
 */
#define SB_PATH_APP_TMP_PATH        NSTemporaryDirectory()

/**
 *  main bundle地址
 */
#define SB_PATH_APP_MAIN_BUNDLE     [[NSBundle mainBundle] bundlePath]

/**
 *  main bundle resource地址
 */
#define SB_PATH_APP_MAIN_BUNDLE_RESOURCE  [[NSBundle mainBundle] resourcePath]

/**
 *  main bundle executable地址
 */
#define SB_PATH_APP_MAIN_BUNDLE_EXECUTABLE [[NSBundle mainBundle] executablePath]

#endif /* SBTools_Macro_Path_h */
