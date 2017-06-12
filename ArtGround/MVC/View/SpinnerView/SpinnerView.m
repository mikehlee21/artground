//
//  SpinnerView.m
//  ArtGround
//
//  Created by Kunal Gupta on 06/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "SpinnerView.h"

@implementation SpinnerView

-(id)initWithFrame:(CGRect)frame andColor :(UIColor *)color{
    
    self = [super initWithFrame:frame];
    
    if (self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"SpinnerView" owner:self options:nil] firstObject];
        [self setFrame:frame];
    }
    _spinner = [[MMMaterialDesignSpinner alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _spinner.center = self.center;
    _spinner.tintColor = color;
    _spinner.lineWidth = 4.0f;
    [self addSubview:_spinner];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    //    [self setupUI];
    //    [self.sidePanelTableView reloadData];
    
    return self;
}

-(void)startLoader{
    [_spinner startAnimating];
}

-(void)stopLoader{
    [_spinner stopAnimating];
}

@end
