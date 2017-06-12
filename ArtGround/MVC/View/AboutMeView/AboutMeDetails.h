//
//  AboutMeDetails.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeDetails : UIView <UITextViewDelegate>

-(id)initWithFrame:(CGRect)frame;

@property (weak, nonatomic) IBOutlet UITextView *textViewAboutMe;
@property (strong, nonatomic) IBOutlet UIView *viewContent;


- (IBAction)actionBtnCancel:(id)sender;
- (IBAction)actionBtnSave:(id)sender;

@end
