//
//  RITLContactObject+RITLContactFile.h
//  Tools
//
//  Created by 刘永吉 on 2022/6/27.
//
//

#import "RITLContactObject.h"

NS_ASSUME_NONNULL_BEGIN

@class CNContact;
@class CNPostalAddress;

@interface NSObject (RITLContactFile)

- (void)contactObject:(CNContact *)contact NS_AVAILABLE_IOS(9_0);

@end

@interface RITLContactObject (RITLContactFile)

/**
 获得只存放电话号码的数组

 @return 存放电话号码的数组
 */
- (NSArray <NSString *> *)phones;

@end


@interface RITLContactNameObject (RITLContactFile)

@end


@interface RITLContactAddressObject (RITLContactFile)

/**
 针对CNPostalAddress进行模型转换

 @param cnAddressObject CNPostalAddress对象
 */
- (void)contactObject:(CNPostalAddress *)cnAddressObject;


@end

NS_ASSUME_NONNULL_END
