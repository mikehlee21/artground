//
//  MessageTableViewCell.h
//  ArtGround
//
//  Created by Kunal Gupta on 25/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

@interface MessageTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *viewImage;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePIc;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelMessage;
@property (strong, nonatomic) IBOutlet UILabel *labelTime;
@property (strong, nonatomic) IBOutlet UIButton *btnOpenChat;
@property (strong, nonatomic) IBOutlet UIView *viewBadge;
@property (strong, nonatomic) IBOutlet UILabel *labelBadge;

@end
