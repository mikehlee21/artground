//
//  RedditModel.h
//  ArtGround
//
//  Created by Kunal Gupta on 03/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"
#import "iOSRequest.h"


@interface RedditModel : NSObject

- (void)redditLogin : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)getCaptcha :(NSString *)iden : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

- (void)sharePost : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

@end
