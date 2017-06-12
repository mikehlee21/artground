//
//  GetRatingImages.m
//  ArtGround
//
//  Created by Kunal Gupta on 19/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "GetRatingImages.h"

#define FullStar_image @"ic_star_red"
#define HalfStar_image @"ic_star_half"
#define EmptyStar_image @"ic_star_black"


@implementation GetRatingImages
-(id)initWithAttributes:(float)rating{
    if (self=[super init]) {
        self.ratingImg1=EmptyStar_image;
        self.ratingImg2=EmptyStar_image;
        self.ratingImg3=EmptyStar_image;
        self.ratingImg4=EmptyStar_image;
        self.ratingImg5=EmptyStar_image;
        if (rating>=1) {
            self.ratingImg1=FullStar_image;
        }
        else if(rating>=0.5) {
            self.ratingImg1=HalfStar_image;
        }
        
        if (rating>=2) {
            self.ratingImg2=FullStar_image;
        }
        else if(rating>=1.5) {
            self.ratingImg2=HalfStar_image;
            
        }
        if (rating>=3) {
            self.ratingImg3=FullStar_image;
        }
        else if(rating>=2.5) {
            self.ratingImg3=HalfStar_image;
        }
        
        if (rating>=4) {
            self.ratingImg4=FullStar_image;
        }
        else if(rating>=3.5) {
            self.ratingImg4=HalfStar_image;
        }
        if (rating>=5) {
            self.ratingImg5=FullStar_image;
        }
        else if(rating>=4.5) {
            self.ratingImg5=HalfStar_image;
        }
        
    }
    return self;
}
+(GetRatingImages*)getRatingImagesWithRating:(float)rating{
    GetRatingImages *ratingModel=[[GetRatingImages alloc]initWithAttributes:rating];
    return ratingModel;
}
@end
