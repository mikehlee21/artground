//
//  HIreTabVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "HIreTabVC.h"

@interface HIreTabVC ()

@end

@implementation HIreTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self initializeAPI];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initializeAPI];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self initializeAPI];
//}

-(void)initialize{
    _dictAPI = [[NSMutableDictionary alloc]init];
    
    _viewTop.backgroundColor = kAppColor;
    _viewHeading.backgroundColor = kAppColor;
    _searchBarUser.tintColor = [UIColor redColor];
    _searchBarUser.backgroundColor = kAppColor;
    
    // change search bar Outer border color to clear color
    
    [[UISearchBar appearance] setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"ic_search_bar"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"ic_cross"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    
    // Setting up Search Text Field UI
    UITextField *txfSearchField = [_searchBarUser valueForKey:@"_searchField"];
    txfSearchField.layer.cornerRadius = 9.0;
    txfSearchField.backgroundColor = [UIColor colorWithRed:254/100.f green:150/255.f blue:150/255.f alpha:1];
    txfSearchField.textColor = [UIColor whiteColor];
    [txfSearchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_btnLocation sizeToFit];
    
    _arrCategory = [[NSMutableArray alloc]init];
    _arrCategory = [[UserInfo sharedUserInfo] arrCategories];
    
    
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    _arrCountry = [[NSMutableArray alloc] init];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *name = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [_arrCountry addObject:name];
    }
    
    [_arrCountry sortUsingSelector:@selector(localizedCompare:)];
    _strCountry = @"";
    [self setDropBoxOrientaion];
    _arrRatings = [[NSMutableArray alloc]init];
//    [_arrRatings addObject:@"All Ratings"];
//    [_arrRatings addObject:@"1 Star"];
//    [_arrRatings addObject:@"2 Star"];
//    [_arrRatings addObject:@"3 Star"];
//    [_arrRatings addObject:@"4 Star"];
//    [_arrRatings addObject:@"5 Star"];
    
    [_arrRatings addObjectsFromArray:@[@"All Ratings",@"1 Star",@"2 Star",@"3 Star",@"4 Star",@"5 Star"]];
    _btnProfile .layer.cornerRadius = 2.0;
    
}
-(void)setDropBoxOrientaion{
    
    _btnLocation.titleEdgeInsets = UIEdgeInsetsMake(0, -_btnLocation.imageView.frame.size.width, 0, _btnLocation.imageView.frame.size.width);
    _btnLocation.imageEdgeInsets = UIEdgeInsetsMake(5, _btnLocation.titleLabel.frame.size.width , 0, -_btnLocation.titleLabel.frame.size.width);
    _btnCategory.titleEdgeInsets = UIEdgeInsetsMake(0, -_btnCategory.imageView.frame.size.width, 0, _btnCategory.imageView.frame.size.width);
    _btnCategory.imageEdgeInsets = UIEdgeInsetsMake(5, _btnCategory.titleLabel.frame.size.width , 0, -_btnCategory.titleLabel.frame.size.width);
    _btnRatings.titleEdgeInsets = UIEdgeInsetsMake(0, -_btnRatings.imageView.frame.size.width, 0, _btnRatings.imageView.frame.size.width);
    _btnRatings.imageEdgeInsets = UIEdgeInsetsMake(5, _btnRatings.titleLabel.frame.size.width , 0, -_btnRatings.titleLabel.frame.size.width);
}
-(void)initializeAPI{
    [self getResponse:_dictAPI];
}
-(void)getCountry:(NSString *)country{
    _strCountry = country;
    [_dictAPI setObject:_strCountry forKey:@"country"];
    [_btnLocation setTitle:country forState:UIControlStateNormal];
    [self setDropBoxOrientaion];
    [self getResponse:_dictAPI];
}

-(void)getResponse:(NSMutableDictionary *)dict{
    
    if([super internetWorking] == NO){
        [super showAlert:@"Please Check your internet connection"];
    }

    
    SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:spinner];
    [spinner startLoader];
    
    NSString *userID = UserID;
    [_dictAPI setObject:[[NSUserDefaults standardUserDefaults] valueForKey:UD_TOKEN] forKey:@"access_token"];
    SearchModel *model = [[SearchModel alloc]init];
    [model searchArtist:userID :dict :^(NSDictionary *response_success) {
        [spinner stopLoader];
        [spinner removeFromSuperview];
        NSLog(@"%@",response_success);
        if([[response_success valueForKey:@"success"] integerValue] == 1){
            [_tableView setHidden:NO];
            _arrTableData = [[NSMutableArray alloc]init];
            _arrTableData = [[SearchModel parseDataToArray:[response_success valueForKey:@"users"]]mutableCopy];
            _myModel = [model initWithAttributes:[response_success valueForKey:@"personal"]];            [_tableView reloadData];
        }
        else if([[response_success valueForKey:@"success"] integerValue] == 0){
            [_tableView setHidden:YES];
        }
    } :^(NSError *response_error) {
        [spinner stopLoader];
        [spinner removeFromSuperview];

        NSLog(@"%@",response_error);
    }];
    
}

