//
//  RatingView.h
//  ArtGround
//
//  Created by Kunal Gupta on 23/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFloatRatingView.h"
#import "UserProfileModel.h"
#import "SpinnerView.h"


@interface RatingView : UIView < TPFloatRatingViewDelegate>

-(id)initWithFrame:(CGRect)frame;

- (IBAction)actionBtnCancel:(id)sender;
- (IBAction)actionBtnRate:(id)sender;

@property NSString *rating;

@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet TPFloatRatingView *ratingView;

@end
