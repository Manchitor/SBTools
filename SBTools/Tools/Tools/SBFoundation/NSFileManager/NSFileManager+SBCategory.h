//
//  NSFileManager+SBCategory.h
//  Tools
//
//  Created by 刘永吉 on 2023/3/28.
//  Copyright © 2023 lyj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (SBCategory)

/*!
 * @brief 判断文件是否存在
 *
 * @param filePath 文件路径名
 * @return 返回YES表示存在，返回NO表示不存在
 */
- (BOOL)sb_file_exists:(NSString *)filePath;

/*!
 * @brief 根据路径获取文件的大小
 *
 * @param path 文件路径名
 * @return 文件的大小
 */
- (long)sb_file_size_path:(NSString *)path;

/**
 *  在相应目录下创建一个文件夹。
 *  @param  folder 文件夹名。
 *  @param  path 文件夹所在路径。
 *  return  成功返回YES，失败返回NO。若已存在直接返回YES。
 */
+ (BOOL)sb_file_create_folder:(NSString *)folder atPath:(NSString *)path;

/**
 *  保存文件到相应路径下。
 *  @param  data 要保存的数据。
 *  @param  name 要保存的文件名，如a.txt等。
 *  @param  path 文件保存的路径目录。
 *  return  成功返回YES，失败返回NO。
 */
+ (BOOL)sb_file_save_data:(NSData *)data withName:(NSString *)name atPath:(NSString *)path;

/**
 *  查找并返回文件。
 *  @param  fileName 要查找的文件名。
 *  @param  path 文件所在的目录。
 *  return  成功返回文件，失败返回nil。
 */
+ (NSData *)sb_file_find:(NSString *)fileName atPath:(NSString *)path;

/**
 *  删除文件。
 *  @param  fileName 要删除的文件名。
 *  @param  path 文件所在的目录。
 *  return  成功返回YES，失败返回NO。
 */
+ (BOOL)sb_file_find_delete:(NSString *)fileName atPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
