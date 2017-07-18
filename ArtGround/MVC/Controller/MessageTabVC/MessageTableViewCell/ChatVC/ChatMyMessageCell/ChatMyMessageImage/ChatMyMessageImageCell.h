//
//  ChatMyMessageImageCell.h
//  ArtGround
//
//  Created by Kunal Gupta on 27/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowChatImage.h"


@interface ChatMyMessageImageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageViewMessage;
@property UITapGestureRecognizer *tapGesture;
@property NSString *strImage;
@property UIImage *imageMessage;
@property (strong, nonatomic) IBOutlet UIView *viewDate;

@property (strong, nonatomic) IBOutlet UILabel *labelDate;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightViewDate;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@end
