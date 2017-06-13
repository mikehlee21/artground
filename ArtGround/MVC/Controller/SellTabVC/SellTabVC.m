//
//  SellTabVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "SellTabVC.h"

@interface SellTabVC ()

@end

@implementation SellTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if(_hm){
        [self initUpdateView];
    }
    else{
        [self initialise];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    _arrCategory = [[NSMutableArray alloc]init];
    _arrCategory = [[UserInfo sharedUserInfo] arrCategories];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrames:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initialise{
    _viewTop.backgroundColor = kAppColor;
    if(_imageViewHeightConstraint.constant == kWindow.frame.size.width ){
        [_btnCross setHidden:NO];
    }
    else{
        [_btnCross setHidden:YES];
    }
    [_btnAdd setTitle:@"Add" forState:UIControlStateNormal];
    _labelHeading.text = @"ART LISTING";
//    [_btnBack setHidden:YES];
}

-(void)doneWithNumberPad{
    [self.view endEditing:YES];
    _scrollViewBottomConstraint.constant = 49;
    if(_tfPrice.text.length != 0){
    _tfPrice.text = [NSString stringWithFormat:@"$ %@.00",[NSString stringWithFormat:@"%d",[_tfPrice.text intValue]]];
    }
}
-(void)resetAll{
    _imageViewPost.image = [UIImage imageNamed:@"img_default"];
    _tfTitle.text = @"";
    _tfDescription.text = @"";
    _tfPrice.text = @"";
    [_btnBrowse setTitle:@"Browse" forState:UIControlStateNormal];
    [_btnCross setHidden:YES];
    [_btnBrowse setTitleColor:[UIColor colorWithRed:186/255.f green:186/255.f blue:186/255.f alpha:1] forState:UIControlStateNormal];
    
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
-(void)showAlert:(NSString *)message :(NSString *)title{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

#pragma mark - keyboard Methods
-(void)initUpdateView{
//    [_btnBack setHidden:NO];
    [_imageViewPost sd_setImageWithURL:[NSURL URLWithString:_hm.strPostImage] placeholderImage:kDefaultPic];
    _tfTitle.text = _hm.strTitle;
    _tfDescription.text = _hm.strDescription;
    _tfPrice.text = _hm.strPrice;
    
    [_btnBrowse setTitle:_hm.strCatName forState:UIControlStateNormal];
    _keyBoardHeight = [[NSUserDefaults standardUserDefaults] valueForKey:KEYBOARD_HEIGHT];
    _arrCategory = [[NSMutableArray alloc]init];
    _arrCategory = [[UserInfo sharedUserInfo] arrCategories];
    _viewTop.backgroundColor = kAppColor;
    [_btnAdd setTitle:@"Update" forState:UIControlStateNormal];
    _labelHeading.text = @"UPDATE LISTING";
    _scrollViewBottomConstraint.constant = 0;
    _strImage = _hm.strPostImage;
    [_btnBrowse setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _catID = _hm.strCategoryID;
        _imageViewHeightConstraint.constant = kWindow.frame.size.width;
}

- (void)keyboardDidShow: (NSNotification *) notif{
    [self liftView];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    [self resetView];
}

-(void)resetView{
    _scrollViewBottomConstraint.constant = 49;
}

-(void) liftView{
    
    _scrollViewBottomConstraint.constant = [_keyBoardHeight integerValue];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void) keyboardWillChangeFrames:(NSNotification*)notification {
    
    NSDictionary* notificationInfo = [notification userInfo];
    
    CGRect keyboardFrame = [[notificationInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:[[notificationInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]
                          delay:0
                        options:[[notificationInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]
                     animations:^{
                         
                         _keyBoardHeight = [NSString stringWithFormat:@"%f",keyboardFrame.size.height];
                         //                         [self liftView];
                     } completion:nil];
}
-(void)getModel:(HomeModel *)model{
    _hm = model;
}

#pragma mark - Textfield Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
  
    if([_tfPrice isFirstResponder]){
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320,50)];
        numberToolbar.barStyle = UIBarStyleDefault;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        _tfPrice.inputAccessoryView = numberToolbar;
        
        _tfPrice.text = [_tfPrice.text stringByReplacingOccurrencesOfString:@".00" withString:@""];
        _tfPrice.text = [_tfPrice.text stringByReplacingOccurrencesOfString:@"$ " withString:@""];
        
        _scrollViewBottomConstraint.constant = [_keyBoardHeight floatValue]+50;
    }
    else if ([_tfDescription isFirstResponder]){
          _scrollViewBottomConstraint.constant = [_keyBoardHeight floatValue];
    }
    
    else if ([_tfTitle isFirstResponder]){
        _scrollViewBottomConstraint.constant = [_keyBoardHeight floatValue];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(_hm){
        _scrollViewBottomConstraint.constant = 0;
    }
    else{
    _scrollViewBottomConstraint.constant = 49;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([_tfTitle isFirstResponder]){
        [_tfDescription becomeFirstResponder];
    }
    else if ([_tfDescription isFirstResponder]){
        [self.view endEditing:YES];
    }
    else if ([_tfPrice isFirstResponder]){
        
        [self.view endEditing:YES];
    }
    return YES;
}

#pragma mark - touches Began

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - imagePicker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        _imageViewPost.image = info[UIImagePickerControllerEditedImage];
         _imageViewHeightConstraint.constant = kWindow.frame.size.width;
//        _imageViewPost.alpha = 0.2;
        
//        [UIView animateWithDuration:1.2 animations:^{
//            _imageViewPost.alpha = 1.0;
//        }];
        _strImage = info[UIImagePickerControllerEditedImage];
        [_btnCross setHidden:NO];
    }];
    
}

#pragma mark - action sheet delagate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet == _actionPhoto) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        if (buttonIndex == 0){
            // open camera
                        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                        [self presentViewController:picker animated:YES completion:NULL];
        }
        else if(buttonIndex == 1){
            // choose from library
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [NSArray arrayWithObjects : (NSString *) kUTTypeImage , nil];
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
    else if (actionSheet == _actionCategories){
        if(![[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Cancel"]){
        [_btnBrowse setTitle:[actionSheet buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
            _catID = [[[UserInfo sharedUserInfo] arrCatID] objectAtIndex:buttonIndex-1];
            [_btnBrowse setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        NSLog(@"%@",_catID);
    }
    
}

#pragma mark - alertView delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%lu",(long)buttonIndex);
    
    if([_addNew isEqualToString:@"0"]){
        [self.delegate getPostDetails:_shiftHomeModel];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else if ([_addNew isEqualToString:@"1"]){

        SingleItemCategoryDetail *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleItemCategoryDetail"];
        [VC getModel:_shiftHomeModel];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

#pragma mark - Action Button

- (IBAction)actionBtnAdd:(id)sender {
    
    [self.view endEditing:YES];
    NSString *strPrice = [_tfPrice.text stringByReplacingOccurrencesOfString:@".00" withString:@""];
    strPrice = [strPrice stringByReplacingOccurrencesOfString:@"$ " withString:@""];

    
    if(_strImage == nil){
        [super showAlert:@"Please upload an Art Image"];
    }
    else if ([[_tfTitle.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] isEqualToString:@""]){
                    [super showAlert:@"Please enter atleast 1 character and a maximum of 30 characters"];
    }
    else if ([[_tfDescription.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] isEqualToString:@""]){
        [super showAlert:@"Please enter description with atleast 1 character and a maximum of 30 characters"];
    }
    else if (_tfDescription.text.length > 200){
        [super showAlert:@"Please enter description with atleast 1 character and a maximum of 30 characters"];
    }
    else if ([_btnBrowse.titleLabel.text isEqualToString:@"Browse"]){
                [super showAlert:@"Please select a category"];
    }
    else if ([_tfPrice.text isEqualToString:@""]){
                [super showAlert:@"Minimum selling price is $1.00 and maximum selling price is $500.00."];
    }
    else if ([strPrice integerValue] == 0 || [strPrice integerValue] > 500){
        [super showAlert:@"Minimum selling price is $1.00 and maximum selling price is $500.00."];
    }
    
    else{
        
        [self startSpinner];
        
        NSString *userID = UserID;
        NSData *profilePicData = UIImageJPEGRepresentation(_imageViewPost.image, 0.3);
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        NSString *accessToken = [[NSUserDefaults standardUserDefaults]valueForKey:UD_TOKEN];
        
        [dict setObject:accessToken forKey:@"access_token"];
        [dict setObject:_tfTitle.text forKey:@"title"];
        [dict setObject:_catID forKey:@"category_id"];
        [dict setObject:strPrice forKey:@"price"];
        [dict setObject:_tfDescription.text forKey:@"description"];
        
        PostActivityModel *model = [[PostActivityModel alloc]init];
        // updating Art
        if(_hm){
            
            [model updateArt:userID :_hm.strArtID :profilePicData :YES :dict :^(NSDictionary *response_success) {
                [self stopSpinner];
                _imageViewHeightConstraint.constant = 150;
                HomeModel *model = [HomeModel new];
                _shiftHomeModel = [HomeModel new];
                _shiftHomeModel = [model initWithAttribute:[response_success valueForKey:@"art"]];
                [self showAlert:@"Your art has been successfully updated." :@"Notification"];
                _addNew = @"0";
            } :^(NSError *response_error) {
                NSLog(@"%@",response_error);
                [self stopSpinner];
                [super showAlert:@"Something went wrong, Please try again"];
            }];
        }
        // Adding Art
        else{
            [dict setObject:@"1" forKey:@"count"];

        [model postArt:userID :dict :profilePicData :YES :^(NSDictionary *response_success) {
            [self resetAll];
            NSLog(@"%@",response_success);
            [self stopSpinner];
            _imageViewHeightConstraint.constant = 150;
            if([[response_success valueForKey:@"success"] integerValue] == 1){
                HomeModel *model = [HomeModel new];
                _shiftHomeModel = [HomeModel new];
                _shiftHomeModel = [model initWithAttribute:[response_success valueForKey:@"art"]];
                
                [self showAlert:@"Your art has been successfully listed." :@"Notification"];
                _addNew = @"1";

            }
        } :^(NSError *response_error) {
            [self stopSpinner];
            NSLog(@"%@",response_error);
            [super showAlert:@"Something went wrong, Please try again"];
        }];
        
    }
    }
}

- (IBAction)actionBtnUpload:(id)sender {
    [self.view endEditing:YES];
    _actionPhoto = [[UIActionSheet alloc]initWithTitle:@"Upload Artwork image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Library", nil];
    [_actionPhoto showInView:self.view];
    
}

- (IBAction)actionBtnCross:(id)sender {
    [_btnCross setHidden:YES];
    _imageViewPost.image = [UIImage imageNamed:@"img_default"];
    _strImage = nil;
    _imageViewHeightConstraint.constant = 150;
}

- (IBAction)actionBtnBrowse:(id)sender {
    [self.view endEditing:YES];
    _actionCategories = [[UIActionSheet alloc]initWithTitle:@"Choose an action: " delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    
    for (NSString * buttonTitle in _arrCategory) {
        
        [_actionCategories addButtonWithTitle:buttonTitle];
    }
     [_actionCategories showInView:self.view];
}
- (IBAction)actionBtnBack:(id)sender{
    
    _strImage = NULL;
    _imageViewPost.image = NULL;
    
    [_btnCross setHidden:YES];
    _imageViewPost.image = [UIImage imageNamed:@"img_default"];
    _strImage = nil;
    _imageViewHeightConstraint.constant = 150;

    _tfTitle.text = @"";
    _tfDescription.text = @"";
    [_btnBrowse setTitle: @"Browse" forState:UIControlStateNormal];
     _tfPrice.text = @"";
    
    if(_hm){
    [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"popTabBarController" object:nil];
    }
    
}
@end
