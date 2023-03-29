//
//  NSFileManager+SBCategory.m
//  Tools
//
//  Created by 刘永吉 on 2023/3/28.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "NSFileManager+SBCategory.h"

@implementation NSFileManager (SBCategory)

- (BOOL)sb_file_exists:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

- (long)sb_file_size_path:(NSString *)path{
    NSError *error = nil;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                error:&error];
    if (error)
    {
        return 0;
    }
    NSString *fileSize = [NSString stringWithFormat:@"%@", [attributes objectForKey:@"NSFileSize"]];
    return fileSize.integerValue;
}

+ (BOOL)sb_file_create_folder:(NSString *)folder atPath:(NSString *)path
{
    NSString *savePath = [path stringByAppendingPathComponent:folder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL exist = [fileManager fileExistsAtPath:savePath isDirectory:&isDirectory];
    NSError *error = nil;
    if (!exist || !isDirectory)
    {
        [fileManager createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    return [fileManager fileExistsAtPath:savePath isDirectory:&isDirectory];
}

+ (BOOL)sb_file_save_data:(NSData *)data withName:(NSString *)name atPath:(NSString *)path
{
    if (data && name && path)
    {
        NSString *filePath = [path stringByAppendingPathComponent:name];
        return [data writeToFile:filePath atomically:YES];
    }
    
    return NO;
}

+ (NSData *)sb_file_find:(NSString *)fileName atPath:(NSString *)path
{
    NSData *data = nil;
    if (fileName && path)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        
        if ([fileManager fileExistsAtPath:filePath])
        {
            data = [NSData dataWithContentsOfFile:filePath];
        }
    }
    
    return data;
}

+ (BOOL)sb_file_find_delete:(NSString *)fileName atPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    return success;
}
@end
