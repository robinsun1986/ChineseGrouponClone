//
//  GPDealWebController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealWebController.h"
#import "GPDeal.h"

@interface GPDealWebController () <UIWebViewDelegate>
{
    UIWebView *_webView;
    UIView *_cover;
}
@end

@implementation GPDealWebController

- (void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.delegate = self;
    _webView.backgroundColor = kGlobalBg;
    _webView.scrollView.backgroundColor = kGlobalBg;
    CGFloat topMargin = 70;
    _webView.scrollView.contentInset = UIEdgeInsetsMake(topMargin, 0, 0, 0);
    _webView.scrollView.contentOffset = CGPointMake(0, -topMargin);
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //MyLog(@"%@", _deal.deal_h5_url);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_deal.deal_h5_url]]];
}

#pragma mark intercept all requests of web view
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _cover = [[UIView alloc] init];
    _cover.frame = webView.bounds;
    _cover.backgroundColor = kGlobalBg;
    _cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [webView addSubview:_cover];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    CGFloat x = _cover.frame.size.width * 0.5;
    CGFloat y = _cover.frame.size.height * 0.5;
    indicator.center = CGPointMake(x, y);
    [indicator startAnimating];
    [_cover addSubview:indicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // remove cover
    [_cover removeFromSuperview];
    _cover = nil;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    MyLog(@"%@", request.URL);
    return YES;
}



@end
