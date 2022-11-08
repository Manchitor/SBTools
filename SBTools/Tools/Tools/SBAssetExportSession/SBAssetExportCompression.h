//
//  SBAssetExportCompression.h
//  Tools
//
//  Created by 刘永吉 on 2022/11/8.
//  Copyright © 2022 lyj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBAssetExportCompression : NSObject

+ (void) AVAssetExportSessionWithAsset:(NSString *)videoPath;
@end

NS_ASSUME_NONNULL_END
