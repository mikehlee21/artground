//
//  ChatMyMessageCell.h
//  ArtGround
//
//  Created by Kunal Gupta on 26/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
@interface ChatMyMessageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *viewMyMessage;
@property (strong, nonatomic) IBOutlet UILabel *labelMyMessage;
@property (strong, nonatomic) IBOutlet UIView *viewDate;
@property (strong, nonatomic) IBOutlet UILabel *labelDate;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightViewDate;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@end
