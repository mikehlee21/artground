//
//  iOSRequest.h
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface iOSRequest : NSObject


+(void)getJSONResponse :(NSString *)urlStr : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure ;

+(void)getImageResponse :(NSString *)urlStr :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+(void)postMutipartRedditPost: (NSString *)urlStr :(NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+(void)postMutliPartData : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (NSData*) thumbnail : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+(void)postPic : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+(void)postArt : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+(void)updateArt : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+(void)postEmoticons : (NSString *)url parameters:(NSDictionary *)dparameters  success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure;

+(void)postData : (NSString *)urlStr : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;


+(void)postCoverPic : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+(void)postImageMessage : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+(void)loginWithImage : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

@end
