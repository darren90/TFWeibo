//
//  OAuthController.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/16.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "OAuthController.h"

@interface OAuthController ()<UIWebViewDelegate>

@end

@implementation OAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc]init];
    [self.view addSubview:webView];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",KWeiboAPPKey,KRedirectUri]];
    NSURLRequest *requet = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requet];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    [MBProgressHUD showMessage:@"Loading"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [MBProgressHUD hideHUD];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [MBProgressHUD hideHUD];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.location != NSNotFound) {
        NSLog(@"%@",url);
        int fromIndex = (int)(range.location +range.length);
        NSString *code = [url substringFromIndex:fromIndex];
        
        //利用code得到accessToken；
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}


-(void)accessTokenWithCode:(NSString *)code
{
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"client_id"] = KWeiboAPPKey;
    dict[@"client_secret"] = KWeiboAPPSecret;
    dict[@"grant_type"] = @"authorization_code";
    dict[@"code"] = code;
    dict[@"redirect_uri"] = KRedirectUri;
    //
    //    [mgr POST:url parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    //        [MBProgressHUD hideHUD];
    //
    //        Account *account = [Account accountWithDict:responseObject];
    //
    //        [AccountTool saveAccount:account];
    //
    //        [UIWindow switchRootViewVC];
    //
    //    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
    //        TFLog(@"faile---:%@",error);
    //        [MBProgressHUD hideHUD];
    //    }];
    [[Weibo_APIManager sharedManager] request_OAuth_WithParams:dict andBlock:^(id data, NSError *error) {
        NSLog(@"-succ-:%@-eror-:%@",data,error);
        Account *account = [Account accountWithDict:data];
        
        [AccountTool saveAccount:account];
        
        [UIWindow switchRootViewVC];

    }];
    
//    [[Coding_NetAPIManager sharedManager] request_Login_WithParams:[self.myLogin toParams] andBlock:^(id data, NSError *error) {
//        weakSelf.loginBtn.enabled = YES;
//        [weakSelf.activityIndicator stopAnimating];
//        if (data) {
//            [Login setPreUserEmail:self.myLogin.email];//记住登录账号
//            [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabViewController];
//        }else{
//            NSString *global_key = error.userInfo[@"msg"][@"two_factor_auth_code_not_empty"];
//            if (global_key.length > 0) {
//                [weakSelf changeUITo2FAWithGK:global_key];
//            }else{
//                [NSObject showError:error];
//                [weakSelf refreshCaptchaNeeded];
//            }
//        }
//    }];


    
}

@end
