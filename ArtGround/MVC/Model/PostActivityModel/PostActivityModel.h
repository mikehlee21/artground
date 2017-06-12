//
//  PostActivityModel.h
//  ArtGround
//
//  Created by Kunal Gupta on 09/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"

@interface PostActivityModel : NSObject

- (void)deleteArt:(NSString *)userID :(NSString *) artID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)updateArt:(NSString *)userID :(NSString *) artID :(NSData *)imageData :(BOOL) isImage :(NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)addFavorite:(NSString *)userID :(NSString *) artID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)removeFavorite:(NSString *)userID :(NSString *) artID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void) postArt:(NSString *)userID : (NSDictionary *)parameters :(NSData *) data : (BOOL)isImage :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;


@end
