 //
//  UserProfileVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 21/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "UserProfileVC.h"

@interface UserProfileVC ()

@end

@implementation UserProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialiseUI];
    
    if(_artistID){
        [self getuserDetails];
    }
    else{
        [self initialise];
    }
    [self.tagListMedia.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    [self.tagListSpecialization.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld context:NULL];
        [self.tagListTags.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld context:NULL];
}
-(void)dealloc{
    
    [self.tagListMedia.collectionView removeObserver:self forKeyPath:@"contentSize" context:NULL];
    [self.tagListSpecialization.collectionView removeObserver:self forKeyPath:@"contentSize" context:NULL];
    [self.tagListTags.collectionView removeObserver:self forKeyPath:@"contentSize" context:NULL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rating:) name:@"rating" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAboutMeDetails:) name:@"about_me" object:nil];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMediaTags:) name:@"set_media_tags" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSpecializationTags:) name:@"set_specialization_tags" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTags:) name:@"set_tags" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelButtonPressed) name:@"cancel_button_pressed" object:nil];
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - self made
-(void)initialiseUI{
    if(_coverPicSet == YES){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _coverPicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_sm.strCoverPic]];
            NSLog(@"%@",_coverPicData);
        });
    }
    
    NSString *userID = UserID;
    if([userID isEqualToString:_sm.strID]){
        [self setUpSameUserUI];
    }
    else{
        [self setUpOtherUserUI];
    }
}
-(void)getuserDetails{
    
    SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:spinner];
        [spinner startLoader];
    
    NSString *userID = UserID;
    NSString *accessToken = TOKEN;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
    
    SearchModel *model = [[SearchModel alloc]init];
    [model getUserDetails:userID :_artistID :dict :^(NSDictionary *response_success) {
        [spinner stopLoader];
        [spinner removeFromSuperview];
        
        NSLog(@"%@",response_success);
        SearchModel *sm = [model initWithAttributes:[response_success valueForKey:@"artist"]];
        _sm = sm;
        _arrSpecialization = _sm.arrSpeciality;
        _arrMedia = _sm.arrMedia;
        _arrTags = _sm.arrTags;
        _strAboutMe = _sm.strAboutMe;
        
         [self.tagListMedia.collectionView reloadData];
         [self.tagListSpecialization.collectionView reloadData];
        [self.tagListTags.collectionView reloadData];

        [self checkIfempty];
        [self initialise];
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [spinner stopLoader];
        [spinner removeFromSuperview];
    }];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary  *)change context:(void *)context{
    // You will get here when the finished
    self.heightContraintMedia.constant = self.tagListMedia.collectionView.contentSize.height;
    self.heightConstraintSpecialization.constant = self.tagListSpecialization.collectionView.contentSize.height;
    self.heightConstraintTags.constant = self.tagListTags.collectionView.contentSize.height;
}

-(void)rating:(NSNotification *)noti{
    SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    [kWindow addSubview:spinner];
    [spinner startLoader];
    
    _strRating = [noti.userInfo valueForKey:@"rating"];
    NSString *userID = UserID;
    NSString *accessToken = TOKEN;
    UserProfileModel *model = [[UserProfileModel alloc]init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:_strRating forKey:@"rating"];
    [dict setObject:accessToken forKey:@"access_token"];
    [model userRateOther:userID :_sm.strID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        _sm.strUserRating = [response_success valueForKeyPath:@"artist.rating"];
        [self initialise];
        [spinner removeFromSuperview];
        [spinner stopLoader];
        [super showAlert:@"Rated Successfully"];
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [spinner removeFromSuperview];
        [spinner stopLoader];
    }];
}

