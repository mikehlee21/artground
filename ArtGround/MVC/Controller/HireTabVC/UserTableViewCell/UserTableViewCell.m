//
//  UserTableViewCell.m
//  ArtGround
//
//  Created by Kunal Gupta on 18/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self initialize];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initialize{
    _viewImage.backgroundColor = [UIColor whiteColor];
    _imageViewProfilePic.layer.cornerRadius = _imageViewProfilePic.frame.size.width/2;
    [_imageViewProfilePic setClipsToBounds:YES];
    
    _viewImage.layer.cornerRadius = _viewImage.frame.size.width/2;
    [_viewImage setClipsToBounds:YES];
    _viewImage.layer.borderColor = [[UIColor colorWithRed:176/255.f green:177/255.f blue:178/255.f alpha:1]CGColor];
    _viewImage.layer.borderWidth = 2.0;
    _btnTag1.layer.borderWidth = 2.0;
    _btnTag2.layer.borderWidth = 2.0;
    _btnTag3.layer.borderWidth = 2.0;
    _btnTag1.layer.borderColor = [[UIColor colorWithRed:186/255.f green:187/255.f blue:188/255.f alpha:1]CGColor];
    _btnTag2.layer.borderColor = [[UIColor colorWithRed:186/255.f green:187/255.f blue:188/255.f alpha:1]CGColor];
    _btnTag3.layer.borderColor = [[UIColor colorWithRed:186/255.f green:187/255.f blue:188/255.f alpha:1]CGColor];

    
}
@end
