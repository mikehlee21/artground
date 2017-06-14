//
//  NewHomeVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "ProfileHomeVC.h"

@interface ProfileHomeVC ()

@end

@implementation ProfileHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _userID = UserID;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([_strPathFrom isEqualToString:@"Hire"]){
        _topViewHeightConstraint.constant = 64;
    }
    else{
        _topViewHeightConstraint.constant = 0;
    }
    
    if(_dictArtist){
        if([[_dictArtist valueForKey:@"id" ] isEqualToString:_userID]){
            [self initialise];
            
            _strPaintingForID = _userID;
        }
        else{
            [self initializeUser];
            _strPaintingForID = [_dictArtist valueForKey:@"id"];
        }
        _topViewHeightConstraint.constant = 64;
    }
    else{
        _topViewHeightConstraint.constant = 0;
        [self initialise];
        _strPaintingForID = _userID;
    }
    [self initializeAPI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(get_post_id:) name:@"get_art_id" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Self made

-(void)pathFrm :(NSString *)path{
    _strPathFrom = path;
}
-(void)getArtistDetails:(NSMutableDictionary *) dict{
        _dictArtist = dict;
    //        [_dictArtist setObject:name forKey:@"name"];
//        [_dictArtist setObject:image forKey:@"image"];
//        [_dictArtist setObject:gender forKey:@"gender"];
//        [_dictArtist setObject:country forKey:@"country"];
//        [_dictArtist setObject:artistID forKey:@"id"];
//        [_dictArtist setObject:about forKey:@"about"];
}

-(void)get_post_id:(NSNotification *)noti{
    _strDeleteArt = [noti.userInfo valueForKey:@"post_id"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Are you sure you want to delete this Art?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
    [alert show];
    
}
-(void)initializeUser{
    
    [self initializeUI];
    
    _labelName.text = [_dictArtist valueForKey:@"name"];
    _labelCountry.text = [_dictArtist valueForKey:@"country"];
    _labelGender.text = [_dictArtist valueForKey:@"gender"];
//    _labelAboutMe.text = [_dictArtist valueForKey:@"about"];
    
    [self.imageViewProfilePic sd_setImageWithURL:[NSURL URLWithString:[_dictArtist valueForKey:@"image"]] placeholderImage:kDefaultPic];
    
    _labelName.textColor = kdarkGray;
    _labelGender.textColor = klightGray;
    _labelCountry.textColor = klightGray;
    [_btnEditProfile setHidden:YES];
    _btnEditProfileHeightConstraint = 0;
}

-(void)initialise{
    
    [self initializeUI];
    
    _labelName.text = [UserDict valueForKey:@"name"];
    _labelCountry.text = [UserDict valueForKey:@"country"];
    _labelGender.text = [UserDict valueForKey:@"gender"];
    _labelAboutMe.text = [UserDict valueForKey:@"about"];
    
//    if([[UserDict valueForKey:@"profile_pic"] length] != 0){
        [_imageViewProfilePic sd_setImageWithURL:[NSURL URLWithString:[UserDict valueForKey:@"profile_pic"]] placeholderImage:kDefaultPic];
//    }
    
    _labelName.textColor = kdarkGray;
    _labelGender.textColor = klightGray;
    _labelCountry.textColor = klightGray;
    _btnEditProfile.layer.cornerRadius = 2.0;
    [_btnEditProfile setHidden:NO];
    _btnEditProfileHeightConstraint.constant = 18;
    [_btnEditProfile.layer setCornerRadius:4.0];
    [_btnEditProfile setClipsToBounds:YES];
    [self setAboutMeAlignment];
}

-(void)initializeUI{
    
    _viewTop.backgroundColor = kAppColor;
    
    _accessToken = TOKEN;
    
    _imageViewProfilePic.layer.cornerRadius = _imageViewProfilePic.frame.size.width/2;
    [_imageViewProfilePic setClipsToBounds:YES];
    _viewContent.layer.cornerRadius = _viewContent.frame.size.width/2;
    [_viewContent setClipsToBounds:YES];
    _viewContent.layer.borderColor = [[UIColor colorWithRed:255/255.f green:0/255.f blue:90/255.f alpha:1] CGColor];
    _viewContent.layer.borderWidth = 3;
    //should be FranklinGothic Medium!
    
    _labelName.font = [UIFont fontWithName:@"FranklinGothic-Medium" size:18.0];
    _labelCountry.font = [UIFont fontWithName:@"FranklinGothic-Medium" size:10.0];
    _labelGender.font = [UIFont fontWithName:@"FranklinGothic-Medium" size:10.0];
    
    _btnEditProfile.titleLabel.font = [UIFont fontWithName:@"Omnes_GirlScouts-Medium" size:10.0];
    _labelAboutMe.font = [UIFont fontWithName:@"Omnes_GirlScouts-Medium" size:13.0];

}
-(void)setAboutMeAlignment{
    if(_labelAboutMe.text.length == 0){
        _labelAboutMe.text = @"About me not added yet";
        //_labelAboutMe.textAlignment = NSTextAlignmentCenter;
    }
    else{
        //_labelAboutMe.textAlignment = NSTextAlignmentLeft;
    }
}

-(void)initializeAPI{
    if([super internetWorking] == NO){
        [super showAlert:@"Please Check your internet connection"];
    }
    else{
    SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    
        dispatch_once(&once, ^{
            //    [[[[UIApplication sharedApplication] delegate] window] addSubview:spinner];
//        [self.view addSubview:spinner];
            [spinner startLoader];
    });

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:_accessToken forKey:@"access_token"];
    UserProfileModel *model = [[UserProfileModel alloc]init];
    [model userDetails:_strPaintingForID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        if([[response_success valueForKey:@"success"] integerValue] == 1){
        [_collectionView setHidden:NO];
        [spinner stopLoader];
        [spinner removeFromSuperview];
        _dictUser = [response_success valueForKey:@"user"];
        _arrTableData = [[NSMutableArray alloc]init];
        _arrTableData = [[HomeModel parseDataToArray:[response_success valueForKey:@"arts"]]mutableCopy];
        _labelAboutMe.text = [response_success valueForKey:@"about"];
            if(_dictArtist){
                if(![[_dictArtist valueForKey:@"id" ] isEqualToString:_userID]){
                    
                    [self initializeUser];
                    [self setAboutMeAlignment];
                }
            }
            else{
               _labelAboutMe.text = [response_success valueForKeyPath:@"user.about"];
               _labelCountry.text = [response_success valueForKeyPath:@"user.artist_country"];
               _labelGender.text = [response_success valueForKeyPath:@"user.gender"];
               [self initialise];
            }
            
        [self setUpUI];
        [self setAboutMeAlignment];
        _totalPosts = [[response_success valueForKey:@"art_count"]integerValue];

        }
        else{
            [_collectionView setHidden:YES];
            _labelAlert.text = @"No arts added yet.";
        }
        } :^(NSError *response_error) {
        [spinner stopLoader];
        [spinner removeFromSuperview];
        [_collectionView setHidden:YES];
        _labelAlert.text = @"Something went wrong.";
        NSLog(@"%@",response_error);
    }];
    }
}

