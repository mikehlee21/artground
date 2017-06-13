//
//  EditProfileVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 04/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "EditProfileVC.h"

@interface EditProfileVC ()

@end

@implementation EditProfileVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initialise];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self initialise];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAboutMeDetails:) name:@"about_me" object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - SELF MADE

-(void)initialise{
    _profileChanged = NO;
    _accessToken = TOKEN;
    _userID = UserID;
    
    _imageViewProflePic.layer.cornerRadius = self.imageViewProflePic.frame.size.width/2;
    _imageViewProflePic.layer.borderColor = [[UIColor colorWithRed:255/255.f green:0/255.f blue:90/255.f alpha:1]CGColor];
    _imageViewProflePic.layer.borderWidth = 3.0f;
    
    _strAboutme = @"Kunal Gupta";
    _userDetails = [[NSUserDefaults standardUserDefaults] valueForKey:UD_USER_INFO];
    _dictAPI = [[NSMutableDictionary alloc]init];
    
    if([[_userDetails valueForKey:@"profile_pic"] isEqualToString:@""]){
        _imageViewProflePic.image = kDefaultPic;
        _defaultPicSet = YES;
    }
    else{
        _profileChanged = YES;
        _defaultPicSet = NO;
        [_imageViewProflePic sd_setImageWithURL:[_userDetails valueForKey:@"profile_pic"] placeholderImage:kDefaultPic];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             _profilePicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_userDetails valueForKey:@"profile_pic"]]];
            NSLog(@"%@",_profilePicData);
        });
    }
    
    if([[_userDetails valueForKey:@"cover_pic"] length] == 0){
        [_dictAPI setObject:@"0" forKey:@"cov"];
    }
    else{
        [_dictAPI setObject:@"1" forKey:@"cov"];
    }
    
    [self.view layoutIfNeeded];
    _imageViewProflePic.layer.cornerRadius = _imageViewProflePic.frame.size.width/2;
    [_imageViewProflePic setClipsToBounds:YES];
    _viewProfilePic.layer.cornerRadius = _viewProfilePic.frame.size.width/2;
    [_viewProfilePic setClipsToBounds:YES];
    _viewProfilePic.layer.borderColor = [[UIColor colorWithRed:204/255.f green:205/255.f blue:206/255.f alpha:1]CGColor];
    _viewProfilePic.layer.borderWidth = 2.5;
    _viewTop.backgroundColor = kAppColor;
    
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    _arrCountry = [[NSMutableArray alloc] init];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *name = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [_arrCountry addObject:name];
    }
    [_arrCountry sortUsingSelector:@selector(localizedCompare:)];
    
    
    [_btnCountry setTitle:[_userDetails valueForKey:@"country"] forState:UIControlStateNormal];

 
    
    _tfName.text = [_userDetails valueForKey:@"name"];
    [_btnGender setTitle:[_userDetails valueForKey:@"gender"] forState:UIControlStateNormal];
    _tfEmail.text = [_userDetails valueForKey:@"email"];
    _strAboutme = [_userDetails valueForKey:@"about"];
    
    
    [self.imageViewProflePic sd_setImageWithURL:[NSURL URLWithString:[_userDetails valueForKey:@"profile_pic"]] placeholderImage:kDefaultPic];
    _strProfilePic = [_userDetails valueForKey:@"profile_pic"];
    _isProfilePicRemoved = NO;
    _keyBoardHeight = [[[NSUserDefaults standardUserDefaults] valueForKey:KEYBOARD_HEIGHT] floatValue];
    [self checkTabBar];
    
    if([_strShowCancel length] != 0){
        [_btnCancel setHidden:NO];
    }
    else{
        [_btnCancel setHidden:YES];
    }
}

-(void)checkTabBar{

    if ([[self tabBarController] isHidden]) {
        NSLog(@"tabBar IS HIDDEN");
        [_btnCancel setHidden:NO];
    }
    else{
        NSLog(@"tabBar IS VISIBLE");
        [_btnCancel setHidden:YES];
    }
}

-(void)getCountry:(NSString *)country{
    _strCountry = country;
    [_btnCountry setTitle:_strCountry forState:UIControlStateNormal];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict = [_userDetails mutableCopy];
    [dict setValue:_strCountry forKey:@"country"];
    [[NSUserDefaults standardUserDefaults] setValue:dict forKey:UD_USER_INFO];
}

