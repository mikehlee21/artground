//
//  LoginVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
#import "CountryVC.h"
#import "Macro.h"
#import "LoginRegisterationModel.h"
#import "TabBarControllerVC.h"
#import "SpinnerView.h"
#import "TermsAndConditionsVC.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface SignUpVC : BaseVC <CountryDelegate , UITextFieldDelegate, UIActionSheetDelegate >
@property (strong, nonatomic) IBOutlet UIView *viewTop;
- (IBAction)actionBtnIAgree:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnGender;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewEmail;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPassword;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewConfirmPassword;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewName;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewCountry;

@property (weak, nonatomic) IBOutlet UIButton *btnAgree;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewGender;


- (IBAction)actionBtnAgree:(id)sender;

@property NSString *strName;
@property NSString *strEmail;
@property NSString *strPassword;
@property NSString *strConfirmPassword;
@property NSString *strCountry;
@property NSString *alertMessage;
@property NSString *strIPAddress;
@property NSMutableDictionary *dictAPI;

@property NSMutableArray *arrCountry;

@property CGFloat keyBoardHeight;


- (IBAction)actionBtnBack:(id)sender;
- (IBAction)actionBtnT:(id)sender;
- (IBAction)actionBtnCountry:(id)sender;
- (IBAction)actionBtnGender:(id)sender;
- (IBAction)actionBtnSignUp:(id)sender;

@end
