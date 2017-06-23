//
//  LoginVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "SignUpVC.h"

@interface SignUpVC ()

@end

@implementation SignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Self Made

-(void)unHighlightAll{
        [_imageViewName setHighlighted:NO];
        [_imageViewPassword setHighlighted:NO];
        [_imageViewGender setHighlighted:NO];
        [_imageViewEmail setHighlighted:NO];
        [_imageViewCountry setHighlighted:NO];
        [_imageViewConfirmPassword setHighlighted:NO];
}

-(void)initialize{
    _viewTop.backgroundColor = kAppColor;
    [self.tfEmail setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:.7] forKeyPath:@"_placeholderLabel.textColor"];
    [self.tfConfirmPassword setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:.7] forKeyPath:@"_placeholderLabel.textColor"];
    [self.tfPassword setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:.7] forKeyPath:@"_placeholderLabel.textColor"];
    [self.tfName setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:.7] forKeyPath:@"_placeholderLabel.textColor"];
    
    _strIPAddress = [self getIPAddress];
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
   
    _arrCountry = [[NSMutableArray alloc] init];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *name = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [_arrCountry addObject:name];
    }
    
    [_arrCountry sortUsingSelector:@selector(localizedCompare:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
   
    _keyBoardHeight = [[[NSUserDefaults standardUserDefaults] valueForKey:KEYBOARD_HEIGHT] floatValue];
    _keyBoardHeight = 216;
    _dictAPI = [[NSMutableDictionary alloc]init];

 }


-(void)getCountry:(NSString *)country{
    _strCountry = country;
    [_btnCountry setTitle:_strCountry forState:UIControlStateNormal];
    [_dictAPI setObject:_strCountry forKey:@"country"];

}

-(BOOL)NSStringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)keyboardWasShown:(NSNotification *)notification{
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    int height;

    height = MIN(keyboardSize.height,keyboardSize.width);
    NSString* KeyBoardHeight = [NSString stringWithFormat:@"%i", height];
    
    [[NSUserDefaults standardUserDefaults] setObject:KeyBoardHeight forKey:KEYBOARD_HEIGHT];
}

- (NSString *)getIPAddress{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

-(void)getTextFieldImages{
    
    if([_tfEmail isFirstResponder]){
        [self unHighlightAll];
        [_imageViewEmail setHighlighted:YES];
    }
    else if ([_tfConfirmPassword isFirstResponder]){
        [self unHighlightAll];
        [_imageViewConfirmPassword setHighlighted:YES];
    }
    else if ([_tfName isFirstResponder]){
        [self unHighlightAll];
        [_imageViewName setHighlighted:YES];
    }
    else if ([_tfPassword isFirstResponder]){
        [self unHighlightAll];
        [_imageViewPassword setHighlighted:YES];
    }

}

#pragma mark - touches Began

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.contentView endEditing:YES];
    _scrollViewBottomConstraint.constant = 0;
    [self unHighlightAll];
}

#pragma mark - action Sheet Delagate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        [_btnGender setTitle:@"Male" forState:UIControlStateNormal];
        [_dictAPI setObject:_btnGender.titleLabel.text forKey:@"gender"];
    }
    else if (buttonIndex == 1){
        [_btnGender setTitle:@"Female" forState:UIControlStateNormal];
        [_dictAPI setObject:_btnGender.titleLabel.text forKey:@"gender"];
  }
    
    [_imageViewGender setHighlighted:NO];
}

#pragma mark - TEXTFIELD DELEGATE

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_tfEmail isFirstResponder]) {
        [_tfPassword becomeFirstResponder];
      
    }
    else if ([_tfPassword isFirstResponder]){
        [_tfConfirmPassword becomeFirstResponder];
    }
    else if ([_tfConfirmPassword isFirstResponder]){
        [_tfName becomeFirstResponder];
    }
    else if ([_tfName isFirstResponder]){
        [self.contentView resignFirstResponder];
        [self.view endEditing:YES];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _scrollViewBottomConstraint.constant = _keyBoardHeight;
    [self getTextFieldImages];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    _scrollViewBottomConstraint.constant = 0;
    [self unHighlightAll];
}

#pragma mark - Action Button methods

- (IBAction)actionBtnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionBtnT:(id)sender {
     TermsAndConditionsVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsAndConditionsVC"];
        //[self presentViewController:VC animated:YES completion:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)actionBtnCountry:(id)sender {
    CountryVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryVC"];
    [VC getCountryArray:_arrCountry:_strCountry];
    VC.delegate = self;
    [self presentViewController:VC animated:YES completion:nil];
    
}

