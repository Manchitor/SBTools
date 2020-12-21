//
//  UIKitInit.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/11.
//  Copyright © 2020 lyj. All rights reserved.
//

#ifndef UIKitInit_h
#define UIKitInit_h
#import <WebKit/WebKit.h>
#import "UITextField+PlaceholderColor.h"


#pragma mark ----------UITableView（init）
static inline  UITableView * _Nonnull TABLEVIEW_INIT(UITableViewStyle style, id _Nullable classView) {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = classView;
    tableView.dataSource = classView;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.estimatedRowHeight = 44.f;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.rowHeight = UITableViewAutomaticDimension;
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    return tableView;
}

#pragma mark ----------UICollectionView（init）
static inline UICollectionView * _Nonnull COLLECTIONVIEW_INIT(UICollectionViewLayout * _Nullable flowlLayout, id _Nullable classView) {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlLayout];
    collectionView.delegate = classView;
    collectionView.dataSource = classView;
    collectionView.backgroundColor = [UIColor clearColor];
    return collectionView;
}

#pragma mark ----------UIScrollView（init）
static inline UIScrollView * _Nonnull SCROLLVIEW_INIT(id _Nullable classView) {
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = classView;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    return scrollView;
}

#pragma mark ----------WKWebView（init）
static inline WKWebView * _Nonnull WEBVIEW_INIT(id _Nullable classView) {
    WKWebViewConfiguration *wbConfig = [[WKWebViewConfiguration alloc] init];
    //允许视频播放
    if (@available(iOS 9.0, *)) {
        wbConfig.allowsAirPlayForMediaPlayback = YES;
    } else {
        // Fallback on earlier versions
    }
    // 允许在线播放
    wbConfig.allowsInlineMediaPlayback = YES;
    // 允许可以与网页交互，选择视图
    wbConfig.selectionGranularity = YES;
    // web内容处理池
    wbConfig.processPool = [[WKProcessPool alloc] init];
    //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
    WKUserContentController * wkUserContentC = [[WKUserContentController alloc]init];
    // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
    // [wkUserContentC addScriptMessageHandler:self name:@"name"];
    // 控制器中 可用 [self.webView.configuration.userContentController addScriptMessageHandler:@"name"]
    wbConfig.userContentController = wkUserContentC;
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wbConfig];
    //代理
    webView.UIDelegate = classView;
    webView.navigationDelegate = classView;
    //开启手势触摸
    webView.allowsBackForwardNavigationGestures = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return webView;
}

#pragma mark ----------UILabel（init）
static inline UILabel * _Nonnull LABEL_INIT(NSString * _Nonnull text,UIFont *_Nonnull font, UIColor* _Nonnull textColor) {
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    return label;
}

#pragma mark ----------UIButton（init）
static inline UIButton * _Nonnull BUTTON_INIT(NSString * _Nullable text,UIFont *_Nullable font, UIColor* _Nullable textColor,NSString* _Nullable imageString) {
    
    UIButton *button = [[UIButton alloc]init];
    
    [button setTitle:text ? text : @"" forState:UIControlStateNormal];
    
    [button setTitle:text ? text : @"" forState:UIControlStateSelected];

    [button setTitleColor:textColor ? textColor : [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    
    button.titleLabel.font = font ? font : [UIFont systemFontOfSize:16];
    
    if (imageString.length) {
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    }
    
    return button;
}

#pragma mark ----------LINE（init）
static inline UIView * _Nonnull LINE_INIT() {
    UIView *line = [UIView new];
    [line setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
    return line;
}

#pragma mark ----------BorderRadius（init）
static inline UIView * _Nonnull BORDERRADIUS_INIT(UIView *_Nonnull view,float Radius, float  Width, UIColor *_Nonnull Color) {
    [view.layer setCornerRadius:(Radius)];
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:(Width)];
    [view.layer setBorderColor:[Color CGColor]];

    return view;
}

#pragma mark ----------UITextField（init）
static inline UITextField * _Nonnull UITEXTFIELD_INIT(NSString * _Nullable placeholder,UIFont *_Nullable font, UIColor* _Nullable textColor,UIColor* _Nullable placeholderColor) {
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    
    textField.textColor =textColor;
    
    textField.font = font;
    
    textField.placeholder = placeholder;
    
    if (placeholder.length) {//有placeholder 才呢个设置placeholderColor 不然找不到placeholderlabel控件 会崩溃
        
        [textField setPlaceholderColor:placeholderColor];

    }
    return textField;
}
#endif /* UIKitInit_h */