-(void)initialise{
  
    _arrDefaultMedia = [[UserInfo sharedUserInfo] arrMedia];
    
    self.tagListMedia.tagColor = [UIColor darkGrayColor];
    self.tagListMedia.tagCornerRadius = 2.0f;
    [self.tagListMedia.tags addObjectsFromArray:_arrMedia];
    
    self.tagListSpecialization.tagCornerRadius = 2.0f;
    [self.tagListSpecialization.tags addObjectsFromArray:_arrSpecialization];
    
    self.tagListTags.tagCornerRadius = 2.0f;
    [self.tagListTags.tags addObjectsFromArray:_arrTags];
   
    _viewImage.layer.cornerRadius = _viewImage.frame.size.width/2;
    _imageViewProfilePic.layer.cornerRadius = _imageViewProfilePic.frame.size.width/2;
    [_viewImage setClipsToBounds:YES];
    [_imageViewProfilePic setClipsToBounds:YES];
    _viewImage.layer.borderWidth = 2.0;
    _viewImage.layer.borderColor = [[UIColor colorWithRed:196/255.f green:197/255.f blue:198/255.f alpha:1]CGColor];
    [_imageViewProfilePic sd_setImageWithURL:[NSURL URLWithString:_sm.strProfilePic] placeholderImage:kDefaultPic];
    [_imageViewCoverPic sd_setImageWithURL:[NSURL URLWithString:_sm.strCoverPic] placeholderImage:kDefaultPic];
    
    _strCoverPic = _sm.strCoverPic;
    
    _labelName.text = _sm.strName;
    _labelGender.text = _sm.strGender;
    _labelCountry.text = [NSString stringWithFormat:@"%@, %@",_sm.strCountry,_sm.strArtistID];

    _labelName.font = [UIFont fontWithName:@"FranklinGothic-Medium" size:18.0];
    _labelName.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    _labelCountry.font = [UIFont fontWithName:@"FranklinGothic-Medium" size:10.0];
    _labelCountry.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    _labelGender.font = [UIFont fontWithName:@"FranklinGothic-Medium " size:10.0];
    _labelAboutMe.font = [UIFont fontWithName:@"Omnes_GirlScouts-Medium" size:10.0];

    _labelGender.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    if([_userID isEqualToString:_sm.strID]){
        _labelAboutMe.text = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"ArtGroundUserInfo.about"];
    }
    else{
    _labelAboutMe.text = _sm.strAboutMe;
    }
    _labelTopName.text = _sm.strName;
    _strAboutMe = _sm.strAboutMe;
    
    GetRatingImages *model = [[GetRatingImages alloc]init];
    model = [GetRatingImages getRatingImagesWithRating:[_sm.strUserRating floatValue]];
    _imageViewStar1.image = [UIImage imageNamed:model.ratingImg1];
    _imageViewStar2.image = [UIImage imageNamed:model.ratingImg2];
    _imageViewStar3.image = [UIImage imageNamed:model.ratingImg3];
   _imageViewStar4.image = [UIImage imageNamed:model.ratingImg4];
   _imageViewStar5.image = [UIImage imageNamed:model.ratingImg5];

    _btnAboutMe.layer.borderColor = KGrayBorder;
    _btnAboutMe.layer.borderWidth = 2.0;
    
    _btnEditCoverPic.layer.borderColor = [[UIColor whiteColor]CGColor];
    _btnEditCoverPic.layer.borderWidth = 2.0;
    
    _btnEditTags.layer.borderColor = KGrayBorder;
    _btnEditTags.layer.borderWidth = 2.0;
    
    _btnEditSpecialization.layer.borderColor = KGrayBorder;
    _btnEditSpecialization.layer.borderWidth = 2.0;
    
    _btnEditMedia.layer.borderColor = KGrayBorder;
    _btnEditMedia.layer.borderWidth = 2.0;
    
    [self checkIfempty];

}

-(void)getModel:(SearchModel *)model{
    _sm = model;
    _arrSpecialization = model.arrSpeciality;
    _arrMedia = model.arrMedia;
    _arrTags = model.arrTags;
    
    if(_sm.strCoverPic.length == 0){
        _strCoverPic = @"";
        _coverPicSet = NO;
    }
    else{
        _strCoverPic = _sm.strCoverPic;
        _coverPicSet = YES;
    }
}
-(void)setUpSameUserUI{
    
    
    [_btnEditTags setHidden:NO];
    [_btnAboutMe setHidden:NO];
    [_btnEditCoverPic setHidden:NO];
    [_btnEditSpecialization setHidden:NO];
    [_btnEditMedia setHidden:NO];
    [_btnSave setHidden:NO];
    
    [_btnChat setUserInteractionEnabled:NO];
    [_btnRate setUserInteractionEnabled:NO];

}
-(void)setUpOtherUserUI{
    
    [_btnEditTags setHidden:YES];
    [_btnAboutMe setHidden:YES];
    [_btnEditCoverPic setHidden:YES];
    [_btnEditSpecialization setHidden:YES];
    [_btnEditMedia setHidden:YES];
    [_btnSave setHidden:YES];
    [_btnRate setUserInteractionEnabled:YES];
    [_btnChat setUserInteractionEnabled:YES];
}

