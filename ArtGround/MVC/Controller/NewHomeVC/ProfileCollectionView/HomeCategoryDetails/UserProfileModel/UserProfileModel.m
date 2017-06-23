//
//  UserProfileModel.m
//  ArtGround
//
//  Created by Kunal Gupta on 06/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "UserProfileModel.h"

@implementation UserProfileModel


- (void)userDetails:(NSString *)userID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:USER_PROFILE_API,BASE_URL,userID] :parameters :^(NSDictionary *response_success){
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
- (void) updateProfileWithPic:(NSString *)userID : (NSDictionary *)parameters :(NSData *) data : (BOOL)isImage :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postPic:[NSString stringWithFormat:UPDATE_USER_INFO_API,BASE_URL,userID] :parameters :isImage :data :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
- (void) updateProfile:(NSString *)userID : (NSDictionary *)parameters :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    [iOSRequest postData:[NSString stringWithFormat:UPDATE_USER_INFO_API,BASE_URL,userID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
    
}
- (void) updateCoverProfileWithPic:(NSString *)userID : (NSDictionary *)parameters :(NSData *) data : (BOOL)isImage :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    [iOSRequest postCoverPic:[NSString stringWithFormat:UPDATE_USER_INFO_API,BASE_URL,userID] :parameters :isImage :data :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
- (void) updateCoverProfile:(NSString *)userID : (NSDictionary *)parameters :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:UPDATE_USER_INFO_API,BASE_URL,userID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
- (void) userRateOther:(NSString *)userID :(NSString *)artistID : (NSDictionary *)parameters :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    [iOSRequest postData:[NSString stringWithFormat:USER_RATE_OTHER_USER,BASE_URL,userID,artistID] :parameters :^(NSDictionary *response_success){
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
    
}
-(void)userViewOtherUserArts:(NSString *)userID :(NSString *)artistID : (NSDictionary *)parameters :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    [iOSRequest postData:[NSString stringWithFormat:USER_VIEW_OTHER_ATRIST_PAINTINGS,BASE_URL,userID,artistID] :parameters :^(NSDictionary *response_success){
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
    
}



@end
