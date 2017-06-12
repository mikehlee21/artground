//
//  RedditVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 03/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "HomeModel.h"
#import <UIImageView+WebCache.h>
#import "RedditModel.h"
#import "SpinnerView.h"
#import "BaseVC.h"
#import "JSON.h"
#import <RKClient+Captcha.h>
#import <SBJson4Writer.h>

@interface RedditVC : BaseVC <UITextFieldDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate, UIAlertViewDelegate>

-(void)getModel:(HomeModel*)home;
@property HomeModel *hm;
@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property NSString  *keyBoardHeight;
@property NSString *iden;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPost;
@property (strong, nonatomic) IBOutlet UILabel *labelPost;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewCaptcha;
@property (strong, nonatomic) IBOutlet UITextField *tfCaptcha;
@property NSMutableData *webData;
@property SpinnerView *spinner;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewheightConstraint;
- (IBAction)actionBTnBack:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
- (IBAction)actionBtnShare:(id)sender;

@property NSMutableData *responseData;




@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;


@end
