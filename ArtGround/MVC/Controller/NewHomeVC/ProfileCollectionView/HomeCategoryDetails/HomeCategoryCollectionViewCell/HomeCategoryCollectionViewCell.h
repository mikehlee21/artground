//
//  HomeCategoryCollectionViewCell.h
//  ArtGround
//
//  Created by Kunal Gupta on 06/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "HomeModel.h"
#import "PostActivityModel.h"

@interface HomeCategoryCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPost;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property HomeModel *hm;
- (IBAction)onFavorite:(id)sender;

@end
