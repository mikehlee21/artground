//
//  Singleton.h
//  ArtGround
//
//  Created by Kunal Gupta on 17/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property NSMutableArray * arrCategories;
@property NSMutableArray *arrCatID;
@property NSMutableArray *arrMedia;
@property NSMutableArray *arrSpecialization;

+(id)sharedUserInfo;

@end
