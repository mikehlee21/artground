//
//  ShowChatImage.m
//  ArtGround
//
//  Created by Kunal Gupta on 27/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "ShowChatImage.h"

@implementation ShowChatImage

-(id)initWithFrame:(CGRect)frame andStr:(NSString *)strImage orImage :(UIImage *)image {
    
    self = [super initWithFrame:frame];
    
    if (self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"ShowChatImage" owner:self options:nil] firstObject];
        [self setFrame:frame];
    }
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    [self.viewContent addGestureRecognizer:_tapGesture];

    _strImage = strImage;
    _imageMessage = image;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self setupUI];
    //    [self.sidePanelTableView reloadData];
    
    return self;
}
-(void)setupUI{
    
    _widthConstraint.constant = kframe.width -40;
    _heightConstraint.constant = _widthConstraint.constant;
    _imageViewPic.layer.borderWidth = 1.0;
    _imageViewPic.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    
    if(_imageMessage != nil){
        _imageViewPic.image = _imageMessage;
    }
    else{
    [_imageViewPic sd_setImageWithURL:[NSURL URLWithString:_strImage]];
    }
}
-(void)viewTapped:(UITapGestureRecognizer*)gesture{
    [self setHidden:YES];
}
- (IBAction)actionBtnCancel:(id)sender {
     [self setHidden:YES];
}
@end