-(void)getAboutMeDetails:(NSNotification *)noti{
    [self.view setUserInteractionEnabled:YES];
    NSLog(@"%@",[noti.userInfo valueForKey:@"text"]);
    _strAboutme = [noti.userInfo valueForKey:@"text"];
    [_btnAboutMe setTitle:_strAboutme forState:UIControlStateNormal];
    [self.view endEditing:YES];
}
-(void)startSpinner{
    _spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_spinner];
    [_spinner startLoader];
}
-(void)stopSpinner{
    [_spinner stopLoader];
    [_spinner removeFromSuperview];
}

-(void)hitUpdateWithImage{
    UserProfileModel *model = [[UserProfileModel alloc]init];
    [model updateProfileWithPic:_userID :_dictAPI :_profilePicData :YES :^(NSDictionary *response_success) {
        [self stopSpinner];
        NSLog(@"%@",response_success);
        if([[response_success valueForKey:@"success"] integerValue] == 1){
            [[NSUserDefaults standardUserDefaults] setValue:[response_success valueForKey:@"msg"] forKey:UD_USER_INFO];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if ([[response_success valueForKey:@"success"] integerValue] == 0){
            [super showAlert:[response_success valueForKey:@"msg"]];
        }
        else if([[response_success valueForKey:@"success"] integerValue] == 5){
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_TOKEN];
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_USER_INFO];
            [super logout:[response_success valueForKey:@"msg"] SegueIdentifier:@"EditProfileVC"];
        }
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [super showAlert:@"Something went wrong. Please try again"];
        [self stopSpinner];
    }];
}

-(void)hitUpdate{
    UserProfileModel *model = [[UserProfileModel alloc]init];
    [model updateProfile: _userID : _dictAPI:^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        if([[response_success valueForKey:@"success"] integerValue] == 1){
            [[NSUserDefaults standardUserDefaults] setValue:[response_success valueForKey:@"msg"] forKey:UD_USER_INFO];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if ([[response_success valueForKey:@"success"] integerValue] == 0){
            [super showAlert:[response_success valueForKey:@"msg"]];
        }
        else if([[response_success valueForKey:@"success"] integerValue] == 5){
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_TOKEN];
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_USER_INFO];
            [super logout:[response_success valueForKey:@"msg"] SegueIdentifier:@"EditProfileVC"];
        }
        [self stopSpinner];
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [super showAlert:@"Something went wrong. Please try again"];
        [self stopSpinner];
    }];

}


#pragma mark - Action Button

- (IBAction)actionBtnLogout:(id)sender {
    NSString *gmailToken = [[NSUserDefaults standardUserDefaults]valueForKey:UD_GMAIL_TOKEN];
    NSString *accessToken = TOKEN;
    NSString *userId = UserID;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
        
    if(gmailToken.length != 0){
        [[GIDSignIn sharedInstance] signOut];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_TOKEN];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_USER_INFO];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_GMAIL_TOKEN];
        [self performSegueWithIdentifier:@"EditProfileVC" sender:nil];
    }
    else{
        SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:spinner];
        [spinner startLoader];
    LoginRegisterationModel *model = [[LoginRegisterationModel alloc]init];
    [model logoutUser:userId :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
//        MessageTabVC *VC = [[MessageTabVC alloc]init];
//        [VC.timer invalidate];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_TOKEN];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_USER_INFO];
        [self performSegueWithIdentifier:@"EditProfileVC" sender:nil];
        [spinner stopLoader];
        [spinner removeFromSuperview];
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [spinner stopLoader];
        [spinner removeFromSuperview];
    }];
    }
}

