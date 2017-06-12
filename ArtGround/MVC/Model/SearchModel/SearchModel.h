//
//  SearchModel.h
//  ArtGround
//
//  Created by Kunal Gupta on 16/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"
#import "iOSRequest.h"

/*
 art_catid" = 1;
 "art_catname" = Expressions;
 "art_id" = 16;
 "art_image" = "4_13e1e1e72708720kcgsDGqIWv.jpg";
 "art_price" = 100;
 "art_rating" = 0;
 "artist_id" = 4;
 blocked = 0;
 "cat_blocked" = 0;
 deleted = 0;
 description = hello;
 title = asdfmnbv;
 */

@interface SearchModel : NSObject

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


@property NSString *strArtCount;
@property NSString *strCountry;
@property NSString *strDateOfBirth;
@property NSString *strEmail;
@property NSString *strGender;
@property NSString *strID;
@property NSString *strProfilePic;
@property NSString *strMediaCount;
@property NSString *strName;
@property NSString *strUserRating;
@property NSString *strSpecialityCount;
@property NSString *strTagCount;
@property NSString *strAboutMe;
@property NSString *strCoverPic;
@property NSMutableArray *arrSpeciality;
@property NSMutableArray *arrMedia;
@property NSMutableArray *arrTags;


- (void)getUserDetails:(NSString *)userID :(NSString *)artistID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)searchArt:(NSString *)userID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)searchArtInCategory:(NSString *)userID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)searchArtist:(NSString *)userID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+ (NSArray*)parseFeedToArray:(NSArray*)array;
+ (NSArray*)parseDataToArray:(NSArray*)array;

-(SearchModel *)initWithAttributes:(NSDictionary*)attributes;
@end
