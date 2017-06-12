//
//  ChatOtherMessageCell.h
//  ArtGround
//
//  Created by Kunal Gupta on 26/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

@interface ChatOtherMessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *viewOtherMessage;
@property (strong, nonatomic) IBOutlet UILabel *labelOtherMessage;
@property (strong, nonatomic) IBOutlet UIView *viewDate;
@property (strong, nonatomic) IBOutlet UILabel *labelDate;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightViewdate;
@end
