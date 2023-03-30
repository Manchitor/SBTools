//
//  MainCustomModel.h
//  Tools
//
//  Created by 刘永吉 on 2023/3/30.
//  Copyright © 2023 lyj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainCustomModel : NSObject

@property (nonatomic,copy) NSString *exampleTitle;

@property (nonatomic,copy) NSString *exampleDesc;

+ (MainCustomModel *)setupExampleTitle:(NSString *)exampleTitle ExampleDesc:(NSString *)exampleDesc;

@end

NS_ASSUME_NONNULL_END
