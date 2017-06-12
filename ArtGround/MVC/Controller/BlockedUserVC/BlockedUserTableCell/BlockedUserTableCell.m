//
//  BlockedUserTableCell.m
//  ArtGround
//
//  Created by Kunal Gupta on 30/03/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

#import "BlockedUserTableCell.h"

@implementation BlockedUserTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configureCell:(BlockedUserModel *)model{
    
    _labelName.text = model.strName;
    [_imageViewProfilePic sd_setImageWithURL:[NSURL URLWithString:model.strProfilePic] placeholderImage:kDefaultPic];
    [_imageViewProfilePic.layer setCornerRadius:_imageViewProfilePic.frame.size.height/2];
    [_imageViewProfilePic setClipsToBounds:YES];
    
}

- (IBAction)actionBtnUnblock:(id)sender {
    [self.delegate unblockUser:_index];
}

@end
