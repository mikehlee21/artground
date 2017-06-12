//
//  UpdateArtVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 30/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "UpdateArtVC.h"

@interface UpdateArtVC ()

@end

@implementation UpdateArtVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initiaizse];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - self made

-(void)getModel:(HomeModel *)model{
    
    _hm = model;
}
-(void)initiaizse{

    [_imageViewPost sd_setImageWithURL:[NSURL URLWithString:_hm.strPostImage] placeholderImage:kDefaultPic];
    _tfTitle.text = _hm.strTitle;
    _tfDescription.text = _hm.strDescription;
    _tfPrice.text = _hm.strPrice;
    
    [_btnBrowse setTitle:_hm.strCatName forState:UIControlStateNormal];
    _keyBoardHeight = [[[NSUserDefaults standardUserDefaults] valueForKey:KEYBOARD_HEIGHT] floatValue];
    _arrCategory = [[NSMutableArray alloc]init];
    _arrCategory = [[UserInfo sharedUserInfo] arrCategories];
    _viewTop.backgroundColor = kAppColor;
}

-(void)doneWithNumberPad{
    [self.view endEditing:YES];
    _scrollViewBottomConstraint.constant = 0;
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
        
        _scrollViewBottomConstraint.constant = _keyBoardHeight+50;
    }
    else if ([_tfDescription isFirstResponder]){
        _scrollViewBottomConstraint.constant = _keyBoardHeight;
    }
    
    else if ([_tfTitle isFirstResponder]){
        _scrollViewBottomConstraint.constant = _keyBoardHeight;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    _scrollViewBottomConstraint.constant = 0;
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
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        _imageViewPost.image = info[UIImagePickerControllerEditedImage];
        _imageViewPost.alpha = 0.2;
        
        [UIView animateWithDuration:1.2 animations:^{
            _imageViewPost.alpha = 1.0;
        }];
        
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
        }
        NSLog(@"%@",_catID);
    }
    
}
#pragma  mark - action button

- (IBAction)actionBtnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionBtnUpload:(id)sender {
    [self.view endEditing:YES];
    _actionPhoto = [[UIActionSheet alloc]initWithTitle:@"Choose an action: " delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Library", nil];
    [_actionPhoto showInView:self.view];

}
- (IBAction)actionBtnBrowse:(id)sender {
    [self.view endEditing:YES];
    _actionCategories = [[UIActionSheet alloc]initWithTitle:@"Choose an action: " delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    
    
    for (NSString * buttonTitle in _arrCategory) {
        
        [_actionCategories addButtonWithTitle:buttonTitle];
    }
    [_actionCategories showInView:self.view];


}
- (IBAction)actionBtnCross:(id)sender {
    [_btnCross setHidden:YES];
    _imageViewPost.image = [UIImage imageNamed:@"img_default"];
    _strImage = nil;
}

- (IBAction)actionBtnUpdate:(id)sender {
    [self.view endEditing:YES];
//    if(_strImage == nil){
//        [super showAlert:@"Please add an Image"];
//    }
//    else
        if ([[_tfTitle.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] isEqualToString:@""]){
        [super showAlert:@"Please add a title"];
    }
    else if ([[_tfDescription.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] isEqualToString:@""]){
        [super showAlert:@"Please add a description"];
    }
    else if ([_btnBrowse.titleLabel.text isEqualToString:@"Browse"]){
        [super showAlert:@"Please select a category"];
    }
    else if ([_tfPrice.text isEqualToString:@""]){
        [super showAlert:@"Please enter the price"];
    }
    else{
        SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
        [kWindow addSubview:spinner];
        [spinner startLoader];
        
        NSString *userID = UserID;
        NSData *profilePicData = UIImagePNGRepresentation(_imageViewPost.image);
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        NSString *accessToken = [[NSUserDefaults standardUserDefaults]valueForKey:UD_TOKEN];
        
        [dict setObject:accessToken forKey:@"access_token"];
        [dict setObject:_tfTitle.text forKey:@"title"];
        [dict setObject:_catID forKey:@"category"];
        [dict setObject:_tfPrice.text forKey:@"price"];
        [dict setObject:_tfDescription.text forKey:@"description"];
//        [dict setObject:@"1" forKey:@"count"];
        
        PostActivityModel *model = [[PostActivityModel alloc]init];
        
       [model updateArt:userID :_hm.strArtID :profilePicData :YES :dict :^(NSDictionary *response_success) {
           NSLog(@"%@",response_success);
           [spinner stopLoader];
                       [spinner removeFromSuperview];
           [self.navigationController popViewControllerAnimated:YES];
       } :^(NSError *response_error) {
           NSLog(@"%@",response_error);
           [spinner stopLoader];
           [spinner removeFromSuperview];
       }];
        
    }

}
@end
