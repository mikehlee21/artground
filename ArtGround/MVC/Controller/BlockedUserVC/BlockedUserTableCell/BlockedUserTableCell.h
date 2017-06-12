//
//  BlockedUserTableCell.h
//  ArtGround
//
//  Created by Kunal Gupta on 30/03/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "BlockedUserModel.h"
#import <UIImageView+WebCache.h>

@protocol BlockedDelegate

-(void)unblockUser:(NSIndexPath *)index;

@end


@interface BlockedUserTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property id <BlockedDelegate> delegate;
- (IBAction)actionBtnUnblock:(id)sender;

@property NSIndexPath *index;
-(void)configureCell:(BlockedUserModel *)model;
@end
