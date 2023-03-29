//
//  NSDictionary+SBCategory.h
//  Tools
//
//  Created by 刘永吉 on 2023/3/28.
//  Copyright © 2023 lyj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (SBCategory)
/*!
 * 把格式化的JSON格式的字符串转换成字典
 *
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)sb_dictionary_form_json:(NSString *)jsonString;

/*!
 * 获取JSON字符串
 *
 * @return 把字典转换成JSON串
 */
- (NSString *)sb_dictionary_to_json;
@end

NS_ASSUME_NONNULL_END