-(void)setUpUI{
    CGRect frame = [[UIScreen mainScreen] bounds];
  
    NSInteger numberOfRows;
    _totalPosts = [_arrTableData count];
    numberOfRows = _totalPosts /3;
    if(_totalPosts % 3 == 0){
        _collectionViewHeightConstraint.constant = (numberOfRows * (frame.size.width - 16) / 3);
    }
    else{
        _collectionViewHeightConstraint.constant = (numberOfRows + 1) *((frame.size.width - 16 ) / 3);
    }
    
    [_collectionView reloadData];
}

#pragma mark - alertview delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([[alertView buttonTitleAtIndex:buttonIndex ]  isEqualToString:@"Yes"]){
        SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:spinner];
                    [self.view addSubview:spinner];
            [spinner startLoader];
        NSLog(@"Delete user ID %@",_strDeleteArt);
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:[NSString stringWithFormat:@"%@",TOKEN] forKey:@"access_token"];
        PostActivityModel *model = [[PostActivityModel alloc]init];
        [model deleteArt:_userID :_strDeleteArt :dict :^(NSDictionary *response_success) {
            NSLog(@"%@",response_success);
            [spinner stopLoader];
            [spinner removeFromSuperview];
            [self initializeAPI];
            [super showSuccess:@"Notification":@"Your art has been successfully removed."];
        } :^(NSError *response_error) {
            [spinner stopLoader];
            [spinner removeFromSuperview];
            NSLog(@"%@",response_error);
        }];
    }
}

#pragma mark - Collection view Delegate and Data source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrTableData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeModel *hm = [_arrTableData objectAtIndex:indexPath.row];
    
    ProfileCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionCell" forIndexPath:indexPath];
    
    cell.postID = hm.strArtID;
    [cell.imageViewPost sd_setImageWithURL:[NSURL URLWithString:hm.strPostImage]];
    if([_userID isEqualToString:hm.strUserID]){
        [cell.btnDelete setHidden:NO];
    }
    else{
        [cell.btnDelete setHidden:YES];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    HomeModel *hm = [_arrTableData objectAtIndex:indexPath.row];
    SingleItemCategoryDetail *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleItemCategoryDetail"];
    [VC getModel:hm];
    [self.navigationController pushViewController:VC animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    return CGSizeMake((frame.size.width - 38) / 3 , (frame.size.width -  38 )/3);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.view layoutIfNeeded];
    [self.view setNeedsDisplay];
    ProfileCollectionCell *cell1 = (ProfileCollectionCell *) cell;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell1.imageViewPost.bounds];
    [cell.layer setMasksToBounds:NO];
    cell1.imageViewPost.layer.masksToBounds = NO;
    cell1.imageViewPost.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell1.imageViewPost.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    cell1.imageViewPost.layer.shadowOpacity = 0.6f;
    cell1.imageViewPost.layer.shadowPath = shadowPath.CGPath;
}

#pragma mark - action button

- (IBAction)actionBtnLogout:(id)sender {
   }

- (IBAction)actionBtnEditProfile:(id)sender {
    EditProfileVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileVC"];
    VC.hidesBottomBarWhenPushed = YES;
    [VC setStrShowCancel:@"showCancelButton"];
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)actionBtnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
