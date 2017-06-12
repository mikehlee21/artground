//
//  ProfileCollectionCell.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "ProfileCollectionCell.h"

@implementation ProfileCollectionCell
-(void)awakeFromNib{
    [super awakeFromNib];
    [self.btnDelete addTarget:self action:@selector(deleteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}
- (IBAction)actionBtnDelete:(id)sender {

    
}
-(void)deleteButtonPressed{
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:_postID,@"post_id", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"get_art_id" object:nil userInfo:dict];
}

@end
