//
//  LoginVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialise];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GmailLogin:) name:@"gmail_login" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - Self made

-(void)stoploader{
    [_spinner stopLoader];
    [_spinner removeFromSuperview];
    
}
-(void)startLoader{
    _spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_spinner];
//    [self.view addSubview:_spinner];
    [_spinner startLoader];

}
-(void)GmailLogin:(NSNotification *)noti{
//    [self startLoader];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:UD_DEVICE_TOKEN];
    if(token == nil){
        token = @"0fcdd78caf66f2cf62e8d1fee31ad6fb0e7a6bb01d006b73c153d9931fd9dbd2";
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [[NSUserDefaults standardUserDefaults] setObject:[noti.userInfo valueForKey:@"userID"] forKey:UD_GMAIL_TOKEN];
    [dict setObject:[noti.userInfo valueForKey:@"userID"] forKey:@"gmail_id"];
    [dict setObject:[noti.userInfo valueForKey:@"name"] forKey:@"name"];
    [dict setObject:[noti.userInfo valueForKey:@"email"] forKey:@"gemail"];
    [dict setObject:token forKey:@"mobileid"];
    
    LoginRegisterationModel *login = [[LoginRegisterationModel alloc]init];
//    [login loginUser:dict :^(NSDictionary *response_success) {
//        [self stoploader];
//        NSLog(@"%@",response_success);
//        if([[response_success valueForKey:@"success"] integerValue] == 1){
//            [[NSUserDefaults standardUserDefaults] setObject:[response_success valueForKey:@"user"] forKey:UD_USER_INFO];
//            [[NSUserDefaults standardUserDefaults] setObject:[response_success valueForKeyPath:@"user.access_token"] forKey:UD_TOKEN];
//            
//            TabBarControllerVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarControllerVC"];
//            [self.navigationController pushViewController:VC animated:YES];
//        }
//        else{
//            [super showAlert:[response_success valueForKey:@"msg"]];
//        }
//    } :^(NSError *response_error) {
//        [self stoploader];
//        NSLog(@"%@",response_error);
//    }];
    
    NSData *data = [NSData dataWithContentsOfURL:[noti.userInfo valueForKey:@"image"]];
    
    [self loginAPIWithImage:dict :data];
}

-(void)initialise{
//    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:UD_TOKEN];
    self.shareOnFacebook = false;
    _login = [[FBSDKLoginManager alloc]init];
    [_login logOut];
    
    
    _viewTop.backgroundColor = kAppColor;
    NSString *accessToken = [[NSUserDefaults standardUserDefaults ]valueForKey:UD_TOKEN];
    if(accessToken != nil){
        TabBarControllerVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarControllerVC"];
        [self.navigationController pushViewController:VC animated:NO];
    }
    [GIDSignIn sharedInstance].uiDelegate = self;

    [self.tfEmail setValue:[UIColor colorWithRed:122/255.f green:123/255.f blue:124/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.tfPassword setValue:[UIColor colorWithRed:122/255.f green:123/255.f blue:124/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_btnSignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
     _keyBoardHeight = 216;
}

- (void)keyboardWasShown:(NSNotification *)notification{
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    int height;
    
    height = MIN(keyboardSize.height,keyboardSize.width);
    NSString* KeyBoardHeight = [NSString stringWithFormat:@"%i", height];
    
    [[NSUserDefaults standardUserDefaults] setObject:KeyBoardHeight forKey:KEYBOARD_HEIGHT];
    _keyBoardHeight = [KeyBoardHeight floatValue];
   
}

#pragma mark - Gmail


- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    //    [myActivityIndicator stopAnimating];
    
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
    [self stoploader];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self startLoader];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user    withError:(NSError *)error {
    // Perform any operations on signed in user here.
    //    NSString *userId = user.userID;                  // For client-side use only!
    //    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    //    NSString *name = user.profile.name;
    //    NSString *email = user.profile.email;
    // ...
}
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}


#pragma  mark - Textfield Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _scrollViewBottomConstraint.constant = _keyBoardHeight;
    if([_tfEmail isFirstResponder ]){
        [_imageViewEmail setHighlighted:YES];
        [_imageViewPassword setHighlighted:NO];
    }
    else{
        [_imageViewEmail setHighlighted:NO];
        [_imageViewPassword setHighlighted:YES];
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    _scrollViewBottomConstraint.constant = 0;
    [_imageViewEmail setHighlighted:NO];
    [_imageViewPassword setHighlighted:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if([_tfEmail isFirstResponder]){
        [_tfPassword becomeFirstResponder];
        [_imageViewEmail setHighlighted:NO];
        [_imageViewPassword setHighlighted:YES];
    }
    else if ([_tfPassword isFirstResponder ]){
        [self.view endEditing:YES];
        [_imageViewEmail setHighlighted:NO];
        [_imageViewPassword setHighlighted:NO];
    }
    
    return YES;
}

#pragma mark - touches Began

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.contentView endEditing:YES];
    [_imageViewEmail setHighlighted:NO];
    [_imageViewPassword setHighlighted:NO];

}
#pragma mark - alertview delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    [self.view endEditing:YES];
    if(buttonIndex == 1){
        if([[alertView textFieldAtIndex:0].text isEqualToString:@""]){
            [super showAlert:@"Enter a Email ID"];
        }
        else{
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:[alertView textFieldAtIndex:0].text forKey:@"email"];
        LoginRegisterationModel *model = [[LoginRegisterationModel alloc]init];
        SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:spinner];
        [spinner startLoader];
        [model forgotPassword:dict :^(NSDictionary *response_success) {
            NSLog(@"%@",response_success);
            [spinner stopLoader];
            [spinner removeFromSuperview];
            [super showAlert:[response_success valueForKey:@"msg"]];
        } :^(NSError *response_error) {
            [spinner stopLoader];
            [spinner removeFromSuperview];
            NSLog(@"%@",response_error);
        }];
        }
    }

}

