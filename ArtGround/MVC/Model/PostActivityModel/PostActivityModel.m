//
//  PostActivityModel.m
//  ArtGround
//
//  Created by Kunal Gupta on 09/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "PostActivityModel.h"

@implementation PostActivityModel

- (void)deleteArt:(NSString *)userID :(NSString *) artID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;{

    [iOSRequest postData:[NSString stringWithFormat:DELETE_PERSONAL_ART,BASE_URL,userID,artID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];

}
- (void)updateArt:(NSString *)userID :(NSString *) artID :(NSData *)imageData :(BOOL) isImage :(NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest updateArt:[NSString stringWithFormat:UPDATE_ART,BASE_URL,userID,artID] :parameters :isImage :imageData :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
    
}

- (void)addFavorite:(NSString *)userID :(NSString *) artID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:ADD_FAVORITE_API,BASE_URL,userID,artID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
- (void)removeFavorite:(NSString *)userID :(NSString *) artID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    [iOSRequest postData:[NSString stringWithFormat:REMOVE_FAVORITE_API,BASE_URL,userID,artID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
- (void) postArt:(NSString *)userID : (NSDictionary *)parameters :(NSData *) data : (BOOL)isImage :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{

    [iOSRequest postArt:[NSString stringWithFormat:POST_ART,BASE_URL,userID] :parameters :isImage :data :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}

@end
