//
//  AboutMeApp.h
//  ArtGround
//
//  Created by Kunal Gupta on 25/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"


@interface AboutMeApp : UIView

-(id)initWithFrame:(CGRect)frame andStr:(NSString *)str1;


@property (strong, nonatomic) IBOutlet UIView *viewTop;

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;

@property NSString *str1;
@property NSString *str2;
- (IBAction)actionBtnCancel:(id)sender;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewWidthConstraint;

@end
