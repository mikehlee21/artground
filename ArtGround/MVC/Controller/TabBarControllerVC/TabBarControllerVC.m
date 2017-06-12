//
//  TabBarControllerVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "TabBarControllerVC.h"

@interface TabBarControllerVC ()

@end

@implementation TabBarControllerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self didReceivePushNotification];
    _tabBarint = 0;
    _currentTab = 0;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToMessageVC:) name:N_NOTI_INFO object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popVC:) name:@"popTabBarController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:N_NOTI_INFO object:nil];

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCurrentChatUserID:) name:@"NoNotificationForUserID" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[NSUserDefaults standardUserDefaults] setInteger: self.selectedIndex forKey:LAST_TAB];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    _previousTab = _currentTab;
    _currentTab = item.tag;
    NSLog(@"Current tab %lu",(unsigned long)_currentTab);
    NSLog(@"Previous tab %lu",(unsigned long)_previousTab);

}

-(void)popVC:(NSNotification *)noti{
[(UITabBarController*)self.navigationController.topViewController setSelectedIndex:_previousTab];
}

-(void)getCurrentChatUserID:(NSNotification *)noti{
    NSLog(@"%@",noti.object);
    _otherUserID = [noti.object valueForKey:@"id"];
}

-(void)setSelectedViewController:(__kindof UIViewController *)selectedViewController{

    [super setSelectedViewController:selectedViewController];
        
        for (UIViewController *viewController in self.viewControllers) {
            if (viewController == selectedViewController) {
                [viewController.tabBarItem setTitleTextAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:12], NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
            }
            else{
                [viewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:11],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
            }
        }
    if(selectedViewController.tabBarItem.tag == 0){
        _tabBarint ++;
        if(_tabBarint == 2){
            _tabBarint = 0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"switchToHome" object:nil];
        }
    }
}

-(void)pushToMessageVC:(NSNotification *)noti{
    if(!([[UIApplication sharedApplication]applicationState] == UIApplicationStateActive)){
    [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:3];
    NSString *strUsername = [noti.userInfo valueForKeyPath:@"aps.alert.loc-args.name"];
    NSString *strUserID = [noti.userInfo valueForKeyPath:@"aps.alert.loc-args.s_id"];
    NSString *strUserPic = [noti.userInfo valueForKeyPath:@"aps.alert.loc-args.pic"];
    NSDictionary *dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:strUsername,@"name",strUserID,@"id",strUserPic,@"pic", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"send_data" object:nil userInfo:dict];
    }
}
-(void)didReceivePushNotification{
    
    NSDictionary *notifDict = [[NSUserDefaults standardUserDefaults] valueForKey:UD_NOTIFICATION_INFO];
    NSLog(@"%@",notifDict);
    if(notifDict != nil){
        [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:3];
        NSString *strUsername = [notifDict valueForKeyPath:@"aps.alert.loc-args.name"];
        NSString *strUserID = [notifDict valueForKeyPath:@"aps.alert.loc-args.s_id"];
        NSString *strUserPic = [notifDict valueForKeyPath:@"aps.alert.loc-args.pic"];
        NSDictionary *dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:strUsername,@"name",strUserID,@"id",strUserPic,@"pic", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"send_data" object:nil userInfo:dict];
         [[NSUserDefaults standardUserDefaults] removeObjectForKey:UD_NOTIFICATION_INFO];
        }
}

-(void)notificationReceived:(NSNotification *)noti{
    
    [[self.tabBar.items objectAtIndex:3] setBadgeValue:[NSString stringWithFormat:@"%@",[noti.userInfo valueForKeyPath:@"aps.alert.loc-args.c"]]];
    [UIApplication sharedApplication].applicationIconBadgeNumber = [[noti.userInfo valueForKeyPath:@"aps.alert.loc-args.c"] integerValue];
//    MessageTabVC *VC;
//    [VC initializeAPI];
    
    if(![[noti.userInfo valueForKeyPath:@"aps.alert.loc-args.s_id"] isEqualToString:_otherUserID]){
    
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"main_logo"] title:@"ArtGround" message:[noti.userInfo valueForKeyPath:@"aps.alert.body"] isAutoHide:YES onTouch:^{
        [HDNotificationView hideNotificationView];
        NSString *strUsername = [noti.userInfo valueForKeyPath:@"aps.alert.loc-args.name"];
        NSString *strUserID = [noti.userInfo valueForKeyPath:@"aps.alert.loc-args.s_id"];
        NSString *strUserPic = [noti.userInfo valueForKeyPath:@"aps.alert.loc-args.pic"];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:strUsername,@"name",strUserID,@"id",strUserPic,@"pic", nil];
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"send_data" object:nil userInfo:dict];

        ChatVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
        [VC getUserDetails:dict];
        [self.navigationController pushViewController:VC animated:YES];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UD_NOTIFICATION_INFO];

        }
     ];
    }
}
@end
