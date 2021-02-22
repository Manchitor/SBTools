//
//  NSArray+Ext.m
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/10.
//  Copyright © 2018年 lyj All rights reserved.
//

#import "NSArray+Ext.h"

@implementation NSArray (Ext)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    NSUInteger count = [self count];
    
    if (count > 0 && index < count)
    {
        return [self objectAtIndex:index];
    }
    
    return nil;
}

- (NSArray *)reversedArray
{
    return [NSArray reversedArray:self];
}

+ (NSArray *)reversedArray:(NSArray *)array
{
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[array count]];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    
    for (id element in enumerator)
    {
        [arrayTemp addObject:element];
    }
    
    return array;
}

- (NSString *)toJson
{
    return [NSArray toJson:self];
}

+ (NSString *)toJson:(NSArray *)array
{
    if (![array isKindOfClass:[NSArray class]] || array == nil || array.count == 0)
    {
        return nil;
    }
    NSString *json = nil;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    
    if (!error)
    {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    }
    
    return nil;
}

- (BOOL)isContainsString:(NSString *)string
{
    for (NSString *element in self) {
        if ([element isKindOfClass:[NSString class]] && [element isEqualToString:string])
        {
            return true;
        }
    }
    
    return false;
}

/**
 *  追加数据
 *
 */
-(NSArray *)appendArray:(NSArray *)newArray
{
    //异常处理
    if(newArray == nil || newArray.count ==0) return self;
    
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:self];
    
    [arrM addObjectsFromArray:newArray];
    
    return arrM;
}
@end
