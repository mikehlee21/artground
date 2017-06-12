//
//  AboutMeDetails.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "AboutMeDetails.h"

@implementation AboutMeDetails

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];

    if (self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"AboutMeView" owner:self options:nil] firstObject];
        [self setFrame:frame];
    }

    [self setNeedsLayout];
    [self layoutIfNeeded];

    [self setupUI];
//    [self.sidePanelTableView reloadData];

    return self;
}

#pragma mark - self made

-(void)setupUI{
    _viewContent.layer.cornerRadius = 4.0;
}


#pragma mark - Touches Bagen

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]){
        [self endEditing:YES];
    }
    return YES;
}

#pragma mark - action Button

- (IBAction)actionBtnCancel:(id)sender {
    [self setHidden:YES];
    [self.viewContent endEditing:YES];
}

- (IBAction)actionBtnSave:(id)sender {
    [self setHidden:YES];
    [self.viewContent endEditing:YES];
    NSString *text = [_textViewAboutMe.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:text,@"text", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"about_me" object:nil userInfo:dict];
}

@end