#pragma mark - Table View Delegate and Data sources

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrTableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTableViewCell"];
    SearchModel *sm = [_arrTableData objectAtIndex:indexPath.row];
    [cell.imageViewProfilePic sd_setImageWithURL:[NSURL URLWithString:sm.strProfilePic] placeholderImage:kDefaultPic];
    cell.labelName.text = sm.strName;
    cell.labelLocation.text = sm.strCountry;
    cell.labelMedia.text = [sm.arrMedia componentsJoinedByString:@","] ;
    cell.labelSpecialization.text = [sm.arrSpeciality componentsJoinedByString:@","];
    GetRatingImages *model = [[GetRatingImages alloc]init];
    model = [GetRatingImages getRatingImagesWithRating:[sm.strUserRating floatValue]];
    cell.imageViewStar1.image = [UIImage imageNamed:model.ratingImg1];
    cell.imageViewStar2.image = [UIImage imageNamed:model.ratingImg2];
    cell.imageViewStar3.image = [UIImage imageNamed:model.ratingImg3];
    cell.imageViewStar4.image = [UIImage imageNamed:model.ratingImg4];
    cell.imageViewStar5.image = [UIImage imageNamed:model.ratingImg5];
    
    if([sm.strCountry isEqualToString:@""]){
        cell.heightConstraintCountrybtn.constant = 0;
        cell.heightConstraintCountry.constant = 0;
    }
    else{
        cell.heightConstraintCountrybtn.constant = 15;
        cell.heightConstraintCountry.constant = 16;
    }
    
    if([sm.arrMedia count] == 0){
        cell.heightConstraintLabelMedia.constant = 0;
        cell.heightConstraintMedia.constant = 0;
    }
    else{
        cell.heightConstraintLabelMedia.constant = 15;
        cell.heightConstraintMedia.constant = 16;
    }
    if([sm.arrSpeciality count] == 0){
        cell.heightConstraintSpecialization.constant = 0;
        cell.heightConstraintLabelSpecialization.constant = 0;
    }
    else{
        cell.heightConstraintSpecialization.constant = 15;
        cell.heightConstraintLabelSpecialization.constant = 16;
    }
  if(sm.arrTags.count == 0){
        cell.heightConstraintViewTags.constant = 0;
    }
    else{
    cell.heightConstraintViewTags.constant = 40;
    cell.viewTags.tags = [NSMutableArray new];
    [cell.viewTags.tags addObjectsFromArray:sm.arrTags];
    [cell.viewTags.collectionView reloadData];
    cell.viewTags.tagCornerRadius = 2.0;
    }
    if(indexPath.row == 0){
        cell.cellTopConstraint.constant = 8;
    }
    else{
        cell.cellTopConstraint.constant = 0;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
      SearchModel *sm = [_arrTableData objectAtIndex:indexPath.row];
    
    UserProfileVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
    [VC getModel:sm];
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view layoutIfNeeded];
    [self.view setNeedsDisplay];
    UserTableViewCell *cell1 = (UserTableViewCell *) cell;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell1.viewContent.bounds];
    [cell.layer setMasksToBounds:NO];
    cell1.viewContent.layer.masksToBounds = NO;
    cell1.viewContent.layer.shadowColor = [[UIColor darkGrayColor]CGColor];
    cell1.viewContent.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    cell1.viewContent.layer.shadowOpacity = 0.35f;
    cell1.viewContent.layer.shadowPath = shadowPath.CGPath;
}
#pragma mark - scroll View
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [_searchBarUser resignFirstResponder];
}

#pragma mark alertview Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(actionSheet == _actionCategory){
        if(![[actionSheet buttonTitleAtIndex:buttonIndex ] isEqualToString:@"Cancel"]){
            [_btnCategory setTitle:[actionSheet buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
            _catID = [[[UserInfo sharedUserInfo] arrCatID] objectAtIndex:buttonIndex-1];
            _strCategory = _catID;
            NSLog(@"%@",_catID);
            [_dictAPI setObject:_strCategory forKey:@"category_id"];
            [self getResponse:_dictAPI];

        }
    }
    else if(actionSheet == _actionRatings){
        if(![[actionSheet buttonTitleAtIndex:buttonIndex ] isEqualToString:@"Cancel"]){
            [_btnRatings setTitle:[actionSheet buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
            if([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"All Ratings"]){
                _strRating = @"0";
            }
            else{
            _strRating = [[actionSheet buttonTitleAtIndex:buttonIndex] stringByReplacingOccurrencesOfString:@" Star" withString:@""];
            }
            NSLog(@"%@",_strRating);
            [_dictAPI setObject:_strRating forKey:@"rating"];
            [self getResponse:_dictAPI];
        }
    }
    
    [self setDropBoxOrientaion];
    
}

#pragma mark - Search Bar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    [_dictAPI setObject:searchBar.text forKey:@"search"];
    [self getResponse:_dictAPI];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchText isEqualToString:@""]){
        [_dictAPI removeObjectForKey:@"search"];
        [self.view endEditing:YES];
        [self getResponse:_dictAPI];
    }
}

#pragma mark - action Button

- (IBAction)actionBtnLocation:(id)sender {
    [self.view endEditing:YES];

    CountryVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryVC"];
    [VC getCountryArray:_arrCountry:_strCountry];
    VC.delegate = self;
    [self presentViewController:VC animated:YES completion:nil];
}

- (IBAction)actionBtnCategory:(id)sender {
    [self.view endEditing:YES];
    _actionCategory = [[UIActionSheet alloc]initWithTitle:@"Choose a category:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    for(NSString *buttonTitle in _arrCategory){
        [_actionCategory addButtonWithTitle:buttonTitle];
    }
    [_actionCategory showInView:self.view];
}

- (IBAction)actionBtnRatings:(id)sender {
    [self.view endEditing:YES];
    _actionRatings = [[UIActionSheet alloc]initWithTitle:@"Choose rating:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    for (NSString *button in _arrRatings) {
        [_actionRatings addButtonWithTitle:button];
    }
    [_actionRatings showInView:self.view];
}

- (IBAction)actionBtnProfile:(id)sender {
    [self.view endEditing:YES];
    UserProfileVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
    [VC getModel:_myModel];
    [self.navigationController pushViewController:VC animated:YES];

}
@end
