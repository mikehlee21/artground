//
//  RedditVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 03/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "RedditVC.h"

@interface RedditVC ()

@end

@implementation RedditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialise];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - self made

-(void)getModel:(HomeModel*)home{
    _hm = home;
}
-(void)initialise{
    _iden = @"ddddd";
    _btnShare.backgroundColor = kAppColor;
    _viewTop.backgroundColor = kAppColor;
    _tfCaptcha.layer.borderWidth = 1.0;
    _tfCaptcha.layer.borderColor = [[UIColor blackColor]CGColor];

    _tfCaptcha.layer.cornerRadius = 4.0;
    [_tfCaptcha setClipsToBounds:YES];
    _imageViewheightConstraint.constant = kWindow.frame.size.width - 80;
    [_imageViewPost sd_setImageWithURL:[NSURL URLWithString:_hm.strPostImage]];
    _labelPost.text = [NSString stringWithFormat:@"%@ (%@)", _hm.strTitle,_hm.strArtistName];
    [self loadImage];
    
}
-(void)loadImage{
    RedditModel *model = [[RedditModel alloc]init];
    [model getCaptcha:_iden :^(id response_success) {
        NSLog(@"%@",response_success);
        _imageViewCaptcha.image = response_success;
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
    }];
}

#pragma mark - keyboard Methods

- (void)keyboardDidShow: (NSNotification *) notif{
    [self liftView];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    [self resetView];
}

-(void)resetView{
    _scrollViewBottomConstraint.constant = 4;
}

-(void) liftView{
    
    _scrollViewBottomConstraint.constant = [_keyBoardHeight integerValue];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void) keyboardWillChangeFrame:(NSNotification*)notification {
    
    NSDictionary* notificationInfo = [notification userInfo];
    CGRect keyboardFrame = [[notificationInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:[[notificationInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]
                          delay:0
                        options:[[notificationInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]
                     animations:^{
                         
                         _keyBoardHeight = [NSString stringWithFormat:@"%f",keyboardFrame.size.height];
                         [self liftView];
                     } completion:nil];
}
-(void)startSpinner{
    _spinner  = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    [kWindow addSubview:_spinner];
    [_spinner startLoader];
}

-(void)stopSpinner{
    [_spinner stopLoader];
    [_spinner removeFromSuperview];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if([_tfCaptcha isFirstResponder]){
        [self.view endEditing:YES];
        [self post];
    }
    return YES;
}

#pragma mark - Touches began
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //        _scrollViewBottomConstraint.constant =
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}
-(void)Alert:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}
#pragma mark - alert view delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - action BUtotn

- (IBAction)actionBTnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionBtnShare:(id)sender {
    
    if([_tfCaptcha.text isEqualToString:@""]){
        [super showAlert:@"Please enter Captcha"];
    }
    else{
        [self startSpinner];
        [self post];
    }
}
-(void)post{
    
    if([super internetWorking] == NO){
        [super showAlert:@"Please Check your internet connection"];
    }
    else{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    NSString *redditToken = [[NSUserDefaults standardUserDefaults] valueForKey:REDDIT_ACCESS_TOKEN];
    
    [dict setObject:_labelPost.text forKey:@"title"];
    [dict setObject:@"link" forKey:@"kind"];
    [dict setObject:@"painting" forKey:@"sr"];
    [dict setObject:[_tfCaptcha.text uppercaseString] forKey:@"captcha"];
    [dict setObject:_iden forKey:@"iden"];
    [dict setObject:@"json" forKey:@"api_type"];
    [dict setObject:_hm.strPostImage forKey:@"url"];
    [dict setObject:redditToken forKey:@"uh"];
    
    RedditModel *model = [[RedditModel alloc]init];
    [model sharePost :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        [self stopSpinner];
        if([[response_success valueForKeyPath:@"json.errors"] count] == 2){
            // Post after some time
            [super showAlert:[NSString stringWithFormat:[@"%@" capitalizedString],[[[response_success valueForKeyPath:@"json.errors"] objectAtIndex:1] objectAtIndex:1]]];
            _iden = [response_success valueForKeyPath:@"json.captcha"];
            [self loadImage];
        }
        else{
            if ([[response_success valueForKeyPath:@"json.data.name"] length] != 0 ){
                //  Posted Successfully
//                [self.navigationController popViewControllerAnimated:YES];
                [self Alert:@"Posted successfully on Reddit"];
                
            }
            else if([[[[response_success valueForKeyPath:@"json.errors"] objectAtIndex:0] objectAtIndex:1] isEqualToString:@"that link has already been submitted"]){
                // ALREADY SHARED
                [super showAlert:@"This painting is already shared."];
            }
            else if([[response_success valueForKeyPath:@"json.captcha"] length] != 0){
                // BAD CAPTCHA
                [super showAlert:@"Wrong Captcha"];
                _iden = [response_success valueForKeyPath:@"json.captcha"];
                [self loadImage];
            }
        }
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [self stopSpinner];
    }];
}

}

@end
