//
//  HIreTabVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "Macro.h"
#import "SearchModel.h"
#import "UserTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "CountryVC.h"
#import "SpinnerView.h"
#import "GetRatingImages.h"
#import "UserProfileVC.h"
#import "UserPaintingsVC.h"



@interface HIreTabVC : BaseVC <UITableViewDataSource , UITableViewDelegate , UIActionSheetDelegate, CountryDelegate , UISearchBarDelegate >
@property (strong, nonatomic) IBOutlet UIView *viewHeading;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBarUser;
@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property (strong, nonatomic) IBOutlet UIButton *btnLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnCategory;
@property (strong, nonatomic) IBOutlet UIButton *btnRatings;
@property (strong, nonatomic) IBOutlet UIButton *btnProfile;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cellTopConstraint;

@property NSMutableArray *arrCountry;
@property NSString *strCountry;
@property NSString *catID;
@property UIActionSheet *actionRatings;
@property UIActionSheet *actionCategory;
@property NSMutableArray *arrCategory;
@property NSMutableArray *arrRatings;
@property NSMutableArray *arrTableData;
@property NSMutableDictionary *dictAPI;
@property SearchModel *myModel;

@property NSString *strCategory;
@property NSString *strRating;


- (IBAction)actionBtnLocation:(id)sender;
- (IBAction)actionBtnCategory:(id)sender;
- (IBAction)actionBtnRatings:(id)sender;
- (IBAction)actionBtnProfile:(id)sender;



@end
