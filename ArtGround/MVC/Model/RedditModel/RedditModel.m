//
//  RedditModel.m
//  ArtGround
//
//  Created by Kunal Gupta on 03/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "RedditModel.h"

@implementation RedditModel

- (void)redditLogin : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
   
    [iOSRequest postData:[NSString stringWithFormat:REDDIT_LOGIN,REDDIT_BASE_URL] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
- (void)getCaptcha :(NSString *)iden : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{

    [iOSRequest getImageResponse:[NSString stringWithFormat:GET_CAPTCHA,REDDIT_BASE_URL,iden] :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
- (void)sharePost :(NSDictionary  *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postMutipartRedditPost :[NSString stringWithFormat:REDDIT_SUBMIT,REDDIT_BASE_URL] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
@end
