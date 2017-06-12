//
//  UserPaintingsVCViewController.h
//  ArtGround
//
//  Created by Kunal Gupta on 25/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserPaintingsCollectionViewHeader.h"
#import "SingleItemCategoryDetail.h"
#import "SpinnerView.h"
#import "SearchModel.h"
#import "UserProfileModel.h"
#import "ProfileCollectionCell.h"
#import "Macro.h"


@interface UserPaintingsVC : UIViewController <UICollectionViewDataSource , UICollectionViewDelegate>

@property NSMutableArray *arrTableData;
@property SpinnerView *spinner;
@property SearchModel *sm;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)actionBtnBack:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewTop;


@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

-(void)getModel:(SearchModel *)model;

@end
