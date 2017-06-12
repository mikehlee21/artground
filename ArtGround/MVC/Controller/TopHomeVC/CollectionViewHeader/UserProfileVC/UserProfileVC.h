//
//  UserProfileVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 21/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"
#import "GetRatingImages.h"
#import <VENTokenField.h>
#import <JCTagListView.h>
#import <UIImageView+WebCache.h>
#import "RatingView.h"
#import "Macro.h"
#import "BaseVC.h"
#import "Macro.h"
#import "TagsView.h"
#import "AboutMeDetails.h"
#import "UserProfileModel.h"
#import "UserPaintingsVC.h"
#import "ChatVC.h"
#import "SpinnerView.h"
#import "CategoryTableVC.h"
#import "UserInfo.h"
#import "ProfileHomeVC.h"

@interface UserProfileVC : BaseVC <UIImagePickerControllerDelegate , UINavigationControllerDelegate, UIActionSheetDelegate, TagDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintTags;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewCoverPic;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintSpecialization;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightContraintMedia;
@property (strong, nonatomic) IBOutlet UILabel *labelGender;
@property (strong, nonatomic) IBOutlet UILabel *labelCountry;
@property (strong, nonatomic) IBOutlet UIView *viewImage;


@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePic;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewStar1;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewStar2;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewStar3;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewStar4;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewStar5;

@property (strong, nonatomic) IBOutlet JCTagListView *tagListSpecialization;
@property (strong, nonatomic) IBOutlet JCTagListView *tagListTags;
@property (nonatomic, weak) IBOutlet JCTagListView *tagListMedia;

@property (strong, nonatomic) IBOutlet UILabel *labelAboutMe;
@property (strong, nonatomic) IBOutlet UILabel *labelTopName;

- (IBAction)actionBtnEditCoverPic:(id)sender;
- (IBAction)actionBtnEditAboutMe:(id)sender;
- (IBAction)actionBtnEditMedia:(id)sender;
- (IBAction)actionBtnEditSpecialization:(id)sender;
- (IBAction)actionBtnEditTags:(id)sender;
- (IBAction)actionBtnSave:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnEditCoverPic;
@property (strong, nonatomic) IBOutlet UIButton *btnAboutMe;
@property (strong, nonatomic) IBOutlet UIButton *btnEditMedia;
@property (strong, nonatomic) IBOutlet UIButton *btnEditSpecialization;
@property (strong, nonatomic) IBOutlet UIButton *btnEditTags;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;


@property (strong, nonatomic) IBOutlet UIButton *btnRate;
@property (strong, nonatomic) IBOutlet UIButton *btnChat;
@property (strong, nonatomic) IBOutlet UILabel *labelNoAboutMe;

@property (strong, nonatomic) NSMutableArray *names;

@property SearchModel *sm;
@property NSMutableArray *arrMedia;
@property NSMutableArray *arrSpecialization;
@property NSMutableArray *arrTags;
@property NSString *strRating;
@property NSString *strAboutMe;
@property UIImage *imageCoverImage;
@property NSString *artistID;
@property NSMutableArray *arrDefaultMedia;
@property NSString *strCoverPic;
@property BOOL coverPicSet;
@property  NSData *coverPicData;
@property NSMutableDictionary *dictArtist;
@property NSString *userID;


- (IBAction)actionBtnBack:(id)sender;
- (IBAction)actionBtnRate:(id)sender;
- (IBAction)actionBtnChat:(id)sender;
- (IBAction)actionBtnHome:(id)sender;

-(void)getUserID :(NSString *)userID;
-(void)getModel:(SearchModel *)model;


@end
