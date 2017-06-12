//
//  SpinnerView.h
//  ArtGround
//
//  Created by Kunal Gupta on 06/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMMaterialDesignSpinner.h>


@interface SpinnerView : UIView

-(id)initWithFrame:(CGRect)frame andColor :(UIColor *)color;
-(void)startLoader;
-(void)stopLoader;

@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property MMMaterialDesignSpinner *spinner;
@end


