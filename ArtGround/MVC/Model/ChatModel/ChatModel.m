//
//  ChatModel.m
//  ArtGround
//
//  Created by Kunal Gupta on 26/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel

- (void)deleteChat:(NSString *)userID :(NSString *) otherID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:DELETE_CHAT,BASE_URL,userID,otherID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}

- (void) sendImageMessage:(NSString *)userID : (NSString*) otherID : (NSDictionary *)parameters :(NSData *) data : (BOOL)isImage :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postImageMessage:[NSString stringWithFormat:SEND_MESSAGE_TO_SINGLE_USER,BASE_URL,userID,otherID] :parameters :isImage :data :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
    
}

- (void)getAllMessages:(NSString *)userID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:GET_ALL_MESSAGES,BASE_URL,userID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
    
}

- (void)sendMessage:(NSString *)userID :(NSString *) otherID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:SEND_MESSAGE_TO_SINGLE_USER,BASE_URL,userID,otherID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
    
}

- (void)getNewMessage:(NSString *)userID :(NSString *) messageID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    [iOSRequest postData:[NSString stringWithFormat:GET_NEW_MESSAGES,BASE_URL,userID,messageID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}

- (void)viewSingleUserChat:(NSString *)userID :(NSString *) otherID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{

    [iOSRequest postData:[NSString stringWithFormat:VIEW_SINGLE_CHAT,BASE_URL,userID,otherID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
    
}
- (void)blockUser:(NSString *)userID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
   
    [iOSRequest postData:[NSString stringWithFormat:BLOCK_OTHER_USER,BASE_URL,userID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}

// For ChatVC
+ (NSArray*)parseDataToArray:(NSArray*)array{
    
    NSMutableArray * arr = [NSMutableArray new];
    
    for (NSDictionary * dict  in array){
        
        ChatModel * fm = [[ChatModel alloc]initWithAttributes:dict];
        
        [arr addObject:fm];
    }
    return arr;
}

-(ChatModel *)initWithAttributes:(NSDictionary*)attributes{
    
    ChatModel * fm = [[ChatModel alloc]init];
    
    fm.strmessageID = [attributes objectForKey:@"id"];
    fm.strSendBy = [attributes objectForKey:@"sent_by"];
    fm.strSendTo = [attributes objectForKey:@"sent_to"];
    fm.strMessage = [attributes objectForKey:@"message"];
    fm.strCreatedAt = [attributes objectForKey:@"created_at"];
    fm.strIsread = [attributes objectForKey:@"is_read"];
    fm.strDate = [attributes objectForKey:@"date"];
    fm.strTime = [attributes objectForKey:@"time"];
    fm.strMedia = [attributes objectForKey:@"media"];
    fm.imageMessage = nil;
    
    return fm;
}

// For messageTAbVC
+ (NSArray*)parseFeedToArray:(NSArray*)array{
    
    NSMutableArray * arr = [NSMutableArray new];
    
    for (NSDictionary * dict  in array){
        
        ChatModel * fm = [[ChatModel alloc]initWithAttribute:dict];
        
        [arr addObject:fm];
    }
    
    return arr;
}

-(ChatModel *)initWithAttribute:(NSDictionary*)attribute{
    
    ChatModel * fm = [[ChatModel alloc]init];
    
    fm.message = [attribute objectForKey:@"message"];
//    fm.strTime = [attribute objectForKey:@"created_at"];
    fm.strProfilePic = [attribute objectForKey:@"profile_pic"];
    fm.strName = [attribute objectForKey:@"name"];
    fm.strUnread = [attribute objectForKey:@"unread_count"];
    fm.strArtistID = [attribute objectForKey:@"id"];
    fm.strTime = [attribute objectForKey:@"time"];
    fm.strBlocked = attribute[@"blocked"];
    return fm;
}

@end
