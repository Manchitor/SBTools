//
//  NSString+SBCategory.m
//  Tools
//
//  Created by 刘永吉 on 2023/3/28.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "NSString+SBCategory.h"

@implementation NSString (SBCategory)

- (NSURL *)sb_to_url{
    return [NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}
@end
