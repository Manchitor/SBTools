//
//  MainCustomModel.m
//  Tools
//
//  Created by 刘永吉 on 2023/3/30.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "MainCustomModel.h"

@implementation MainCustomModel
+ (MainCustomModel *)setupExampleTitle:(NSString *)exampleTitle ExampleDesc:(NSString *)exampleDesc{
    
    MainCustomModel *model = [[MainCustomModel alloc] init];
    model.exampleTitle = exampleTitle;
    model.exampleDesc = exampleDesc;
    
    return model;
}
@end