- (IBAction)actionBtnSignUp:(id)sender {
   

    _strEmail = [_tfEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _strPassword = _tfPassword.text;
    _strConfirmPassword = _tfConfirmPassword.text;
    _strName = [_tfName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _strCountry = _btnCountry.titleLabel.text;
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "];
    set = [set invertedSet];
    NSRange range = [_tfName.text rangeOfCharacterFromSet:set];
    
    if([super internetWorking] == NO){
         [super showAlert:@"Please Check your internet connection"];
    }
    else if ([_strEmail isEqualToString:@""]){
        _alertMessage = @"Please enter your EmailID";
        [super showAlert:_alertMessage];
    }
    else if(![self NSStringIsValidEmail:_strEmail]){
        _alertMessage = @" Please enter a valid Email";
        [super showAlert:_alertMessage];
    }
    else if ([_strPassword isEqualToString:@""]){
        _alertMessage = @"Please enter password";
        [super showAlert:_alertMessage];
    }
    else if (_strPassword.length <6){
        _alertMessage = @"Password must be atleat 6 chacters long";
        [super showAlert:_alertMessage];
        
    }
    else if ([_strConfirmPassword isEqualToString:@""]){
        _alertMessage = @"Please confirm your password";
        [super showAlert:_alertMessage];
    }
    else if (![_strConfirmPassword isEqualToString:_strPassword]){
        _alertMessage = @"Passwords do not match";
        [super showAlert:_alertMessage];
        
    }
    else if([_strName isEqualToString:@""]){
        _alertMessage = @"Please enter your name";
        [super showAlert:_alertMessage];
    }
    else  if (range.location != NSNotFound) {
        _alertMessage = @"Name contains invalid characters.";
        [self showAlert:_alertMessage];
    }
    else  if (![_btnAgree isSelected]) {
        _alertMessage = @"Please agree to terms of conditions";
        [self showAlert:_alertMessage];
    }
//    else if (_strCountry.length == 0){
//        _alertMessage = @"Please select your country";
//        [super showAlert:_alertMessage];
//    }
//    else if (_strGender.length == 0){
//        _alertMessage = @"Please select your gender";
//        [super showAlert:_alertMessage];
//    }
   
   else{
        
       SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];

        [[[[UIApplication sharedApplication] delegate] window] addSubview:spinner];
            [spinner startLoader];
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:UD_DEVICE_TOKEN];
       if([token length] == 0){
           token = @"0fcdd78caf66f2cf62e8d1fee31ad6fb0e7a6bb01d006b73c153d9931fd9dbd2";
       }
        [_dictAPI setObject:_strIPAddress forKey:@"ip_address"];
        [_dictAPI setObject:_strEmail forKey:@"email"];
        [_dictAPI setObject:_strPassword forKey:@"password"];
        [_dictAPI setObject:_strConfirmPassword forKey:@"password_confirmation"];
        [_dictAPI setObject:_strName forKey:@"name"];
        [_dictAPI setObject:token forKey:@"mobileid"];
        
        LoginRegisterationModel *model = [[LoginRegisterationModel alloc]init];
        [model registerUser:_dictAPI :^(NSDictionary *response_success) {
            NSLog(@"%@",response_success);
            [spinner stopLoader];
            [spinner removeFromSuperview];
            if([[response_success valueForKey:@"success"] integerValue] == 1){
                //Handle here
                
                [[NSUserDefaults standardUserDefaults] setObject:[response_success valueForKey:@"user"] forKey:UD_USER_INFO];
                [[NSUserDefaults standardUserDefaults] setObject:[response_success valueForKeyPath:@"user.access_token"] forKey:UD_TOKEN];
                
                TabBarControllerVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarControllerVC"];
                [self.navigationController pushViewController:VC animated:YES];
            }
            else{
                _alertMessage = [response_success valueForKey:@"msg"];
                [super showAlert:_alertMessage];
                
            }
        } :^(NSError *response_error) {
            NSLog(@"%@",response_error);
            [spinner stopLoader];
            [spinner removeFromSuperview];
        }];
    }
}

- (IBAction)actionBtnGender:(id)sender {
    
  UIActionSheet * actionGender = [[UIActionSheet alloc]initWithTitle:nil  delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Male",@"Female", nil];
    [actionGender showInView:self.view];
    [_imageViewGender setHighlighted:YES];
}

- (IBAction)actionBtnIAgree:(id)sender {
    [_btnAgree setSelected:![_btnAgree isSelected]];
}
- (IBAction)actionBtnAgree:(id)sender {
    [_btnAgree setSelected:![_btnAgree isSelected]];
}

@end
