//
//  TableViewPostCEll.h
//  SketchApp
//
//  Created by Kunal Gupta on 04/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "LikeModel.h"

@interface TableViewPostCEll : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelPost;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property NSString *strUsername;
@property NSString *strUserID;

@property UITapGestureRecognizer *tapGesture;

@property NSMutableDictionary *dictParams;
@property NSString *accessToken;
@property NSString *postID;

@end
