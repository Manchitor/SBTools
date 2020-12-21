//
//  SBTools_Macro_Color.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/14.
//  Copyright © 2020 lyj. All rights reserved.
//

#ifndef SBTools_Macro_Color_h
#define SBTools_Macro_Color_h

//同数颜色
#define SBCOLOR(a)      SBRGB(a,a,a)

//rgb 设置颜色
#define SBRGB(r,g,b)      SBRGBA(r,g,b,1.0f)

// rgbs设置颜色
#define SBRGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//十六进制设置颜色 0xffffff
#define SBCOLORHEX(c,a)   [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]

//随机颜色
#define SBRandomColor SBRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))




#endif /* SBTools_Macro_Color_h */
