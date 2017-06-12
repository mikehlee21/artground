//
//  TermsAndConditionsVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 19/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"


@interface TermsAndConditionsVC : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)actionBtnBack:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *textviewTC;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
