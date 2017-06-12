//
//  Reddit.h
//  ArtGround
//
//  Created by Kunal Gupta on 03/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "RedditModel.h"
#import <RKClient+Apps.h>
#import <RKClient.h>
#import "SpinnerView.h"

@interface Reddit : UIView <UITextFieldDelegate>

-(id)initWithFrame:(CGRect)frame;

@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UITextField *tfRedditName;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewBottomConstrraint;

- (IBAction)actionBtnSubmit:(id)sender;
- (IBAction)actionBtnCancel:(id)sender;

@end
