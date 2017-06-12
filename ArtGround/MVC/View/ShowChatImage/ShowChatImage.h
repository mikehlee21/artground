//
//  ShowChatImage.h
//  ArtGround
//
//  Created by Kunal Gupta on 27/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import <UIImageView+WebCache.h>

@interface ShowChatImage : UIView


- (IBAction)actionBtnCancel:(id)sender;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPic;

@property (strong, nonatomic) IBOutlet UIView *viewContent;
-(id)initWithFrame:(CGRect)frame andStr:(NSString *)strImage orImage :(UIImage *)image;


@property NSString *strImage;
@property UIImage *imageMessage;

@property UITapGestureRecognizer *tapGesture;


@end
