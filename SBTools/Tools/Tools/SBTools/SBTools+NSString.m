//
//  SBTools+NSString.m
//  Tools
//
//  Created by 刘永吉 on 2020/12/21.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools+NSString.h"

@implementation SBTools (NSString)


/// 判读是否为空或输入只有空格
/// @param string 字符串
BOOL sb_string_empty(NSString *string){
    if (!string || [string isEqual:[NSNull null]]){
        return YES;
    }else{
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [string stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0 || [trimedString isEqualToString:@"(null)"] || [trimedString isEqualToString:@"<null>"] || [trimedString isEqualToString:@"null"]){
            return YES;
        }else{
            return NO;
        }
    }
}


/// 将汉字转成拼音
/// @param chinese 汉字
+ (NSString *)sb_string_transform_pinyin:(NSString *)chinese{
    //0.将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //1.将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //2.去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

/// 去除字符串中的换行
/// @param string 字符串
+ (NSString *)sb_string_trim:(NSString *)string{
    //1.去除掉首尾的空白字符和换行字符
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2.去除掉其它位置的空白字符和换行字符
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return string;
}


/// 手机号格式化处理
/// @param intputPhone 手机号
+ (NSString *)sb_string_format_phone:(NSString *)intputPhone{
    NSString *string = [intputPhone copy];
    NSInteger lenth = string.length;
    NSString *format;
    NSString *formatString;

    if (lenth >3 && lenth < 8) {//3 7
        format = [NSString stringWithFormat:@"(\\d{3})(\\d{%ld})",lenth-3];
        formatString = @"$1 $2";
    }else if (lenth>7 && lenth < 12){//8 11
        format = [NSString stringWithFormat:@"(\\d{3})(\\d{4})(\\d{%ld})",lenth-7];
        formatString = @"$1 $2 $3";
    }else{
        format = @"(\\d{3})(\\d{4})(\\d{4})";
        formatString = @"$1 $2 $3";
    }
    return [string stringByReplacingOccurrencesOfString:format withString:formatString options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])];
}

/// 判断一个字符串是否包含汉字
/// @param string 字符串
+ (NSInteger )sb_string_chinese_count:(NSString*)string{
    NSInteger flag = 0;
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if(a>0x4e00&&a<0x9fff){
            flag++;
        }
    }
    return flag;
}

/// 获取字符串高度 宽度
/// @param font 字体
/// @param text 内容
/// @param maxWidth 最大宽度
+ (CGSize)sb_string_max_size:(UIFont *)font text:(NSString *)text maxWidth:(CGFloat)maxWidth {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attribute
                                     context:nil];
    return rect.size;
}



/// 手机号脱敏
/// @param phone 手机号
+ (NSString*) sb_string_secrect_phone:(NSString*)phone{
    
    NSMutableString *newStr = [NSMutableString stringWithString:phone];
    NSRange range = NSMakeRange(3, 4);
    [newStr replaceCharactersInRange:range withString:@"****"];
    
    return newStr;
}

/// 邮箱脱敏
/// @param email 邮箱
+ (NSString*) sb_string_secrect_email:(NSString*)email{
    
    NSMutableString *newStr = [NSMutableString stringWithString:email];

    //处理邮箱字符串
    // 12345678@qq.com  -->>  邮箱123****89@qq.com
    NSArray * emailArray = [email componentsSeparatedByString:@"@"];
    NSString * emailHead = emailArray.firstObject;
    NSString * emailLast = emailArray.lastObject;
    //拼接
    NSInteger emailHeadLength = emailHead.length;
    if(emailHeadLength>3) {//大于3位的邮箱  可以拼接前三位后两位方式
        newStr = [NSMutableString stringWithString:[emailHead substringToIndex:3]];
        for (int i = 0; i < 3; i++) [newStr appendString:@"*"];//中间*号
    }else{//不足3位邮箱  前一位
        newStr = [NSMutableString stringWithString:emailHead];
        for (int i = 0; i < 3; i++) [newStr appendString:@"*"];//中间*号
    }
    //加后缀
    [newStr appendString:emailLast];
    
    return  newStr;
}


/// 缓存单位转换
/// @param size @(1024)
+ (NSString *)sb_string_size_unit_formatted:(NSNumber *)size{
    double convertedValue = [size doubleValue];
    int multiplyFactor = 0;
    
    NSArray *tokens = @[@"b", @"KB", @"MB", @"GB", @"TB"];
    
    while(convertedValue > 1024){
        convertedValue /= 1024;
        
        multiplyFactor++;
    }
    
    NSString *sizeFormat = ((multiplyFactor > 1) ? @"%4.2f %@" : @"%4.0f %@");
    
    return [NSString stringWithFormat:sizeFormat, convertedValue, tokens[multiplyFactor]];
}

@end
