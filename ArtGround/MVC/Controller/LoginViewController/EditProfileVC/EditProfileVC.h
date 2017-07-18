//
//  EditProfileVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 04/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "CountryVC.h"
#import "AboutMeDetails.h"
#import "BaseVC.h"
#import "Macro.h"
#import "UserProfileModel.h"
#import "SpinnerView.h"
#import "LoginRegisterationModel.h"
#import "AboutMeApp.h"
#import <UIImageView+WebCache.h>
#import "MessageTabVC.h"
#import <Google/SignIn.h>
#import <GIDGoogleUser.h>
#import "TabBarControllerVC.h"
#import "BlockedUserVC.h"
#import "TermsAndConditionsVC.h"

static dispatch_once_t once;

@interface EditProfileVC : BaseVC < UIActionSheetDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , CountryDelegate , UITextFieldDelegate>

-(void)getCountry:(NSString *)country;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProflePic;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UIView *viewProfilePic;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnGender;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfVerifyPwd;


@property NSMutableDictionary *dictAPI;
@property NSMutableDictionary *userDetails;
@property NSMutableArray *arrCountry;
@property NSString *strCountry;
@property NSString *strName;
@property NSString *strGender;
@property NSString *strAboutme;
@property NSString *strEmail;
@property NSString *userID;
@property NSString *accessToken;
@property NSString *strProfilePic;
@property UIImage *imgSelectedImage;
@property UIImage *placeholderImage;
@property  UIActionSheet *actionGender;
@property  UIActionSheet *actionCountry;
@property BOOL isProfilePicRemoved;
@property CGFloat keyBoardHeight;
@property BOOL profileChanged;
@property BOOL defaultPicSet;
@property SpinnerView *spinner;
@property NSString *updatedCountry;

@property NSData *profilePicData;


@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property NSString *strShowCancel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;


- (IBAction)actionBtnGender:(id)sender;
- (IBAction)actionBtnCountry:(id)sender;
- (IBAction)actionBtnBack:(id)sender;
- (IBAction)actionBtnSave:(id)sender;
- (IBAction)actionBtnEditDisplay:(id)sender;


@end
