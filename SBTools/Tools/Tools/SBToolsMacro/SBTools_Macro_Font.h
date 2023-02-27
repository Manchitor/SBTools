//
//  SBTools_Macro_Font.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/14.
//  Copyright © 2020 lyj. All rights reserved.
//

#ifndef SBTools_Macro_Font_h
#define SBTools_Macro_Font_h

/**
   设置字体
 */
#define SBFONT(size)            [UIFont systemFontOfSize:size]

/**
   设置加粗字体
 */
#define SBFONTBOLD(size)        [UIFont boldSystemFontOfSize:size]


/**
   苹果系统加粗字体
 */
#define SBFONTMEDIUM(fontSize)      [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize]


/**
    设置字体name
*/
#define SBFONTNAME(name, size)  [UIFont fontWithName:name size:size]


#endif /* SBTools_Macro_Font_h */
