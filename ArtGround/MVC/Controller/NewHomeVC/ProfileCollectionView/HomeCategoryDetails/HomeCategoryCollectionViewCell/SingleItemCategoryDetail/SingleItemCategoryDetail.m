//
//  SingleItemCategoryDetail.m
//  ArtGround
//
//  Created by Kunal Gupta on 07/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "SingleItemCategoryDetail.h"

@interface SingleItemCategoryDetail () <PostDetailDelegate>

@end

@implementation SingleItemCategoryDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self initialise];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToRedditVC) name:@"sign_in" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postToFb:) name:@"post_to_fb" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Self made

-(void)getModel:(HomeModel *)model{
    _hm = model;
}

-(void)getPostDetails:(HomeModel *)hm{
    _hm = hm;
}

-(void)postToFb:(NSNotification *)noti{
    
    _fbShareText = [noti.userInfo valueForKey:@"text"];
     [self postOnWall:_imageViewPost.image shareText:_fbShareText];
    [self startLoader];
}

-(void)initialise{
    _userID = UserID;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    _tapGesure = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapped:)];
    _labelTapGesure = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapped:)];
    _imageTapGesture= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(postTapped:)];
    _imageTapGesture.numberOfTapsRequired = 2;
    [_imageViewPost addGestureRecognizer:_imageTapGesture];
    
    [_labelName addGestureRecognizer:_labelTapGesure];
    [_imageViewProfilePic2 addGestureRecognizer:_tapGesure];
    
 
    [_imageViewPost sd_setImageWithURL:[NSURL URLWithString:_hm.strPostImage]];
    
    [_imageViewProfilePic2 sd_setImageWithURL:[NSURL URLWithString:_hm.strArtistProfilePic] placeholderImage:kDefaultPic];
    
    
    _labelName.text  = _hm.strArtistName;
    _labelPrice.text = [NSString stringWithFormat:@"$%@",_hm.strPrice];
    _labelInfo.text = [_hm.strDescription uppercaseString];
    _labelTitle.text = _hm.strTitle;
    _labelCountry.text = [_hm.strArtistCountry uppercaseString];
    _labelName.font = [UIFont fontWithName:@"Gotham bold" size:15.0];
    _labelName.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    _labelCountry.font = [UIFont fontWithName:@"Omnes_GirlScouts-Medium" size:10.0];
    _labelCountry.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    _labelInfo.font = [UIFont fontWithName:@"Omnes_GirlScouts-Regular" size: 13.0];
    _labelInfo.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    
    if([_hm.isFavorite integerValue] == 0){
         [_btnFavorite setSelected:NO];
     }
    else{
           [_btnFavorite setSelected:YES];
    }
    _imageViewHeightConstraint.constant = kframe.width - 40;
    
    [self.view layoutIfNeeded];
    
    _viewProfilePic2.layer.cornerRadius = self.viewProfilePic.frame.size.width/2;
    _viewProfilePic2.layer.borderColor = [[UIColor colorWithRed:255/255.f green:99/255.f blue:100/255.f alpha:1]CGColor];
    _viewProfilePic2.layer.borderWidth = 3.0f;
    
    _imageViewProfilePic2.layer.borderWidth = 3.0f;
    _imageViewProfilePic2.layer.cornerRadius = 30.0f;
    _imageViewProfilePic2.layer.borderColor = [[UIColor colorWithRed:255/255.f green:99/255.f blue:100/255.f alpha:1]CGColor];
    [_imageViewProfilePic2 setClipsToBounds:YES];
    [_imageViewProfilePic2.layer setMasksToBounds:YES];
    
    _viewTop.backgroundColor = kAppColor;

//    _fbShareText =[NSString stringWithFormat:@"Title :%@ \n Price: %@ \n Description: %@ ", _hm.strTitle , _hm.strPrice, _hm.strDescription];
    
    NSString *userID = UserID;
    if([userID isEqualToString:_hm.strUserID]){
//        [_btnEdit setHidden:NO];
        [_btnEdit setSelected:NO];
    }
    else{
//        [_btnEdit setHidden:YES];
        [_btnEdit setSelected:YES];
        [_btnEdit setTitle:@"" forState:UIControlStateNormal];
        [_btnEdit setTitle:@"" forState:UIControlStateSelected];
    }
    
    [self.view setNeedsDisplay];
}