-(void)getAboutMeDetails:(NSNotification *)noti{
    [self.view setUserInteractionEnabled:YES];
    NSLog(@"%@",[noti.userInfo valueForKey:@"text"]);
    _strAboutMe = [noti.userInfo valueForKey:@"text"];
    _labelAboutMe.text = _strAboutMe;
    [self.view endEditing:YES];

    [self checkIfempty];

}
//
//-(void)getMediaTags:(NSNotification *)noti{
//    
//    [self.view endEditing:YES];
//    _arrMedia = [[NSMutableArray alloc]init];
//    _arrMedia = [noti.userInfo valueForKey:@"tags"];
//    self.tagListMedia.tags = [NSMutableArray new];
//    [self.tagListMedia.tags addObjectsFromArray:_arrMedia];
//    [self.tagListMedia.collectionView reloadData];
//
//    [self checkIfempty];
//
//}
-(void)getArray:(NSMutableArray *)tags withType:(NSString *)type{
    if([type isEqualToString:@"Media"]){
    
    _arrMedia = tags;
    self.tagListMedia.tags = [NSMutableArray new];
    [self.tagListMedia.tags addObjectsFromArray:_arrMedia];
    [self.tagListMedia.collectionView reloadData];
    }
    else{
        _arrSpecialization = tags;
        self.tagListSpecialization.tags = [NSMutableArray new];
        [self.tagListSpecialization.tags addObjectsFromArray:_arrSpecialization];
        [self.tagListSpecialization.collectionView reloadData];
    }
    [self checkIfempty];
    
}

//-(void)getSpecializationTags:(NSNotification *)noti{
//    [self.view endEditing:YES];
//    _arrSpecialization = [[NSMutableArray alloc]init];
//    _arrSpecialization = [noti.userInfo valueForKey:@"tags"];
//    self.tagListSpecialization.tags = [NSMutableArray new];
//    [self.tagListSpecialization.tags addObjectsFromArray:_arrSpecialization];
//    [self.tagListSpecialization.collectionView reloadData];
//    [self checkIfempty];
//}
-(void)getTags:(NSNotification *)noti{
    [self.view endEditing:YES];
    _arrTags = [[NSMutableArray alloc]init];
    _arrTags = [noti.userInfo valueForKey:@"tags"];
    self.tagListTags.tags = [NSMutableArray new];
    [self.tagListTags.tags addObjectsFromArray:_arrTags];
    [self.tagListTags.collectionView reloadData];
    [self checkIfempty];

}

-(void)cancelButtonPressed{
    [self.view endEditing:YES];
}

-(void)getUserID :(NSString *)userID{
    _artistID = userID;
}

//check whether the arrays are empty or not
-(void)checkIfempty{
    if(_arrMedia.count == 0){
        [_tagListMedia setHidden:YES];
    }
    else{
        [_tagListMedia setHidden:NO];
    }
    
    if(_arrSpecialization.count == 0){
        [_tagListSpecialization setHidden:YES];
    }
    else{
        [_tagListSpecialization setHidden:NO];
    }
    if(_arrTags.count == 0){
        [_tagListTags setHidden:YES];
    }
    else{
        [_tagListTags setHidden:NO];
    }
    if(_strAboutMe.length != 0){
        [_labelNoAboutMe setHidden:YES];
    }
    else{
        [_labelNoAboutMe setHidden:NO];
    }
}

#pragma mark - touches began

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - Image Picker delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        _imageViewCoverPic.image = info[UIImagePickerControllerEditedImage];
        _imageCoverImage = info[UIImagePickerControllerEditedImage];
        _coverPicSet = YES;
    }];
}

#pragma mark - action sheet delagate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   
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

#pragma mark - Action buttons

