//
//  BlockedUserModel.h
//  ArtGround
//
//  Created by Kunal Gupta on 30/03/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"
#import "iOSRequest.h"


@interface BlockedUserModel : NSObject

@property NSString *strProfilePic;
@property NSString *strName;
@property NSString *strUserID;

- (void)getBlockedList:(NSString *)userID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+ (NSArray*)parseDataToArray:(NSArray*)array;


@end
