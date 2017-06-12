//
//  Reddit.m
//  ArtGround
//
//  Created by Kunal Gupta on 03/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "Reddit.h"


@implementation Reddit

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self){
        self = [[[NSBundle mainBundle] loadNibNamed:@"Reddit" owner:self options:nil] firstObject];
        [self setFrame:frame];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self setupUI];
    
    return self;
}

- (IBAction)actionBtnCancel:(id)sender {
    [self setHidden:YES];
}
-(void)showAlert:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}
-(void)setupUI{
    
    _viewContent.layer.cornerRadius = 6.0;
//    _viewContent.layer.borderWidth = 2.0;
    [_viewContent setClipsToBounds:YES];
    
    _tfRedditName.layer.borderWidth = 1.0;
    _tfRedditName.layer.borderColor = [[UIColor blackColor]CGColor];
    _tfRedditName.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _tfRedditName.layer.cornerRadius = 4.0;
    [_tfRedditName setClipsToBounds:YES];
    
    _tfPassword.layer.borderWidth = 1.0;
    _tfPassword.layer.borderColor = [[UIColor blackColor]CGColor];
    _tfPassword.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _tfPassword.layer.cornerRadius = 4.0;
    [_tfPassword setClipsToBounds:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if([_tfRedditName isFirstResponder]){
        [_tfPassword becomeFirstResponder];
    }
    else if ([_tfPassword isFirstResponder]){
        [self endEditing:YES];
    }
    return YES;
    
}
- (IBAction)actionBtnSubmit:(id)sender {
    [self endEditing:YES];
    if([_tfRedditName.text isEqualToString:@""]){
        [self showAlert:@"Please enter your Reddit Name"];
    }
    else if ([_tfPassword.text isEqualToString:@""]){
        [self showAlert:@"Please enter your Reddit Password"];
    }
    else{
        
        SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:spinner];
        [spinner startLoader];
        
        [[RKClient sharedClient] signInWithUsername:[_tfRedditName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] password:[_tfPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] completion:^(NSError *error) {
            [spinner stopLoader];
            [spinner removeFromSuperview];

            if([[RKClient sharedClient]modhash].length != 0){
                NSLog(@"Modhash = %@",[[RKClient sharedClient] modhash]);
                [[NSUserDefaults standardUserDefaults] setObject:[[RKClient sharedClient] modhash] forKey:REDDIT_ACCESS_TOKEN];
                                //       [[RKClient sharedClient] signOut];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"sign_in" object:nil];
                [self setHidden:YES];
            }
            else{
             
                [self showAlert:@"Username or password do not match"];
            }
            }
         ];
        
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _viewBottomConstrraint.constant = 216;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _viewBottomConstrraint.constant = 0;
}
@end