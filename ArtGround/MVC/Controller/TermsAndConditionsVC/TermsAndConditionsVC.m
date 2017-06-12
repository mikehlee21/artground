//
//  TermsAndConditionsVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 19/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "TermsAndConditionsVC.h"

@interface TermsAndConditionsVC ()

@end

@implementation TermsAndConditionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialise];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialise{
    _viewTop.backgroundColor = kAppColor;
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:PRIVACY_POLICY_URL]]];
    _webView.scalesPageToFit = YES;
}

#pragma mark - WEBVIEW DELEGATES

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_spinner stopAnimating];
    [_spinner setHidesWhenStopped:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_spinner startAnimating];
    [_spinner setHidesWhenStopped:YES];
}

#pragma mark - ACTION BUTTONS

- (IBAction)actionBtnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
