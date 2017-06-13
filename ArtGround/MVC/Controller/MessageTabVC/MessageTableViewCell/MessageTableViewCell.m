//
//  MessageTableViewCell.m
//  ArtGround
//
//  Created by Kunal Gupta on 25/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [self initialise];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)initialise{
    _viewImage.layer.borderColor = [[UIColor colorWithRed:255/255.f green:0/255.f blue:90/255.f alpha:1] CGColor];
    _viewImage.layer.borderWidth = 2.0;
    
    [self layoutIfNeeded];
    
    _viewImage.layer.cornerRadius = _viewImage.frame.size.width/2;
    [_viewImage setClipsToBounds:YES];

    _imageViewProfilePIc.layer.cornerRadius = _imageViewProfilePIc.frame.size.width/2;
    [_imageViewProfilePIc setClipsToBounds:YES];

    _viewBadge.layer.cornerRadius = _viewBadge.frame.size.width/2;
    [_viewBadge setClipsToBounds:YES];
    

}
@end
