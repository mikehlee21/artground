//
//  CategoryTableVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 28/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "CategoryTableViewCell.h"
#import "UserInfo.h"

@protocol TagDelegate;


@interface CategoryTableVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(IBAction)actionBtnCancel:(id)sender;

-(void)getArray:(NSMutableArray *)arr andType:(NSString *)type;

@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property NSMutableArray *arrData;
//@property NSMutableArray *arrMediaComplete;
//@property NSMutableArray *arrSpecializationComplete;
@property NSMutableArray *arrComplete;
@property NSMutableArray *cellSelected;
@property NSMutableArray *prepareArr;
@property NSString *tagsType;
@property (strong, nonatomic) IBOutlet UILabel *labelHeading;

@property BOOL canAddMore;
@property (nonatomic, weak) id <TagDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *labelInfo;

- (IBAction)actionBtnDone:(id)sender;

@end


@protocol TagDelegate
-(void)getArray:(NSMutableArray *) tags withType:(NSString *)type;

@end
