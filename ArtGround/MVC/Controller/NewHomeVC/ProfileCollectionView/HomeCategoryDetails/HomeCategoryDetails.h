//
//  HomeCategoryDetails.h
//  ArtGround
//
//  Created by Kunal Gupta on 06/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "HomeModel.h"
#import "HomeCategoryCollectionViewCell.h"
#import "SingleItemCategoryDetail.h"
#import "SpinnerView.h"
#import "BaseVC.h"
#import <UIImageView+WebCache.h>

@interface HomeCategoryDetails : BaseVC <UISearchBarDelegate , UICollectionViewDataSource , UICollectionViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>


-(void)getCatID: (NSString *)catName : (NSString *)ID;
@property (strong, nonatomic) IBOutlet UILabel *labelAlert;

@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarBetaX;
@property (strong, nonatomic) IBOutlet UILabel *labelCategoryName;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewPosts;
@property NSString *userID;
@property NSString *catID;
@property NSString *catName;
@property NSString *accessToken;
@property NSMutableArray *arrTableData;
@property NSMutableArray *arrTableDataAll;
@property SpinnerView *spinner;


@end
