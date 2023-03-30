//
//  CNContactFetchRequest+RITLContactFile.m
//  Tools
//
//  Created by 刘永吉 on 2022/6/27.
//

#import "CNContactFetchRequest+RITLContactFile.h"
#import "NSString+RITLContactFile.h"


@implementation CNContactFetchRequest (RITLContactFile)


+(CNContactFetchRequest *)descriptorForAllKeys
{
    return [[CNContactFetchRequest alloc]initWithKeysToFetch:[NSString RITLContactAllKeys]];
}


@end
