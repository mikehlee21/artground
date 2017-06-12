//
//  TableViewPostCEll.m
//  SketchApp
//
//  Created by Kunal Gupta on 04/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "TableViewPostCEll.h"

@implementation TableViewPostCEll

- (void)awakeFromNib {
    [_btnLike addTarget:self action:@selector(likeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:UD_Token];
    [self addGesture];
    CGFloat insetAmount = 8 / 2.0;
    _btnLike.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
    _btnLike.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
    _btnLike.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
    
    _btnComment.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
    _btnComment.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
    _btnComment.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


    // Configure the view for the selected state
}
-(void)addGesture{
    
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textTapped:)];
    [self.labelName addGestureRecognizer:_tapGesture];
}

- (void)textTapped:(UITapGestureRecognizer *)recognizer{
    
    NSLog(@"%@ 's user ID is %@",_strUsername, _strUserID);
    if([_strUserID integerValue] != 0){
        [self pushToUserInfo];
    }
}

-(void)pushToUserInfo{
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:_strUserID,@"userID", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"push_To_user_Info" object:nil userInfo:dict];
}

-(void)likeButtonPressed{
    
    if(_btnLike.isSelected){
       
        [self unLikePostAPI];
    }
    else{
        [self likePostAPI];
        
    }
}

-(void)likePostAPI{
    LikeModel *like = [[LikeModel alloc]init];
    _dictParams = [[NSMutableDictionary alloc]init];
    [_dictParams setValue:_accessToken forKey:@"access_token"];
    
    NSString *str = @"liked";
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:str,@"str", nil];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:N_RELOAD_TABLE object:nil userInfo:dict];
    [like likePost:_postID :_dictParams :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"get_user_comments" object:nil userInfo:dict];
        [_btnLike setSelected:YES];
         [_btnLike setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btnLike setTitle:[response_success valueForKey:@"like_count"] forState:UIControlStateNormal];
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
    }];
}

-(void)unLikePostAPI{
    LikeModel *like = [[LikeModel alloc]init];
    _dictParams = [[NSMutableDictionary alloc]init];
    [_dictParams setValue:_accessToken forKey:@"access_token"];
    
    NSString *str = @"unliked";
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:str,@"str", nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:N_RELOAD_TABLE object:nil userInfo:dict];
    [like unlikePost:_postID :_dictParams :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"get_user_comments" object:nil userInfo:dict];
         [_btnLike setSelected:NO];
         [_btnLike setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_btnLike setTitle:[response_success valueForKey:@"like_count"] forState:UIControlStateNormal];
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
    }];
}
@end
