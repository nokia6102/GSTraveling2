//
//  SubwebViewController.h
//  GSTraveling
//
//  Created by Me on 2018/3/23.
//  Copyright © 2018年 MyCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface SubwebViewController : UIViewController<WKNavigationDelegate>

@property (nonatomic, retain) WKWebView *webView;
@property (nonatomic, retain) WKWebViewConfiguration *webConfiguration;

@end
