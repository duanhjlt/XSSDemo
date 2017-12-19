//
//  ViewController.m
//  XSSDemo
//
//  Created by duanhongjin on 19/12/2017.
//  Copyright © 2017 CrazyKids. All rights reserved.
//

#import "ViewController.h"
#import "NSData+Utils.h"

@interface ViewController () <UIWebViewDelegate>
{
  UIWebView* _webview;
  BOOL _loading;
}

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  _webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
  _webview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
  _webview.delegate = self;
  [self.view addSubview:_webview];
  
  _loading = YES;
  
  NSString* path = [[NSBundle mainBundle]pathForResource:@"filterxss" ofType:@"html"];
  NSURL* url = [NSURL URLWithString:path];
  [_webview loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  if (!_loading) return;

#if 1
  NSString* path = [[NSBundle mainBundle]pathForResource:@"a" ofType:@"html"];
  NSData* data = [NSData dataWithContentsOfFile:path];
#else
  NSString* hhhh = @"admin:admin";
  NSData* data = [hhhh dataUsingEncoding:NSUTF8StringEncoding];
#endif
  
  NSString* string = [data base64Encoding];
  NSString* jsString = [NSString stringWithFormat:@"XssToString('%@');", string];
  
  NSString* result = [_webview stringByEvaluatingJavaScriptFromString:jsString];
  _loading = NO;
  
  [_webview loadHTMLString:result baseURL:nil];
}

@end
