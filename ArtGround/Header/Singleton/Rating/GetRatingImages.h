//
//  GetRatingImages.h
//  ArtGround
//
//  Created by Kunal Gupta on 19/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetRatingImages : NSObject

@property(strong,nonatomic) NSString *ratingImg1;
@property(strong,nonatomic) NSString *ratingImg2;
@property(strong,nonatomic) NSString *ratingImg3;
@property(strong,nonatomic) NSString *ratingImg4;
@property(strong,nonatomic) NSString *ratingImg5;



+(GetRatingImages*)getRatingImagesWithRating:(float)rating;

@end
