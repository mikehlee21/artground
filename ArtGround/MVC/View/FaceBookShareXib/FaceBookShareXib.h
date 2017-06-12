//
//  FaceBookShareXib.h
//  ArtGround
//
//  Created by Kunal Gupta on 10/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "UITextViewPlaceholder.h"
#import <UIImageView+WebCache.h>

@interface FaceBookShareXib : UIView

-(id)initWithFrame:(CGRect)frame :(NSString *)image;

@property (strong, nonatomic) IBOutlet UIPlaceholderTextView *textViewMessage;
@property (strong, nonatomic) IBOutlet UIButton *btnPost;
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewImage;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;


@property NSString *strImage;



- (IBAction)actionBtnCancel:(id)sender;
- (IBAction)actionBtnPost:(id)sender;

@end
