//
//  Singleton.m
//  ArtGround
//
//  Created by Kunal Gupta on 17/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo : NSObject

static UserInfo * sharedUserInfo = nil;
static dispatch_once_t once;

-(id)init{
    
    if (self == [super init]) {
        
        _arrCategories = [NSMutableArray new];
        _arrCatID = [NSMutableArray new];
        _arrMedia = [NSMutableArray new];
        _arrSpecialization = [NSMutableArray new];
    }
    return self;
}

+(id)sharedUserInfo{
    
    dispatch_once(&once, ^{
        
        sharedUserInfo = [[self alloc] init];
    });
    
    return sharedUserInfo;
}


@end
