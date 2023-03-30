//
//  CNContactFetchRequest+RITLContactFile.h
//  Tools
//
//  Created by 刘永吉 on 2022/6/27.
//
//

#import <Contacts/Contacts.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNContactFetchRequest (RITLContactFile)


/**
 获得联系人所有key的请求的便利初始化方法

 @return CNContactFetchRequest对象
 */
+(CNContactFetchRequest *)descriptorForAllKeys;

@end



NS_ASSUME_NONNULL_END
