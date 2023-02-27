//
//  SBTools+NSString.m
//  Tools
//
//  Created by 刘永吉 on 2020/12/21.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools+NSString.h"

@implementation SBTools (NSString)

/// 去除字符串中的换行 空格
/// @param string 字符串
+(NSString *)sbTransformSpaceReplacing:(NSString *)string{
    //3.去除掉首尾的空白字符和换行字符
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //4.去除掉其它位置的空白字符和换行字符
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}


/// 将汉字转成拼音
/// @param chinese 汉字
+ (NSString *)sbTtransformChineseToPinyin:(NSString *)chinese{
    //0.将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //1.将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //2.去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}


/// 手机号格式化处理
/// @param intputPhone 手机号
+ (NSString *)sbFormatPhone:(NSString *)intputPhone{
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

/// html向字符串转化
/// @param string html字符串
+ (NSAttributedString*)sbHtmlStringToString:(NSString *)string{
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attrStr;
}

/// 判断一个字符串是否包含汉字
/// @param string 字符串
+ (NSInteger )sbCountChineseContainInString:(NSString*)string{
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
+ (CGSize)sbSizeWithFont:(UIFont *)font text:(NSString *)text maxWidth:(CGFloat)maxWidth {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attribute
                                     context:nil];
    return rect.size;
}

/// 判读是否为空或输入只有空格
/// @param string 字符串
BOOL sb_isEmptyString(NSString *string){
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

///判读对象是否为空
BOOL sb_isEmptyObject(id data){
    BOOL result = NO;
    if (data != nil) {
        if ([data isKindOfClass:[NSObject class]]) {
            if ([data isKindOfClass:[NSString class]]) {
                if ([(NSString *)data isEqualToString:@""] || data == nil) {
                    result = YES;
                }
            }
            else if ([data isKindOfClass:[NSArray class]]){
                if (((NSArray *)data).count == 0 || data == nil) {
                    result = YES;
                }
            }
            else if(data == nil)
            {
                result = YES;
            }
        }
    }else{
        result = YES;
    }
    
    return result;
}
@end
