//
//  UITextViewPlaceholder.h
//  ArtGround
//
//  Created by Kunal Gupta on 09/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIPlaceholderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;
@property (nonatomic, retain) UILabel *placeHolderLabel;

-(void)textChanged:(NSNotification*)notification;


@end
