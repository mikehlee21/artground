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
    _labelPrice.textColor = kSelColor;
    _labelTitle.textColor = klightGray;
    _labelDate.textColor = ksuperLightGray;
    _viewContent.layer.cornerRadius = 4.0;
    self.layer.cornerRadius = 4.0;
    self.imageViewPost.layer.cornerRadius = 4.0;
    
    
//    [self setClipsToBounds:YES];
    [self.viewContent setClipsToBounds:YES];
    [self.imageViewPost setClipsToBounds:YES];
    
}
- (IBAction)onFavorite:(id)sender {
    [UIView animateWithDuration:0.3/1.5 animations:^{
        _btnFavorite.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/1.5 animations:^{
            _btnFavorite.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/1.5 animations:^{
                _btnFavorite.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
    
    if ([_btnFavorite isSelected] == YES) {
        _btnFavorite.selected = NO;
        [self removeFavorite];
    }
    else {
        _btnFavorite.selected = YES;
        [self addFavorite];
    }
}

-(void)addFavorite{
    NSString *userID = UserID;
    [_btnFavorite setSelected:YES];
    _hm.isFavorite = @"1";
    NSString *accessToken = TOKEN;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
    PostActivityModel *model = [[PostActivityModel alloc]init];
    [model addFavorite:userID :_hm.strArtID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
    }];
}
-(void)removeFavorite{
    NSString *userID = UserID;
    [_btnFavorite setSelected:NO];
    _hm.isFavorite = @"0";
    PostActivityModel *model = [[PostActivityModel alloc]init];
    NSString *accessToken = TOKEN;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
    [model removeFavorite: userID:_hm.strArtID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
    }];
}

@end
