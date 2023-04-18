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

/**
 *    @brief    世界标准地理坐标(WGS-84) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
 *
 *  ####只在中国大陆的范围的坐标有效，以外直接返回世界标准坐标
 *
 *    @param     location     世界标准地理坐标(WGS-84)
 *
 *    @return    中国国测局地理坐标（GCJ-02）<火星坐标>
 */
+ (CLLocationCoordinate2D)sb_wgs84_to_gcj02:(CLLocationCoordinate2D)location;


/**
 *    @brief    世界标准地理坐标(WGS-84) 转换成 百度地理坐标（BD-09)
 *
 *    @param     location     世界标准地理坐标(WGS-84)
 *
 *    @return    百度地理坐标（BD-09)
 */
+ (CLLocationCoordinate2D)sb_wgs84_to_bd09:(CLLocationCoordinate2D)location;



/**
 *    @brief    中国国测局地理坐标（GCJ-02） 转换成 世界标准地理坐标（WGS-84）
 *
 *  ####此接口有1－2米左右的误差，需要精确定位情景慎用
 *
 *    @param     location     中国国测局地理坐标（GCJ-02）
 *
 *    @return    世界标准地理坐标（WGS-84）
 */
+ (CLLocationCoordinate2D)sb_gcj02_to_wgs84:(CLLocationCoordinate2D)location;




/**
 *    @brief    中国国测局地理坐标（GCJ-02）<火星坐标> 转换成 百度地理坐标（BD-09)
 *
 *    @param     location     中国国测局地理坐标（GCJ-02）<火星坐标>
 *
 *    @return    百度地理坐标（BD-09)
 */
+ (CLLocationCoordinate2D)sb_gcj02_to_bd09:(CLLocationCoordinate2D)location;


/**
 *    @brief    百度地理坐标（BD-09) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
 *
 *    @param     location     百度地理坐标（BD-09)
 *
 *    @return    中国国测局地理坐标（GCJ-02）<火星坐标>
 */
+ (CLLocationCoordinate2D)sb_bd09_to_gcj02:(CLLocationCoordinate2D)location;


/**
 *    @brief    百度地理坐标（BD-09) 转换成 世界标准地理坐标（WGS-84）
 *
 *  ####此接口有1－2米左右的误差，需要精确定位情景慎用
 *
 *    @param     location     百度地理坐标（BD-09)
 *
 *    @return    世界标准地理坐标（WGS-84）
 */
+ (CLLocationCoordinate2D)sb_bd09_to_wgs84:(CLLocationCoordinate2D)location;



///地图应用跳转传入目标经纬度
+ (void) openUrlApplication:(SBMapApplicationType) type locationCoordinate2D:(CLLocationCoordinate2D)locationCoordinate name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