- (IBAction)actionBtnEditCoverPic:(id)sender {
    [self.view endEditing:YES];
    UIActionSheet *actionPhoto = [[UIActionSheet alloc]initWithTitle:@"Choose an action: " delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Library", nil];
    [actionPhoto showInView:self.view];
}

- (IBAction)actionBtnEditAboutMe:(id)sender {
    AboutMeDetails *aboutme = [[AboutMeDetails alloc] initWithFrame:CGRectMake(0 ,0, self.view.frame.size.width, self.view.frame.size.height)];
    aboutme.center = self.view.center;
    aboutme.layer.borderWidth = 1.0;
    aboutme.layer.cornerRadius = 5.0;
    aboutme.textViewAboutMe.text = _labelAboutMe.text;
    [self.view addSubview:aboutme];

}

- (IBAction)actionBtnEditMedia:(id)sender {

    CategoryTableVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryTableVC"];
    
    [VC getArray:_arrMedia andType:@"Media"];
    VC.delegate = self;
    [self presentViewController:VC animated:YES completion:nil];

}

- (IBAction)actionBtnEditSpecialization:(id)sender {
    CategoryTableVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryTableVC"];
    [VC getArray:_arrSpecialization andType:@"Specialization"];
    VC.delegate = self;
    [self presentViewController:VC animated:YES completion:nil];
}

- (IBAction)actionBtnEditTags:(id)sender {
    TagsView *tags = [[TagsView alloc] initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andArray:[_arrTags mutableCopy]];
    tags.center = self.view.center;
    tags.layer.borderWidth = 1.0;
    tags.layer.cornerRadius = 8.0;
    tags.labelHeading.text = @"Tags";
    [self.view addSubview:tags];
}

- (IBAction)actionBtnSave:(id)sender {
    [self.view endEditing:YES];
    if(_labelAboutMe.text.length == 0){
        [super showAlert:@"Please add something about yourself"];
    }
    else{
    NSString *pic;
    if(_sm.strImage.length != 0){
        pic = @"1";
    }
    else if(_sm.strImage.length == 0){
        pic = @"0";
    }
    if(_imageCoverImage == nil){
        _imageCoverImage = _imageViewCoverPic.image;
    }
        SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:spinner];
        [spinner startLoader];
        NSString *accessToken =  TOKEN;
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:pic forKey:@"pic"];
        [dict setObject:_labelAboutMe.text forKey:@"about"];
        [dict setObject:accessToken forKey:@"access_token"];
        if(_arrMedia.count != 0){
            
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_arrMedia options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [dict setObject:jsonString forKey:@"media"];
            
        }
        if(_arrSpecialization.count != 0){
            NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_arrSpecialization options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [dict setObject:jsonString forKey:@"speciality"];
        }
        if(_arrTags.count != 0){
            NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_arrTags options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [dict setObject:jsonString forKey:@"tag"];
        }
    
       _coverPicData = UIImagePNGRepresentation(_imageCoverImage);
        
        _userID = UserID;
        UserProfileModel *model = [[UserProfileModel alloc]init];
        if(_coverPicSet == YES){
        
        [dict setObject:@"1" forKey:@"cov"];
        [model updateCoverProfileWithPic:_userID :dict :_coverPicData :YES :^(NSDictionary *response_success) {
            [spinner stopLoader];
            [spinner removeFromSuperview];
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
            }
        } :^(NSError *response_error) {
            NSLog(@"%@",response_error);
            [spinner stopLoader];
            [spinner removeFromSuperview];
            
        }];
        }
        else{
            [dict setObject:@"0" forKey:@"cov"];
            [model updateCoverProfile:_userID :dict :^(NSDictionary *response_success) {
                [spinner stopLoader];
                [spinner removeFromSuperview];
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
                }
            } :^(NSError *response_error) {
                NSLog(@"%@",response_error);
                [spinner stopLoader];
                [spinner removeFromSuperview];
                
            }];
        }

        }
}
- (IBAction)actionBtnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)actionBtnRate:(id)sender{
    RatingView *rating = [[RatingView alloc] initWithFrame:CGRectMake(0 ,0, self.view.frame.size.width, self.view.frame.size.height)];
    rating.center = self.view.center;
    rating.layer.borderWidth = 1.0;
    rating.layer.cornerRadius = 5.0;
    [self.view addSubview:rating];
}

- (IBAction)actionBtnChat:(id)sender{
    
    ChatVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
    [self createDict];
    [VC getUserDetails:_dictArtist];
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)actionBtnHome:(id)sender {

    ProfileHomeVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileHomeVC"];
    [self createDict];
    [VC getArtistDetails:_dictArtist];
    [self.navigationController pushViewController:VC animated:YES];

}
-(void)createDict{
    _dictArtist = [NSMutableDictionary new];
    [_dictArtist setObject:_sm.strName forKey:@"name"];

    [_dictArtist setObject:_sm.strGender forKey:@"gender"];
    [_dictArtist setObject:_sm.strCountry forKey:@"country"];
    [_dictArtist setObject:_sm.strID forKey:@"id"];
//    [_dictArtist setObject:_sm.strAboutMe forKey:@"about"];
//    if(_sm.strImage.length == 0){
//        [_dictArtist setObject:_imageViewProfilePic.image forKey:@"image"];
//    }
}
@end
