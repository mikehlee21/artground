//
//  MessageTabVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTableViewCell.h"
#import "ChatModel.h"
#import "ChatVC.h"
#import "Macro.h"
#import "SpinnerView.h"
#import "UITabBarItem+CustomBadge.h"
#import <UIImageView+WebCache.h>
#import "BaseVC.h"

@interface MessageTabVC : BaseVC <UITabBarControllerDelegate , UITableViewDataSource, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITabBarItem *tabBarItemMessage;


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *btnSound;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UIView *viewTop;

@property NSMutableArray *arrTableData;
//@property NSTimer *timer;
@property NSString *timeZone;
@property SpinnerView *spinner;
@property NSString *artistID;
@property NSString *artistPic;
@property NSString *artistName;
-(void)initializeAPI;
- (IBAction)actionBtnSound:(id)sender;
- (IBAction)actionBtnMenu:(id)sender;

@end
