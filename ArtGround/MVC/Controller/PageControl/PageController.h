//
//  PageController.h
//  ArtGround
//
//  Created by Kunal Gupta on 11/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

@interface PageController : UIViewController < UICollectionViewDataSource , UICollectionViewDelegate, UIScrollViewDelegate >

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewPage;
@property NSTimer *timer;
@property NSInteger index;
@property NSMutableArray *arrImages;
@end
