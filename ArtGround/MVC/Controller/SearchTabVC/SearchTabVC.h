//
//  SearchTabVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "SearchModel.h"
#import "HomeModel.h"
#import "SearchArtCollectionViewCell.h"
#import "HomeCategoryCollectionViewCell.h"
#import "SingleItemCategoryDetail.h"
#import "SpinnerView.h"

@interface SearchTabVC : BaseVC <UISearchBarDelegate , UICollectionViewDataSource , UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UILabel *labelAlert;
@property NSMutableArray *arrTableData;
@property NSMutableDictionary *dictSearch;
@property SpinnerView *spinner;


@end
