//
//  HomeCategoryModel.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"

@interface HomeModel : NSObject

@property NSString *strCatID;
@property NSString *strCatName;
@property NSString *strImage;
@property NSString *strArtistID;
@property NSString *strArtistName;
@property NSString *strArtistCountry;
@property NSString *strArtistProfilePic;
@property NSString *strCategoryID;
@property NSString *strDescription;
@property NSString *strArtID;
@property NSString *strPostImage;
@property NSString *strRating;
@property NSString *strTitle;
@property NSString *strUserID;
@property NSString *strPrice;
@property NSString *isFavorite;
@property NSString *strArtistGender;
@property NSString *strArtistAbout;


- (void)homeDetail:(NSString *)userID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)categoryDetail:(NSString *)userID :(NSString *) catID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)categorySearch:(NSString *)userID :(NSString *) catID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)topPosts:(NSString *)userID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+ (NSArray*)parseFeedToArray:(NSArray*)array;
+ (NSArray*)parseDataToArray:(NSArray*)array;

-(HomeModel *)initWithAttribute:(NSDictionary*)attributes;

@end