-(void)addFavorite{
       NSString *userID = UserID;
    [_btnFavorite setSelected:YES];
    _hm.isFavorite = @"1";
    NSString *accessToken = TOKEN;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
    PostActivityModel *model = [[PostActivityModel alloc]init];
    [model addFavorite:userID :_hm.strArtID :_dictFav :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
    }];
}
-(void)removeFavorite{
    NSString *userID = UserID;
    [_btnFavorite setSelected:NO];
    _hm.isFavorite = @"0";
    PostActivityModel *model = [[PostActivityModel alloc]init];
    [model removeFavorite: userID:_hm.strArtID :_dictFav :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
    }];
}

-(void)pushToRedditVC{
    RedditVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"RedditVC"];
    [VC getModel:_hm];
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)postTapped:(UITapGestureRecognizer *)gesture{
    [self favoriteButtonAction];
//    UIButton * btn = (UIButton *)sender;
}

-(void)favoriteButtonAction{
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        _btnFavorite.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/1.5 animations:^{
            _btnFavorite.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/1.5 animations:^{
                _btnFavorite.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
    
    _accessToken = TOKEN;
    _dictFav = [[NSMutableDictionary alloc]init];
    [_dictFav setObject:_accessToken forKey:@"access_token"];
    
    
    if([_hm.isFavorite integerValue] == 0){
        [self addFavorite];
    }
    else if([_hm.isFavorite integerValue] ==1 ){
        [self removeFavorite];
    }
}
-(void)labelTapped:(UITapGestureRecognizer *)gesture{
    [self pushToUserProfile];
}
-(void)imageTapped:(UITapGestureRecognizer *)gesture{
    
    [self pushToUserProfile];

}
-(void)pushToUserProfile{
    
    ProfileHomeVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileHomeVC"];
    [self createDict];
    [VC getArtistDetails:_dictArtist];
    
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)startLoader{
        _spinner = [[SpinnerView alloc] initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
        [kWindow addSubview:_spinner];
        [_spinner startLoader];
}
-(void)stopLoader{
                [_spinner stopLoader];
                [_spinner removeFromSuperview];

}
-(void)createDict{
    _dictArtist = [NSMutableDictionary new];
    
    [_dictArtist setObject:_hm.strArtistName forKey:@"name"];
    [_dictArtist setObject:_hm.strArtistProfilePic forKey:@"image"];
    [_dictArtist setObject:_hm.strArtistGender forKey:@"gender"];
    [_dictArtist setObject:_hm.strArtistCountry forKey:@"country"];
    [_dictArtist setObject:_hm.strUserID forKey:@"id"];
    [_dictArtist setObject:_hm.strArtistAbout forKey:@"about"];
    [_dictArtist setObject:@"0" forKey:@"blocked"];
    
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
#pragma  mark - action sheet


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSString *accessToken = TOKEN;
     _dictAPI  = [[NSMutableDictionary alloc]init];
    [_dictAPI setObject:accessToken forKey:@"access_token"];
    [_dictAPI setObject:@"1" forKey:@"block"];
    
    if(buttonIndex == 0){
        _hitBlockUserAPI = NO;

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure you want to report this art?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
        [alert show];

        [_dictAPI setObject:_hm.strArtID forKey:@"oid"];
   }
    else if (buttonIndex == 1){
        _hitBlockUserAPI = YES;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure you want to report this user?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
        [alert show];
        [_dictAPI setObject:_hm.strUserID forKey:@"oid"];
    }
}

#pragma mark - ALERT VIEW DELEGATES

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){

        if(_hitBlockUserAPI == YES){
           [self hitBlockUserAPI:_dictAPI];
        }
        else{
           [self hitBlockArtAPI:_dictAPI];
            
        }
    }
}

#pragma mark - API HIT

-(void)hitBlockUserAPI:(NSMutableDictionary *)dict{
    
    [self startSpinner];
    _userID = UserID;
    ChatModel *model = [ChatModel new];
    [dict setObject:@"0" forKey:@"art"];
    
    [model blockUser:_userID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        if([[response_success valueForKeyPath:@"success"] integerValue] == 1){
            [self.navigationController popViewControllerAnimated:YES];
        }
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        
    } :^(NSError *response_error) {
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        NSLog(@"%@",response_error);
    }];
}

