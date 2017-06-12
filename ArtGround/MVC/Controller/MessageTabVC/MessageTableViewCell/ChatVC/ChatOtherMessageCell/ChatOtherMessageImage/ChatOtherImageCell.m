//
//  ChatOtherImageCell.m
//  ArtGround
//
//  Created by Kunal Gupta on 27/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "ChatOtherImageCell.h"

@implementation ChatOtherImageCell

- (void)awakeFromNib {
    
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedTableView:)];
    [_imageViewMessage addGestureRecognizer:_tapGesture];
    _viewDate.layer.cornerRadius = 4.0;
    [_viewDate setClipsToBounds:YES];
        _viewDate.backgroundColor = kAppColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)tappedTableView:(UITapGestureRecognizer*)gesture{
    
    ShowChatImage *show = [[ShowChatImage alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andStr:_strImage orImage:_imageMessage];
    show.center =  [[[[UIApplication sharedApplication] delegate] window] center];
    show.layer.borderWidth = 1.0;
    show.layer.cornerRadius = 8.0;
    //    [about setStr2:@"dcsjadjakshdfjasdhfjkashbdfjasbdhjkfasdbc dsahd sabusad fbsjf asj basjba jdkfbsakjdfbsakj fasjdf sajdf nasjfnasjfnasdjfnadsjfnasj dfdasjfasdhfj adsfnas'f"];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:show];
}

@end