#pragma mark - LOGIN API WITH IMAGE

-(void)loginAPIWithImage:(NSMutableDictionary *)dict :(NSData *)data{
    
    LoginRegisterationModel *login = [[LoginRegisterationModel alloc]init];

    [login loginUserWithImage:dict :data :^(NSDictionary *response_success) {
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        NSLog(@"%@",response_success);
        if([[response_success valueForKey:@"success"] integerValue] == 1){
            [[NSUserDefaults standardUserDefaults] setObject:[response_success valueForKey:@"user"] forKey:UD_USER_INFO];
            [[NSUserDefaults standardUserDefaults] setObject:[response_success valueForKeyPath:@"user.access_token"] forKey:UD_TOKEN];
            
            TabBarControllerVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarControllerVC"];
            [self.navigationController pushViewController:VC animated:YES];
        }
        else{
            [super showAlert:[response_success valueForKey:@"msg"]];
        }
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        [super showAlert:@"Something went wrong.Please try again"];
        
    }];
}


#pragma mark - Action Button

- (IBAction)actionBtnForgotPassword:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset Password"
                                                    message:@"Please enter your email"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField* tf = [alert textFieldAtIndex:0];
    tf.keyboardType = UIKeyboardTypeEmailAddress;
    [alert show];

}

- (IBAction)actionBtnSignin:(id)sender {
    [self.view endEditing:YES];
    _strEmail = [_tfEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _strPassword = _tfPassword.text;
    
    if([super internetWorking] == NO){
        [super showAlert:@"Please Check your internet connection"];
    }

    else if([_strEmail isEqualToString:@""]){
        _alertMessage = @"Please enter your email";
        [super showAlert:_alertMessage];
    }
    else if ([_strPassword isEqualToString:@""]){
        _alertMessage = @"Please enter your password";
        [super showAlert:_alertMessage];
    }
    else{
  
        _spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_spinner];
        [_spinner startLoader];
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:UD_DEVICE_TOKEN];
        if(token == nil){
            token = @"0fcdd78caf66f2cf62e8d1fee31ad6fb0e7a6bb01d006b73c153d9931fd9dbd2";
        }
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:_strEmail forKey:@"email"];
        [dict setObject:_strPassword forKey:@"password"];
        [dict setObject:token forKey:@"mobileid"];
        
        LoginRegisterationModel *login = [[LoginRegisterationModel alloc]init];
        [login loginUser:dict :^(NSDictionary *response_success) {
            [_spinner stopLoader];
            [_spinner removeFromSuperview];
            NSLog(@"%@",response_success);
            if([[response_success valueForKey:@"success"] integerValue] == 1){
                [[NSUserDefaults standardUserDefaults] setObject:[response_success valueForKey:@"user"] forKey:UD_USER_INFO];
                 [[NSUserDefaults standardUserDefaults] setObject:[response_success valueForKeyPath:@"user.access_token"] forKey:UD_TOKEN];
                
                TabBarControllerVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarControllerVC"];
                [self.navigationController pushViewController:VC animated:YES];
                            }
            else{
                [super showAlert:[response_success valueForKey:@"msg"]];
            }
        } :^(NSError *response_error) {
            NSLog(@"%@",response_error);
            [_spinner stopLoader];
            [_spinner removeFromSuperview];
        }];
    }
    
}

