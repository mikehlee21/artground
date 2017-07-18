//
//  SingleItemCategoryDetail.h
//  ArtGround
//
//  Created by Kunal Gupta on 07/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "PostActivityModel.h"
#import "BaseVC.h"
#import <UIImageView+WebCache.h>
#import <FBSDKLoginKit.h>
#import <FBSDKCoreKit.h>
#import <FBSDKShareKit.h>
#import "SpinnerView.h"
#import "ChatVC.h"
#import "UserProfileVC.h"
#import "UpdateArtVC.h"
#import "SellTabVC.h"
#import "Reddit.h"
#import "FaceBookShareXib.h"
#import "Macro.h"
#import "RedditVC.h"
#import <RKClient+Apps.h>
#import <RKClient.h>
#import "SellTabVC.h"
#import "SpinnerView.h"
#import <Social/Social.h>
#import "AMAttributedHighlightLabel.h"

@interface SingleItemCategoryDetail :BaseVC <  UIGestureRecognizerDelegate, UIActionSheetDelegate, UIAlertViewDelegate , AMAttributedHighlightLabelDelegate>

-(void)getModel:(HomeModel *)model;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *editButtonWithConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UIView *viewProfilePic;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPost;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelCountry;
//@property (strong, nonatomic) IBOutlet UILabel *labelInfo;

@property (weak, nonatomic) IBOutlet AMAttributedHighlightLabel *labelInfo;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePic;
@property (strong, nonatomic) IBOutlet UIButton *btnEdit;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePic2;
@property (strong, nonatomic) IBOutlet UIView *viewProfilePic2;
@property (weak, nonatomic) IBOutlet UIButton *btnContact;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelFavorite;
@property (weak, nonatomic) IBOutlet UIImageView *imgFavorite;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;

@property SpinnerView *spinner;
@property NSString *userID;
@property NSMutableDictionary *dictArtist;
@property NSString *accessToken;
@property NSMutableDictionary *dictFav;
@property NSString *fbShareText;
@property UITapGestureRecognizer *tapGesure;
@property UITapGestureRecognizer *labelTapGesure;
@property UITapGestureRecognizer *imageTapGesture;
@property BOOL hitBlockUserAPI;
- (IBAction)actionBtnFavorite:(id)sender;
- (IBAction)actionBtnback:(id)sender;
- (IBAction)actionBtnShareViaReddit:(id)sender;
- (IBAction)actionBtnShareViaFacebook:(id)sender;
- (IBAction)actionBtnContactSeller:(id)sender;
- (IBAction)actionBtnEdit:(id)sender;
- (IBAction)actionLblInfo:(id)sender;
@property NSMutableDictionary *dictAPI;


@property HomeModel *hm;
@end