-(void)hitBlockArtAPI:(NSMutableDictionary *)dict{
    
    [self startSpinner];
    _userID = UserID;
    ChatModel *model = [ChatModel new];
    [dict setObject:@"1" forKey:@"art"];


    [model blockUser:_userID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        if([[response_success valueForKeyPath:@"success"] integerValue] == 1){
            [self.navigationController popViewControllerAnimated:YES];
        }
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        
    } :^(NSError *response_error) {
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        NSLog(@"%@",response_error);
    }];
}

#pragma  mark - action buttons


- (IBAction)actionBtnFavorite:(id)sender{
    [self favoriteButtonAction];
}

- (IBAction)actionBtnback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionBtnShareViaReddit:(id)sender {
//    NSString *redditAccessToken = [[NSUserDefaults standardUserDefaults] valueForKey:REDDIT_ACCESS_TOKEN];
//    [[RKClient sharedClient] signOut];
    if([[RKClient sharedClient]isSignedIn]){
        [self pushToRedditVC];
    }
    else{
    
    Reddit *reddit = [[Reddit alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height)];
    reddit.center =  [[[[UIApplication sharedApplication] delegate] window] center];
    reddit.layer.borderWidth = 1.0;
    reddit.layer.cornerRadius = 8.0;
    //    [about setStr2:@"dcsjadjakshdfjasdhfjkashbdfjasbdhjkfasdbc dsahd sabusad fbsjf asj basjba jdkfbsakjdfbsakj fasjdf sajdf nasjfnasjfnasdjfnadsjfnasj dfdasjfasdhfj adsfnas'f"];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:reddit];
    }
}

- (IBAction)actionBtnShareViaFacebook:(id)sender{
//    FaceBookShareXib *fb = [[FaceBookShareXib alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) : _hm.strPostImage];
//    fb.center =  [[[[UIApplication sharedApplication] delegate] window] center];
//    fb.layer.borderWidth = 1.0;
//    fb.layer.cornerRadius = 8.0;
//    //    [about setStr2:@"dcsjadjakshdfjasdhfjkashbdfjasbdhjkfasdbc dsahd sabusad fbsjf asj basjba jdkfbsakjdfbsakj fasjdf sajdf nasjfnasjfnasdjfnadsjfnasj dfdasjfasdhfj adsfnas'f"];
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:fb];
   
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.imageURL = [NSURL URLWithString:_hm.strPostImage];
    content.contentTitle = _hm.strTitle;
    content.contentDescription = _hm.strDescription;
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];
}

- (IBAction)actionBtnContactSeller:(id)sender{
    if(![_userID isEqualToString:_hm.strUserID]){
    ChatVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
    [self createDict];
    [VC getUserDetails:_dictArtist];
    [self.navigationController pushViewController:VC animated:YES];
    }
}
- (IBAction)actionBtnEdit:(id)sender {

    if([_btnEdit isSelected]){
        UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"Report" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Report Art",@"Report User", nil];
        [action showInView:self.view];
    }
    else{
    SellTabVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"SellTabVC"];
    VC.delegate = self;
    [VC getModel:_hm];
    [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark - postOn Facebook

-(void)postOnWall:(UIImage *)dict shareText:(NSString *)shareText{

    UIImage *imgSource = dict;
    NSString *strMessage = shareText;
    NSMutableDictionary* photosParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         imgSource,@"source",
                                         strMessage,@"message",
                                         nil];
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/photos" parameters:photosParams HTTPMethod:@"POST"] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {

        if (!error) {
            [self stopLoader];
            NSLog(@"Post id:%@", result[@"id"]);
            [super showAlert:@"Shared Successfully"];
        }
        else{
            [self stopLoader];
            [super showAlert:@"Failed to share your post ! Please try again"];
        }
    }];
}

@end