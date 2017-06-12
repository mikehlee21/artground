//
//  TopHomeVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "SpinnerView.h"
#import "HomeModel.h"
#import "HomeCategoryCollectionViewCell.h"
#import "CollectionViewHeader.h"
#import "SingleItemCategoryDetail.h"
#import <UIImageView+WebCache.h>
#import "CollectionViewHeaderCell.h"

@interface TopHomeVC : UIViewController<UIGestureRecognizerDelegate,UICollectionViewDataSource , UICollectionViewDelegate >

@property (strong, nonatomic) IBOutlet UILabel *labelAlert;

@property SpinnerView *spinner;
@property UITapGestureRecognizer *tapGesture;
@property NSMutableArray *arrTableData;
@property NSArray *arrCollectionHeader;


@property (strong, nonatomic) IBOutlet UIImageView *imageViewTopPost;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewPost;

@property NSInteger topPages;

@property CollectionViewHeader *headerView;
@end
