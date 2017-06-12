//
//  LoginModel.m
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "LoginRegisterationModel.h"

@implementation LoginRegisterationModel


- (void)loginUser : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
        [iOSRequest postData:[NSString stringWithFormat:LOGIN_API,BASE_URL] :parameters :^(NSDictionary *response_success) {
            success(response_success);
        } :^(NSError *response_error) {
            failure(response_error);
        }];
}

- (void)loginUserWithImage : (NSDictionary *)parameters :(NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest loginWithImage:[NSString stringWithFormat:LOGIN_API,BASE_URL] :parameters :YES :data :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];

}

- (void)registerUser : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:REGISTER_API,BASE_URL] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}

- (void)forgotPassword : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:FORGOT_PASSWORD_API,BASE_URL] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
- (void)logoutUser : (NSString *) userID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:LOGOUT_API,BASE_URL,userID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}

@end