- (IBAction)actionBtnGender:(id)sender {
    [self.view endEditing:YES];
    
    _actionGender = [[UIActionSheet alloc]initWithTitle:nil  delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Male",@"Female", nil];
    [_actionGender showInView:self.view];
}

- (IBAction)actionBtnAboutMe:(id)sender {
    [self.view endEditing:YES];
    
    AboutMeDetails *aboutme = [[AboutMeDetails alloc] initWithFrame:CGRectMake(0 ,0, self.view.frame.size.width, self.view.frame.size.height)];
    aboutme.center = self.view.center;
    aboutme.layer.borderWidth = 1.0;
    aboutme.layer.cornerRadius = 8.0;
    aboutme.textViewAboutMe.text = _strAboutme;
    [self.view addSubview:aboutme];
    
    [aboutme.textViewAboutMe becomeFirstResponder];
}

- (IBAction)actionBtnCountry:(id)sender {
    [self.view endEditing:YES];
    CountryVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryVC"];
    [VC getCountryArray :_arrCountry :_strCountry];
    VC.delegate = self;
    [self presentViewController:VC animated:YES completion:nil];
    
}

- (IBAction)actionBtnBack:(id)sender {
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionBtnSave:(id)sender {
    
    [self.view endEditing:YES];
    if([super internetWorking] == NO){
        [super showAlert:@"Please Check your internet connection"];
    }
    
    else if([_tfName.text isEqualToString:@""]){
        [super showAlert:@"Please enter your name"];
    }
    
    else if (_btnCountry.titleLabel.text.length == 0){
        [super showAlert:@"Please select your country"];
    }
    else if (_btnGender.titleLabel.text.length == 0){
        [super showAlert:@"Please select your gender"];
    }
    else if (_strAboutme.length == 0){
        [super showAlert:@"Please add about me"];
    }
    else{       
        [self startSpinner];
        [_dictAPI setObject:_strAboutme forKey:@"about"];
        [_dictAPI setObject:_btnGender.titleLabel.text forKey:@"gender"];
        [_dictAPI setObject:_btnCountry.titleLabel.text forKey:@"country"];
        [_dictAPI setObject:_accessToken forKey:@"access_token"];
        [_dictAPI setObject:_tfName.text forKey:@"name"];
        
        //if(_profileChanged == YES && _profilePicData != nil){
        if(_profilePicData != nil){
            
            [_dictAPI setObject:@"1" forKey:@"pic"];
            [self hitUpdateWithImage];
        }
        //else if (_profileChanged == YES){
        else {
            [_dictAPI setObject:@"0" forKey:@"pic"];
            [self hitUpdate];
        }
        
    }
}

- (IBAction)actionBtnEditDisplay:(id)sender {
    [self.view endEditing:YES];
    
    if(_defaultPicSet == YES){
        _actionCountry = [[UIActionSheet alloc]initWithTitle:@"Change Profile Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Library", nil];
    }
    else{
        _actionCountry = [[UIActionSheet alloc]initWithTitle:@"Change Profile Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Remove Current Photo" otherButtonTitles:@"Take Photo",@"Choose from Library", nil];
        
    }
    
    [_actionCountry showInView:self.view];
    
}

- (IBAction)actionBtnAppAboutMe:(id)sender {
    AboutMeApp *about = [[AboutMeApp alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andStr:@"bcsdb bfdsif bsadfbs ababdj fhsbadfh bsdhafbasdhk akshbfh sabfhbs hfbsd ahb fbaajnjasjfsjfbsak fbsf ksabfjks dafdbdjf sdfbjaskfbsas dfbsajkdfbaks jf;s"];
    about.center = self.view.center;
    about.layer.borderWidth = 1.0;
    about.layer.cornerRadius = 8.0;
    //    [about setStr2:@"dcsjadjakshdfjasdhfjkashbdfjasbdhjkfasdbc dsahd sabusad fbsjf asj basjba jdkfbsakjdfbsakj fasjdf sajdf nasjfnasjfnasdjfnadsjfnasj dfdasjfasdhfj adsfnas'f"];
    [self.view addSubview:about];
    
    
}

- (IBAction)actionBtnPrivacyPolicy:(id)sender {
    TermsAndConditionsVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsAndConditionsVC"];
    [self presentViewController:VC animated:YES completion:nil];
}

#pragma mark - textfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([_tfName isFirstResponder]){
        [_tfName resignFirstResponder];
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _scrollViewBottomConstraint.constant = _keyBoardHeight;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _scrollViewBottomConstraint.constant = 0;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    _scrollViewBottomConstraint.constant = 0;
}

#pragma mark - action Sheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(actionSheet == _actionCountry){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        if([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Remove Current Photo"]){
            _imageViewProflePic.image = kDefaultPic;
            _defaultPicSet = YES;
            _profileChanged = NO;
        }
        else if ([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"Take Photo"]){
            // open camera
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:NULL];
        }
        else if([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Choose from Library"]){
            // choose from library
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [NSArray arrayWithObjects : (NSString *) kUTTypeImage , nil];
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
    else if(actionSheet == _actionGender){
        NSString *str;
        if(buttonIndex == 0){
            [_btnGender setTitle:@"Male" forState:UIControlStateNormal];
            str = @"Male";
        }
        else if (buttonIndex == 1){
            [_btnGender setTitle:@"Female" forState:UIControlStateNormal];
            str = @"Female";
        }
    }
}

#pragma mark - imagePicker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        _imageViewProflePic.image = info[UIImagePickerControllerEditedImage];
        _strProfilePic = info[UIImagePickerControllerEditedImage];
        _imgSelectedImage = info[UIImagePickerControllerEditedImage];
        
        _profileChanged = YES;
        _profilePicData = UIImageJPEGRepresentation(_imageViewProflePic.image, 1.0);
        _defaultPicSet = NO;
        
    }];
}

- (IBAction)actionBtnBlockedUsers:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"BlockedUserVC"] animated:YES];
    
}
@end
