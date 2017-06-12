//
//  SearchArtCollectionViewCell.h
//  ArtGround
//
//  Created by Kunal Gupta on 16/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

@interface SearchArtCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPost;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UIView *viewContent;

@end
