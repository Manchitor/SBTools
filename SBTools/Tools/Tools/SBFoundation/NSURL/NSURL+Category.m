//
//  NSURL+Category.m
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/10.
//  Copyright © 2018年 lyj All rights reserved.
//

#import "NSURL+Category.h"

@implementation NSURL (Category)

-(NSString *)parameterForKey:(NSString *)key
{
    NSDictionary *parameters = [self parameters];
    if(parameters == nil)
        return nil;
    return parameters[key];
}

-(NSDictionary  *)parameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *query = [self query];
    NSArray *values = [query componentsSeparatedByString:@"&"];
    
    if(values == nil || values.count == 0)
        return nil;
    
    for(NSString *value in values)
    {
        NSArray *param = [value componentsSeparatedByString:@"="];
        if(param == nil || param.count !=2)
            continue;
        [parameters setObject:param[1] forKey:param[0]];
    }
    return parameters;
}

@end
