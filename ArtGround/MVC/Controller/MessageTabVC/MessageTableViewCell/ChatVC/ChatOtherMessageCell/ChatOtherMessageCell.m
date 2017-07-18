//
//  ChatOtherMessageCell.m
//  ArtGround
//
//  Created by Kunal Gupta on 26/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "ChatOtherMessageCell.h"

@implementation ChatOtherMessageCell

- (void)awakeFromNib {
    //_viewDate.layer.cornerRadius = 4.0;
    //[_viewDate setClipsToBounds:YES];
    //_viewDate.backgroundColor = kAppColor;
    _imgOpponent.layer.cornerRadius = _imgOpponent.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
