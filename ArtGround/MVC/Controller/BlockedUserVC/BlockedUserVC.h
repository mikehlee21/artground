//
//  BlockedUserVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 30/03/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockedUserTableCell.h"
#import "ChatModel.h"
#import "SpinnerView.h"


@interface BlockedUserVC : UIViewController <UITableViewDataSource , UITableViewDelegate,BlockedDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)actionBtnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelAlert;


@property NSMutableArray *arrTableData;
@property SpinnerView *spinner;

@end