- (IBAction)actionBtnSignUp:(id)sender {
    SignUpVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpVC"];
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)actionBtnFbLogin:(id)sender {
    

//    [self loginWithFacebook:^(BOOL completed) {
//        [self loginWithFB];
//    } failure:^(NSError *error) {
//        
//    }];
    [_login logInWithReadPermissions: @[@"public_profile",@"email"] fromViewController:self handler:^
     (FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         }
         else if (result.isCancelled) {
             NSLog(@"Cancelled");
         }
         else {
             NSLog(@"Logged in");
//             [super showLoader];
             _spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
             [[[[UIApplication sharedApplication] delegate] window] addSubview:_spinner];
             [_spinner startLoader];
             
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id,email,gender,name,hometown,first_name,picture.width(100).height(100)"}]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if (!error) {
//                          [super hideLoader];
//                          _dictAPI = [NSMutableDictionary new];
//                          [_dictAPI setObject:[[FBSDKAccessToken currentAccessToken] userID] forKey:@"fb_id"];
//                          [_dictAPI setObject:[result valueForKeyPath:@"picture.data.url"] forKey:@"fb_image"];
//                          [_dictAPI setObject:[result valueForKeyPath:@"name"] forKey:@"name"];
//                          
////                          [self pushToSetUpProfile:_dictAPI];
                          NSLog(@"fetched user:%@", result);
//                          NSLog(@"%@",result[@"email"]);
                          NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:UD_DEVICE_TOKEN];
                          if(token == nil){
                              token = @"0fcdd78caf66f2cf62e8d1fee31ad6fb0e7a6bb01d006b73c153d9931fd9dbd2";
                          }
                          _faceBookID = [result valueForKey:@"id"];
                          NSURL *imageURL = [NSURL URLWithString:[result valueForKeyPath:@"picture.data.url"]];

                          
                          NSError* error = nil;
                          NSData* data = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
                          if (error) {
                              NSLog(@"%@", [error localizedDescription]);
                          } else {
                              NSLog(@"Data has loaded successfully.");
                          }
                          
                          
                          NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                          [dict setObject:_faceBookID forKey:@"facebook_id"];
                          [dict setObject:token forKey:@"mobileid"];
                          [dict setObject:[result valueForKey:@"email"] forKey:@"femail"];
                          [dict setObject:[result valueForKey:@"name"] forKey:@"name"];
                          
                         [self loginAPIWithImage:dict :data];
                      }
                      else{
                          [_spinner stopLoader];
                          [_spinner removeFromSuperview];
                          [super showAlert:@"Something went wrong"];
                      }
                  }];
             }
         }
     }];
    
}


- (IBAction)actionBtnGmailLogin:(id)sender {
    [self startLoader];
    [[GIDSignIn sharedInstance] signIn];
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue{
    NSLog(@"Success");
    _tfEmail.text = @"";
    _tfPassword.text = @"";
    [self.view endEditing:YES];
//

}

-(void)loginWithFacebook:(void (^) (BOOL completed))success failure: (void (^) (NSError* error))failure{
   if (self.shareOnFacebook) {
        self.shareOnFacebook = NO;
        success(YES);
    }
    else{
        if ([FBSDKAccessToken currentAccessToken] && [[[[FBSDKAccessToken currentAccessToken] permissions] allObjects] containsObject:@"publish_actions"]) {
            self.shareOnFacebook = YES;
            success(YES);
        }
        else{
            if (![FBSDKAccessToken currentAccessToken]){
                
                [_login logInWithReadPermissions:@[@"public_profile",@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                    if (error) {
                        // Process error
                        NSLog(@"%@",[error localizedDescription]);
                        failure(error);
                    }
                    else if (result.isCancelled) {
//                        [_btnFacebook setHidden:NO];
//                        [_spinner stopAnimating];
                        [self showAlert:@"You cancelled the facebook authorization"];
                        failure(error);
                    }
                    else {
                        // If you ask for multiple permissions at once, you
                        // should check if specific permissions missing
                        
                        if ([result.grantedPermissions containsObject:@"publish_actions"]) {
                            // Do work
                            self.shareOnFacebook = YES;
                            success(YES);
                        }
                        else{
                            [self loginWithFacebook:^(BOOL completed) {
                                success(YES);
                                
                            } failure:^(NSError *error) {
                                failure(error);
                            }];
                            return;
                        }
                    }
                }];
                
                return;
            }
            
            [_login logInWithPublishPermissions:@[@"publish_actions"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                
                if (error) {
                    // Process error
//                    [[FBSDKLoginManager new] logOut];
                    failure(error);
                } else if (result.isCancelled) {
                    // Handle cancellations
                    failure(error);
                } else {
                    // If you ask for multiple permissions at once, you
                    // should check if specific permissions missing
                    if ([result.grantedPermissions containsObject:@"publish_actions"]) {
                        // Do work
                        self.shareOnFacebook = YES;
                        success(YES);
                    }
                    else{
//                        [[FBSDKLoginManager new] logOut];
//                        [_btnFacebook setHidden:NO];
//                        [_spinner stopAnimating];
//                        [self showAlertBox:nil :@"Please Allow Email Permission On Facebook"];
                        failure(error);
                    }
                }
                
            }];
        }
    }
}

@end
