//
//  NewHomeVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"
#import "ProfileCollectionCell.h"
#import "EditProfileVC.h"
#import "UserProfileModel.h"
#import "BaseVC.h"
#import "SpinnerView.h"
#import "LoginRegisterationModel.h"
#import "HomeModel.h"
#import "SingleItemCategoryDetail.h"
#import <UIImageView+WebCache.h>
#import "PostActivityModel.h"
#import "BaseVC.h"

static dispatch_once_t once;

@interface ProfileHomeVC : BaseVC <UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIAlertViewDelegate >

@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *labelAboutMe;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelCountry;
@property (weak, nonatomic) IBOutlet UILabel *labelGender;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfile;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;


@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UILabel *labelAlert;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnEditProfileHeightConstraint;

@property NSMutableDictionary *dictUser;
@property UIImage *placeHolderImage;
@property NSMutableArray *arrTableData;
@property NSString *accessToken;
@property NSString *userID;
@property NSString *strDeleteArt;
@property NSString *strProfilePic;
@property NSMutableArray *arrImages;
@property NSInteger totalPosts;
@property NSString *strPathFrom;
@property HomeModel *hm;
@property NSString *strPaintingForID;
@property NSMutableDictionary *dictArtist;
-(void)pathFrm :(NSString *)path;
-(void)getArtistDetails:(NSMutableDictionary *)dict;
- (IBAction)actionBtnLogout:(id)sender;

- (IBAction)actionBtnEditProfile:(id)sender;
- (IBAction)actionBtnBack:(id)sender;

@end
