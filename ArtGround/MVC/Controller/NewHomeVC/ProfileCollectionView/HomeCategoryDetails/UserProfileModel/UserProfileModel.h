//
//  UserProfileModel.h
//  ArtGround
//
//  Created by Kunal Gupta on 06/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"


@interface UserProfileModel : NSObject

@property NSString *strPostID;
@property NSString *strImage;
@property NSString *strIsFavorite;
@property NSString *strPrice;
@property NSString *strTitle;

- (void)userDetails:(NSString *)userID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void) updateProfileWithPic:(NSString *)userID : (NSDictionary *)parameters :(NSData *) data : (BOOL)isImage :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void) updateProfile:(NSString *)userID : (NSDictionary *)parameters :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;


- (void) updateCoverProfileWithPic:(NSString *)userID : (NSDictionary *)parameters :(NSData *) data : (BOOL)isImage :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void) updateCoverProfile:(NSString *)userID : (NSDictionary *)parameters :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void) userRateOther:(NSString *)userID :(NSString *)artistID : (NSDictionary *)parameters :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

-(void)userViewOtherUserArts:(NSString *)userID :(NSString *)artistID : (NSDictionary *)parameters :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;




@end
