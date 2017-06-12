//
//  FaceBookShareXib.m
//  ArtGround
//
//  Created by Kunal Gupta on 10/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "FaceBookShareXib.h"

@implementation FaceBookShareXib

-(id)initWithFrame:(CGRect)frame :(NSString *)image{
    
    self = [super initWithFrame:frame];
    
    if (self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"FaceBookShareXib" owner:self options:nil] firstObject];
        [self setFrame:frame];
    }
    _strImage = image;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self setupUI];
    
    return self;
}

-(void)setupUI{
    
    _viewContent.layer.cornerRadius = 8.0;
    [_viewContent setClipsToBounds:YES];
    _textViewMessage.placeholder = @"Write Something";
    [_imageViewImage sd_setImageWithURL:[NSURL URLWithString:_strImage]];
}

- (IBAction)actionBtnPost:(id)sender{
    [self endEditing:YES];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:_textViewMessage.text,@"text", nil];    [[NSNotificationCenter defaultCenter] postNotificationName:@"post_to_fb" object:nil userInfo:dict];
    [self setHidden:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (IBAction)actionBtnCancel:(id)sender {
    [self setHidden:YES];
    [self.viewContent endEditing:YES];

}
@end
