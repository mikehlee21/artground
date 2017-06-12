//
//  CollectionViewHeader.h
//  ArtGround
//
//  Created by Kunal Gupta on 20/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewHeaderCell.h"
#import <UIImageView+WebCache.h>
#import "HomeModel.h"
#import "SingleItemCategoryDetail.h"

@interface CollectionViewHeader : UICollectionReusableView <UIGestureRecognizerDelegate, UICollectionViewDataSource , UICollectionViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UILabel *labelArtName;
@property (strong, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewHeader;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPost;

@property NSArray *arrCollectionViewPosts;
@property (nonatomic) CGFloat lastContentOffset;
@property NSTimer *timer;
@property NSInteger index;
@property HomeModel *hm;
@property NSString *scrollDirection;
@property NSInteger totalPages;
@end
