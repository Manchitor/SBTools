//
//  SBTools+Map.m
//  Tools
//
//  Created by 刘永吉 on 2023/3/22.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBTools+Map.h"


@implementation SBTools (Map)
/// 百度坐标转高德坐标
+ (CLLocationCoordinate2D)GCJ02FromBD09:(CLLocationCoordinate2D)coor
{
    CLLocationDegrees x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    CLLocationDegrees x = coor.longitude - 0.0065, y = coor.latitude - 0.006;
    CLLocationDegrees z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    CLLocationDegrees theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    CLLocationDegrees gg_lon = z * cos(theta);
    CLLocationDegrees gg_lat = z * sin(theta);
    return CLLocationCoordinate2DMake(gg_lat, gg_lon);
}
 
// 高德坐标转百度坐标
+ (CLLocationCoordinate2D)BD09FromGCJ02:(CLLocationCoordinate2D)coor
{
    CLLocationDegrees x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    CLLocationDegrees x = coor.longitude, y = coor.latitude;
    CLLocationDegrees z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    CLLocationDegrees theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    CLLocationDegrees bd_lon = z * cos(theta) + 0.0065;
    CLLocationDegrees bd_lat = z * sin(theta) + 0.006;
    return CLLocationCoordinate2DMake(bd_lat, bd_lon);
}


///地图应用跳转传入目标经纬度
+ (void) openUrlApplication:(SBMapApplicationType) type locationCoordinate2D:(CLLocationCoordinate2D)locationCoordinate name:(NSString *)name{
    NSString *urlsting = nil;
    if (type == SBMapApplicationTypeApple) {
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *tolocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:[SBTools GCJ02FromBD09:locationCoordinate] addressDictionary:nil]];
        tolocation.name=name;
        [MKMapItem openMapsWithItems:@[currentLocation,tolocation]launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
    }else if (type == SBMapApplicationTypeGaode){
        urlsting =[[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&did=BGVIS2&dlat=%lf&dlon=%lf&dname=%@&dev=0&t=0",[SBTools GCJ02FromBD09:locationCoordinate].latitude,[SBTools GCJ02FromBD09:locationCoordinate].longitude,name] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else if (type == SBMapApplicationTypeBaidu){
        urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin=我的位置&destination=latlng:%f,%f|name:%@&mode=driving&coord_type=gcj02",locationCoordinate.latitude,locationCoordinate.longitude,name] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else if (type == SBMapApplicationTypeTencent){
        urlsting =[[NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&from=我的位置&to=%@&tocoord=%lf,%lf&referer=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77",name,[SBTools GCJ02FromBD09:locationCoordinate].latitude,[SBTools GCJ02FromBD09:locationCoordinate].longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    //打开应用内跳转
    if(!urlsting) return;
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
    }
}
@end
