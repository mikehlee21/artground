//
//  AboutMeApp.m
//  ArtGround
//
//  Created by Kunal Gupta on 25/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "AboutMeApp.h"

@implementation AboutMeApp

-(id)initWithFrame:(CGRect)frame andStr:(NSString *)str1{
    
    self = [super initWithFrame:frame];
    
    if (self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"AboutMeApp" owner:self options:nil] firstObject];
        [self setFrame:frame];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self setupUI];
    //    [self.sidePanelTableView reloadData];
    
    return self;
}
-(void)setupUI{
    _viewWidthConstraint.constant = kframe.width - 40;
    _viewTop.backgroundColor = kAppColor;
    _label1.text = _str1;
    _label2.text = _str2;
    
    [_label1 sizeToFit];
    NSLog(@"%@",NSStringFromCGRect([_label1 frame]));

}
- (IBAction)actionBtnCancel:(id)sender {
    [self setHidden:YES];
}
@end
