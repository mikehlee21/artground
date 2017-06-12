//
//  ChatModel.h
//  ArtGround
//
//  Created by Kunal Gupta on 26/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iOSRequest.h"
#import "Macro.h"


@interface ChatModel : NSObject



@property NSString *strmessageID;
@property NSString *strMessage;
@property NSString *strIsread;
@property NSString *strCreatedAt;
@property NSString *strSendBy;
@property NSString *strSendTo;
@property NSString *strBlocked;


@property NSString *strDate;
@property NSString *strTime;
@property NSString *strUnread;
@property NSString *message;
@property NSString *strName;
@property NSString *strProfilePic;
@property NSString *strArtistID;
@property NSString *strMedia;
@property UIImage *imageMessage;


- (void)getAllMessages:(NSString *)userID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)getNewMessage:(NSString *)userID :(NSString *) messageID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)deleteChat:(NSString *)userID :(NSString *) otherID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)viewSingleUserChat:(NSString *)userID :(NSString *) otherID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)sendMessage:(NSString *)userID :(NSString *) otherID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void) sendImageMessage:(NSString *)userID : (NSString*) otherID : (NSDictionary *)parameters :(NSData *) data : (BOOL)isImage :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)blockUser:(NSString *)userID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;


+ (NSArray*)parseDataToArray:(NSArray*)array;

+ (NSArray*)parseFeedToArray:(NSArray*)array;

@end
