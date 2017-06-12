//
//  HomeCategoryCollectionViewCell.m
//  ArtGround
//
//  Created by Kunal Gupta on 06/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "HomeCategoryCollectionViewCell.h"

@implementation HomeCategoryCollectionViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    _labelName.textColor = klightGray;
    _labelPrice.textColor = kAppColor;
    _labelTitle.textColor = klightGray;
    _viewContent.layer.cornerRadius = 4.0;
    self.layer.cornerRadius = 4.0;
    self.imageViewPost.layer.cornerRadius = 4.0;
    
    
//    [self setClipsToBounds:YES];
    [self.viewContent setClipsToBounds:YES];
    [self.imageViewPost setClipsToBounds:YES];
    
}
@end
