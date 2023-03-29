//
//  NSDictionary+SBCategory.m
//  Tools
//
//  Created by 刘永吉 on 2023/3/28.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "NSDictionary+SBCategory.h"

@implementation NSDictionary (SBCategory)

+ (NSDictionary *)sb_dictionary_form_json:(NSString *)jsonString{
    if (jsonString == nil){
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"NSDictionary+Ext:json解析失败->%@",err);
        return nil;
    }
    
    return dic;
}

- (NSString *)sb_dictionary_to_json{
    NSData *infoJsonData = [NSJSONSerialization dataWithJSONObject:self
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
    NSString *json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
    
    return json;
}
@end
