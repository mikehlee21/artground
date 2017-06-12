//
//  LoginModel.h
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"


@interface LoginRegisterationModel : NSObject

- (void)loginUser : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)loginUserWithImage : (NSDictionary *)parameters :(NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)registerUser : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)forgotPassword : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)logoutUser : (NSString *) userID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

@end
