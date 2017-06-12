//
//  HomeVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "HomeCategoryDetails.h"
#import "SpinnerView.h"
#import "UserInfo.h"
#import <UIImageView+WebCache.h>
#import "BaseVC.h"


static dispatch_once_t once;

@interface HomeVC : BaseVC <UITableViewDataSource , UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableViewHome;
@property (strong, nonatomic) IBOutlet UILabel *labelAlert;
@property SpinnerView *spinner;
@property NSString *userID;
@property NSString *catID;
@property NSString *accessToken;
@property NSString *catName;
@property NSString *image;

@property NSMutableArray *arrImages;
@property NSMutableArray *arrText;
@property NSMutableArray *arrTableData;

@end
