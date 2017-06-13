//
//  Colors.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
//255 99 100 
@interface Colors : NSObject

//#define kAppColor [UIColor colorWithRed:249/255.f green:22/255.f blue:73/255.f alpha:1];
#define kAppColor [UIColor colorWithRed:40/255.f green:40/255.f blue:40/255.f alpha:1];
#define kSelColor [UIColor colorWithRed:255/255.f green:0/255.f blue:90/255.f alpha:1];
#define KGrayBorder [[UIColor colorWithRed:204/255.f green:205/255.f blue:206/255.f alpha:1]CGColor]
#define klightGray [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1];
#define kdarkGray [UIColor colorWithRed:70/255.f green:70/255.f blue:70/255.f alpha:1];
#define kframe [[UIScreen mainScreen] bounds].size
#define kWindow [[[UIApplication sharedApplication] delegate] window]
#define kDefaultPic [UIImage imageNamed:@"ic_placeholder"]
#define kFaceBookColor [UIColor colorWithRed:59/255.f green:88/255.f blue:144/255.f alpha:1]


@end
