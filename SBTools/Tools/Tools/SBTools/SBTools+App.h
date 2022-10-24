//
//  SBTools+App.h
//  Tools
//
//  Created by 刘永吉 on 2021/2/22.
//  Copyright © 2021 lyj. All rights reserved.
//

#import "SBTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBTools (App)

//MARK: - 相关App是否有安装检测
/**! 是否有安装QQ */
+(BOOL)isInstallForQQ;

/**! 是否有安装微信 */
+(BOOL)isInstallForWechat;

/**! 是否有安装新浪微博 */
+(BOOL)isInstallForSina;

/**! 是否有安装支付宝 */
+(BOOL)isInstallForAliPay;

/**! 是否有安装高德地图 */
+(BOOL)isInstallForGaodeMap;

/**! 是否有安装百度地图 */
+(BOOL)isInstallForBaiduMap;

/**! 是否有安装腾讯地图 */
+(BOOL)isInstallForTencentMap;


@end

NS_ASSUME_NONNULL_END
