//
//  HomeTabVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "HomeTabVC.h"

@interface HomeTabVC ()

@end

@implementation HomeTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToHome:) name:@"switchToHome" object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialize{
    
    _viewTop.backgroundColor = kAppColor;
    _home = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    _homeProfile = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileHomeVC"];
    _homeTop = [self.storyboard instantiateViewControllerWithIdentifier:@"TopHomeVC"];
    [self addPageController];
}

-(void)switchToHome:(NSNotification *)noti{
    [UIView animateWithDuration:0.25 animations:^{
        _viewTabScroll.frame = CGRectMake(0, 0, _btnHome.frame.size.width,_viewTabScroll.frame.size.height);
        //    [_btnFollowing setSelected:YES];
        //    [_btnNearby setSelected:NO];
    }];
    _viewControllers = [[NSArray alloc]initWithObjects:_home, nil];
    [self.pageController setViewControllers:_viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

-(void)addPageController {
    
    //Page Holder initialize
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    // setting up frame
    [[self.pageController view] setFrame:CGRectMake(0, 0, self.viewPlaceHolder.frame.size.width, self.viewPlaceHolder.frame.size.height)];
    
    
    NSArray *viewControllers = [NSArray arrayWithObject:_home];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.viewPlaceHolder addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
}
#pragma mark - Page View Controller Delegates

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[ProfileHomeVC class]]){
        return  _homeTop;
    }
    else if ([viewController isKindOfClass:[TopHomeVC class]]){
       return _home;
    }
    else{
        
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[HomeVC class]]){
        return  _homeTop;
    }
    else if ([viewController isKindOfClass:[TopHomeVC class]]){
        return _homeProfile;
    }
    else{
        return nil;
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (!completed) {
        
        return;
    }
    
    UIViewController *viewController = [pageViewController.viewControllers lastObject];
    if ([viewController isKindOfClass:[HomeVC class]]) {
            [UIView animateWithDuration:0.25 animations:^{
        _viewTabScroll.frame = CGRectMake(0, 0, _btnHome.frame.size.width,_viewTabScroll.frame.size.height);
            }];
//        [_btnFollowing setSelected:YES];
//        [_btnNearby setSelected:NO];
    }
    
    else if ([viewController isKindOfClass:[TopHomeVC  class]]) {
            [UIView animateWithDuration:0.25 animations:^{
        _viewTabScroll.frame = CGRectMake(_btnHome.frame.size.width , 0,_btnTop.frame.size.width ,
                                    _viewTabScroll.frame.size.height);
            }];
                //        [_btnNearby setSelected:YES];
//        [_btnFollowing setSelected:NO];
    }
    else if ([viewController isKindOfClass:[ProfileHomeVC class]]){
            [UIView animateWithDuration:0.25 animations:^{
        _viewTabScroll.frame = CGRectMake(_btnProfile.frame.size.width * 2, 0, _btnProfile.frame.size.width, _viewTabScroll.frame.size.height);
            }];
    }
}

#pragma mark - Action Button

- (IBAction)actionBtnNew:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
       _viewTabScroll.frame = CGRectMake(_btnProfile.frame.size.width * 2, 0, _btnProfile.frame.size.width, _viewTabScroll.frame.size.height);
    }];
//    [_btnFollowing setSelected:YES];
//    [_btnNearby setSelected:NO];
    _viewControllers = [[NSArray alloc]initWithObjects:_homeProfile, nil];
    [self.pageController setViewControllers:_viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (IBAction)actionBtnTop:(id)sender {
  [UIView animateWithDuration:0.25 animations:^{
     _viewTabScroll.frame = CGRectMake(_btnHome.frame.size.width , 0,_btnTop.frame.size.width , _viewTabScroll.frame.size.height);
  }];
    //    [_btnFollowing setSelected:YES];
    //    [_btnNearby setSelected:NO];
    _viewControllers = [[NSArray alloc]initWithObjects:_homeTop, nil];
    [self.pageController setViewControllers:_viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];

}

- (IBAction)actionBtnHome:(id)sender {
      [UIView animateWithDuration:0.25 animations:^{
     _viewTabScroll.frame = CGRectMake(0, 0, _btnHome.frame.size.width,_viewTabScroll.frame.size.height);
    //    [_btnFollowing setSelected:YES];
    //    [_btnNearby setSelected:NO];
      }];
    _viewControllers = [[NSArray alloc]initWithObjects:_home, nil];
    [self.pageController setViewControllers:_viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}
@end
