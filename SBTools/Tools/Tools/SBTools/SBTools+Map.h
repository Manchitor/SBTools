//
//  SBTools+Map.h
//  Tools
//
//  Created by 刘永吉 on 2023/3/22.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBTools.h"
#import <MapKit/MapKit.h>


NS_ASSUME_NONNULL_BEGIN
/// 手机应用地图类型
typedef NS_ENUM(NSInteger, SBMapApplicationType) {
    /// Apple地图
    SBMapApplicationTypeApple       = 0,
    /// 高德地图
    SBMapApplicationTypeGaode       = 1,
    /// 百度地图
    SBMapApplicationTypeBaidu       = 2,
    /// 腾讯地图
    SBMapApplicationTypeTencent     = 3,
    
};

@interface SBTools (Map)

/// 百度坐标转高德坐标
+ (CLLocationCoordinate2D)GCJ02FromBD09:(CLLocationCoordinate2D)coor;
 
// 高德坐标转百度坐标
+ (CLLocationCoordinate2D)BD09FromGCJ02:(CLLocationCoordinate2D)coor;

///地图应用跳转传入目标经纬度
+ (void) openUrlApplication:(SBMapApplicationType) type locationCoordinate2D:(CLLocationCoordinate2D)locationCoordinate name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
