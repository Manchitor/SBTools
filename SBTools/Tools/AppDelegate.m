//
//  AppDelegate.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/5.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UncaughtExceptionHandler.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[ViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    [UncaughtExceptionHandler installUncaughtExceptionHandler:YES showAlert:YES];

    return YES;
}



@end
