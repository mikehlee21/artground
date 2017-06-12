//
//  LoginVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "BaseVC.h"
#import "SignUpVC.h"
#import "EditProfileVC.h"
#import "TabBarControllerVC.h"
#import "HomeTabVC.h"
#import "SpinnerView.h"
#import "LoginRegisterationModel.h"
#import <RTAlertView.h>
#import <FBSDKLoginKit.h>
#import <FBSDKCoreKit.h>
#import <Google/SignIn.h>
#import <GIDGoogleUser.h>


@interface LoginVC : BaseVC <UITextFieldDelegate , GIDSignInUIDelegate, UIAlertViewDelegate >

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewEmail;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPassword;
@property (strong, nonatomic) IBOutlet UIView *viewTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;

@property SpinnerView *spinner;
@property CGFloat keyBoardHeight;
@property NSString *strEmail;
@property NSString *strPassword;
@property NSString *alertMessage;
@property NSString *FBUsername;
@property NSString *FBGender;
@property NSString *faceBookID;
@property BOOL shareOnFacebook;
@property NSString *forgotEmail;
@property FBSDKLoginManager *login;


- (IBAction)actionBtnForgotPassword:(id)sender;
- (IBAction)actionBtnSignin:(id)sender;
- (IBAction)actionBtnSignUp:(id)sender;
- (IBAction)actionBtnFbLogin:(id)sender;
- (IBAction)actionBtnGmailLogin:(id)sender;

@end
