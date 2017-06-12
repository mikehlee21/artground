//
//  RatingView.m
//  ArtGround
//
//  Created by Kunal Gupta on 23/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "RatingView.h"

@implementation RatingView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"RatingView" owner:self options:nil] firstObject];
        [self setFrame:frame];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [self setupUI];
    //    [self.sidePanelTableView reloadData];
    
    return self;
}

- (IBAction)actionBtnCancel:(id)sender {
    [self setHidden:YES];
}

- (IBAction)actionBtnRate:(id)sender {
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:_rating,@"rating",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"rating" object:nil userInfo:dict];
    [self setHidden:YES];
}
-(void)setupUI{
    _viewContent.layer.cornerRadius = 4.0;
    
    self.ratingView.delegate = self;
    self.ratingView.emptySelectedImage = [UIImage imageNamed:@"ic_star_black"];
    self.ratingView.fullSelectedImage = [UIImage imageNamed:@"ic_star_red"];
    self.ratingView.contentMode = UIViewContentModeScaleAspectFill;
    self.ratingView.maxRating = 5;
    self.ratingView.minRating = 0;
    self.ratingView.rating = 2.5;
    _rating = [NSString stringWithFormat:@"2.5"];
    self.ratingView.editable = YES;
    self.ratingView.halfRatings = YES;
    self.ratingView.floatRatings = NO;
}
- (void)floatRatingView:(TPFloatRatingView *)ratingView ratingDidChange:(CGFloat)rating{
    _rating = [NSString stringWithFormat:@"%f",rating];
}

- (void)floatRatingView:(TPFloatRatingView *)ratingView continuousRating:(CGFloat)rating{
 
    _rating = [NSString stringWithFormat:@"%f",rating];
}

@end
