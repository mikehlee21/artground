//
//  HomeTabVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"
#import "HomeVC.h"
#import "TopHomeVC.h"
#import "ProfileHomeVC.h"
#import "Macro.h"


@interface HomeTabVC : UIViewController <UIPageViewControllerDataSource , UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
@property (weak, nonatomic) IBOutlet UIButton *btnTop;
@property (weak, nonatomic) IBOutlet UIButton *btnProfile;
@property (weak, nonatomic) IBOutlet UIView *viewTabComplete;
@property (weak, nonatomic) IBOutlet UIView *viewTabScroll;
@property (weak, nonatomic) IBOutlet UIView *viewPlaceHolder;

@property HomeVC *home;
@property TopHomeVC *homeTop;
@property ProfileHomeVC *homeProfile;
@property (strong, nonatomic) IBOutlet UITabBarItem *tabBarItemHome;
@property NSArray *viewControllers;
@property UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) UIPageViewController * pageController;



- (IBAction)actionBtnNew:(id)sender;
- (IBAction)actionBtnTop:(id)sender;
- (IBAction)actionBtnHome:(id)sender;

@end
