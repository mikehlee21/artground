//
//  TagsView.m
//  ArtGround
//
//  Created by Kunal Gupta on 24/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "TagsView.h"

@implementation TagsView

-(id)initWithFrame:(CGRect)frame andArray:(NSMutableArray *)arr{
    
    self = [super initWithFrame:frame];
    
    if (self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"Tags" owner:self options:nil] firstObject];
        [self setFrame:frame];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.arrTags = arr;
    [self setupUI];
    //    [self.sidePanelTableView reloadData];
    
    return self;
}
-(void)getArr:(NSMutableArray *)arr{
}
-(void)setupUI{
    self.tokenField.delegate = self;
    self.tokenField.dataSource = self;
    self.tokenField.placeholderText = NSLocalizedString(@"", nil);
    self.tokenField.toLabelText = NSLocalizedString(@"", nil);
    [self.tokenField setColorScheme:[UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1]];
    self.tokenField.delimiters = @[@",", @";", @"--"];
    self.tokenField.maxHeight = 65;
    self.tokenField.tokenPadding = 8;

    self.viewContent.layer.cornerRadius = 8.0;

    [self.tokenField becomeFirstResponder];
    [self.tokenField reloadData];
}

- (void)tokenField:(VENTokenField *)tokenField didEnterText:(NSString *)text{
    if(text.length < 25){
    [self.arrTags addObject:text];
    [self.tokenField reloadData];
    }
}

- (void)tokenField:(VENTokenField *)tokenField didDeleteTokenAtIndex:(NSUInteger)index{
    
    [self.arrTags removeObjectAtIndex:index];
    [self.tokenField reloadData];
}


#pragma mark - VENTokenFieldDataSource

- (NSString *)tokenField:(VENTokenField *)tokenField titleForTokenAtIndex:(NSUInteger)index
{
    return self.arrTags[index];
}

- (NSUInteger)numberOfTokensInTokenField:(VENTokenField *)tokenField
{
    return [self.arrTags count];
}

- (NSString *)tokenFieldCollapsedText:(VENTokenField *)tokenField
{
    return [NSString stringWithFormat:@"%tu people", [self.arrTags count]];
}


- (IBAction)actionBnCancel:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancel_button_pressed" object:nil];
    [self setHidden:YES];
}

- (IBAction)actionBtnSave:(id)sender {
    [self setHidden:YES];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:self.arrTags,@"tags", nil];
    
    if([_labelHeading.text isEqualToString:@"Media"]){
    [[NSNotificationCenter defaultCenter] postNotificationName:@"set_media_tags" object:nil userInfo:dict];
    }
    else if([_labelHeading.text isEqualToString:@"Specialization"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"set_specialization_tags" object:nil userInfo:dict];
    }
    else if([_labelHeading.text isEqualToString:@"Tags"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"set_tags" object:nil userInfo:dict];
    }

}
@end
