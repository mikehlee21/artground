//
//  BaseVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RTAlertView.h>
#import "Macro.h"
#import "Reachability.h"

@interface BaseVC : UIViewController <UIAlertViewDelegate >

-(void)showAlert : (NSString *)message;
-(void)showSuccess :(NSString *)title :(NSString *)message;
-(void)logout:(NSString *)message SegueIdentifier :(NSString *) identifier;

-(id)initWithFrame:(CGRect)frame;

-(void)showLoader;
-(void)hideLoader;

@property (strong, nonatomic) IBOutlet UITabBar *tabBarController;
@property NSString *identifier;
@property NSMutableArray *arrCategories;
@property NSInteger tabBarItemIndex;

-(BOOL)internetWorking;
@end
