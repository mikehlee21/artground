//
//  TabBarControllerVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "BaseVC.h"
#import "HDNotificationView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ChatVC.h"
#import "MessageTabVC.h"


@interface TabBarControllerVC : UITabBarController <UITabBarControllerDelegate, UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UITabBar *myTabBar;
@property NSInteger tabBarint;
@property NSUInteger currentTab;
@property NSUInteger previousTab;

@property NSString *otherUserID;

@end
