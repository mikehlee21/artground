//
//  BlockedUserModel.m
//  ArtGround
//
//  Created by Kunal Gupta on 30/03/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

#import "BlockedUserModel.h"

@implementation BlockedUserModel

- (void)getBlockedList:(NSString *)userID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:GET_BLOCKED_LIST,BASE_URL,userID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
    
}

+ (NSArray*)parseDataToArray:(NSArray*)array{
    
    NSMutableArray * arr = [NSMutableArray new];
    for (NSDictionary * dict  in array){
        BlockedUserModel * fm = [[BlockedUserModel alloc]initWithAttributes:dict];
        [arr addObject:fm];
    }
    return arr;
}

-(BlockedUserModel *)initWithAttributes:(NSDictionary*)attributes{
    
    BlockedUserModel * fm = [[BlockedUserModel alloc]init];
    
    fm.strProfilePic = [attributes objectForKey:@"image"];
    fm.strUserID = [attributes objectForKey:@"id"];
    fm.strName = [attributes objectForKey:@"name"];
    
    return fm;
}

@end
