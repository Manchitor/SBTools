//
//  NSString+Ext.m
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/8.
//  Copyright © 2018年 lyj All rights reserved.
//

#import "NSString+Ext.h"
#import "NSData+Ext.h"
#import "NSString+Path.h"
#import <sys/sysctl.h>
#import <sys/socket.h>
#import <net/if.h>
#import <net/if_dl.h>

@implementation NSString (Ext)

- (NSString *)trimLeft
{

    NSString *resultString = self;    
    while ([resultString hasPrefix:@" "])
    {
        if (resultString.length > 0) {
            resultString = [resultString substringFromIndex:1];
        } else {
            return resultString;
        }
    }
    return resultString;
}

- (NSString *)trimRight
{
    return [[[self antitone] trimLeft] antitone];
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimAll
{
    NSString *tempString = self.trim;
    return [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)trimLetters
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
}

- (NSString *)trimCharacter:(unichar)character
{
    NSString *str = [NSString stringWithFormat:@"%c", character];
    return [self stringByReplacingOccurrencesOfString:str withString:@""];
}

- (NSString *)trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)numberOfLines
{
    return [self componentsSeparatedByString:@"\n"].count + 1;
}

- (NSString *) antitone {
    
   __block NSMutableString *str = [NSMutableString string];
    // NSStringEnumerationReverse ：表示反向遍历
    // NSStringEnumerationByComposedCharacterSequences ： 表示按字符遍历
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [str appendString:substring];
    }];
    
    return str;
}

- (BOOL)isEmpty
{
    //return self == nil || self.length == 0;
    if (!self || [self isEqual:[NSNull null]])
    {
        return YES;
    }
    else
    {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0 || [trimedString isEqualToString:@"(null)"])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
}

- (BOOL)isTrimEmpty
{
    return self == nil || self.trim.length == 0;
}

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
{
    //  [\u4e00-\u9fa5A-Za-z0-9_]{4,20}
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *regex = [NSString stringWithFormat:@"%@[%@A-Za-z0-9_]{%d,%d}", first, hanzi, (int)(minLenth-1), (int)(maxLenth-1)];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
{
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

/** 去掉两端空格和换行符 */
- (NSString *)stringByTrimmingBlank
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)addPrefix:(NSString *)prefix
{
    if (prefix == nil || prefix.length == 0)
    {
        return self;
    }
    
    return [NSString stringWithFormat:@"%@%@", prefix, self];
}

- (NSString *)addSubfix:(NSString *)subfix
{
    if (subfix == nil || subfix.length == 0)
    {
        return self;
    }
    
    return [NSString stringWithFormat:@"%@%@", self, subfix];
}

+ (NSString *)contentsOfFile:(NSString *)fileName
{
    __autoreleasing NSError* error = nil;
    NSString *result = [[NSString alloc] initWithContentsOfFile:[NSString pathWithFileName:fileName]
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    if (error != nil)
    {
        return nil;
    }
    return result;
}

+ (id)jsonDataFromFileName:(NSString *)fileName
{
    NSString *jsonString = [NSString contentsOfFile:fileName];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil)
    {
        return nil;
    }
    return result;
}
- (CGSize)sizeWithMyFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSDictionary *textAttributes = @{NSFontAttributeName : font};
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:textAttributes
                                     context:nil];
    return rect.size;
}
@end
