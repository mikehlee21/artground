//
//  HomeCategoryDetails.m
//  ArtGround
//
//  Created by Kunal Gupta on 06/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "HomeCategoryDetails.h"

@interface HomeCategoryDetails ()

@end

@implementation HomeCategoryDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialise];
    [self initializeAPI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UITextField *txfSearchField = [_searchBarBetaX valueForKey:@"_searchField"];
    
    // Setting up Search Text Field UI
    
    txfSearchField.backgroundColor = [UIColor colorWithRed:213/255.f green:213/255.f blue:213/255.f alpha:1];
    txfSearchField.textColor = [UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:1];
    [txfSearchField setValue:[UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    txfSearchField.placeholder = @"Search                                                                         ";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initializeAPI];
}
#pragma mark  - self made

-(void)initialise{
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
   [self startSpinner];
    _labelCategoryName.text = _catName;
    
    _userID = UserID;
    _accessToken = TOKEN;
    _labelCategoryName.textColor = kSelColor;
    _viewTop.backgroundColor = kAppColor;


    // change search bar Outer border color to clear color
    /*
    [[UISearchBar appearance] setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"ic_search_bar"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"ic_cross"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    
    UIImage *whatSearchImage = [UIImage imageNamed:@"icon_search.png"];
    UIImageView *whatSearchView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    whatSearchView.image = whatSearchImage;
    whatSearchView.tintColor = [UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:1];
    txfSearchField.leftViewMode = UITextFieldViewModeAlways;
    txfSearchField.leftView = whatSearchView;
     
    */
     
//    [self setSearchIcon];
}

-(void)getCatID:(NSString *)catName :(NSString *)ID{
    _catID = ID;
    _catName = catName;
}

-(void)initializeAPI{
   
    if([super internetWorking] == NO){
        [super showAlert:@"Please Check your internet connection"];
    }
    else{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:_accessToken forKey:@"access_token"];
        
        NSLog(@"     TOKEN:%@",_accessToken);

    HomeModel *model = [[HomeModel alloc]init];
    [model categoryDetail:_userID :_catID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
            [self stopSpinner];
        if([[response_success valueForKey:@"success"] integerValue] == 1 ){
        _arrTableData = [[NSMutableArray alloc]init];
        _arrTableData = [[HomeModel parseDataToArray:[response_success valueForKey:@"art"]]mutableCopy];
            if(_arrTableData.count == 0){
                [_collectionViewPosts setHidden:YES];
                _labelAlert.text = @"No arts added in this category yet";
            }
            else if (_arrTableData.count >0){
                [_collectionViewPosts setHidden:NO];
                [_collectionViewPosts reloadData];
            [self.view endEditing:YES];
            }
        }
        else if([[response_success valueForKey:@"success"] integerValue] == 5){
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_TOKEN];
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_USER_INFO];
            [super logout:[response_success valueForKey:@"msg"] SegueIdentifier:@"HomeCategoryDetails"];
        }

    } :^(NSError *response_error) {
        [_collectionViewPosts setHidden:YES];
        _labelAlert.text = @"Something went wrong.Please try again.";
        NSLog(@"%@",response_error);
         [self stopSpinner];
    }];
    }
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
#pragma mark - search Bar delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    [self.view endEditing:YES];
   
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:UD_TOKEN];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
    [dict setObject:searchBar.text forKey:@"search"];
    NSString *userID = UserID;
    
    SpinnerView *spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    [kWindow addSubview:spinner];
    [spinner startLoader];
    
    HomeModel *model  = [[HomeModel alloc]init];
    [model categorySearch :userID :_catID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        [spinner stopLoader];
        [spinner removeFromSuperview];
        if([[response_success valueForKey:@"success"] integerValue ] == 0){
            // Handle Here
         
            if([[response_success valueForKey:@"msg"] isEqualToString:@"No Art Found"]){
                [_collectionViewPosts setHidden:YES];
                _labelAlert.text = @"No result corresponding to that search.";
            }
        }
        else if([[response_success valueForKey:@"success"] integerValue ] == 1){
            [spinner stopLoader];
            [_collectionViewPosts setHidden:NO];
            [spinner removeFromSuperview];
            _arrTableData = [[NSMutableArray alloc]init];
            _arrTableData = [[HomeModel parseDataToArray:[response_success valueForKey:@"art"]]mutableCopy];
            [_collectionViewPosts reloadData];
        }
        
    } :^(NSError *response_error) {
        [spinner stopLoader];
        [spinner removeFromSuperview];
        NSLog(@"%@",response_error);
        [_collectionViewPosts setHidden:YES];
//        _labelAlert.text = @"Something went wrong please try again.";
    }];
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchText isEqualToString:@""]){
        [self.view endEditing:YES];
        [self initializeAPI];
//        _labelAlert.text = @"Type something to search";
    }
}
#pragma mark - Collection View Delegate and Data source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrTableData.count ;
}
-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeModel *hm = [_arrTableData objectAtIndex:indexPath.row];
    
    
    HomeCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCategoryCollectionViewCell" forIndexPath:indexPath];
//    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
/*
    if ( !hm.strArtistName.length ) {
    
        cell.labelName.text = @"no data";
    } else {
    
        cell.labelName.text = hm.strArtistName;
    }
*/    
    if ( !hm.strPrice.length ) {
        
        cell.labelPrice.text = @"no data";
    } else {
        
        cell.labelPrice.text = [NSString stringWithFormat:@"$%@",hm.strPrice];
    }
    

    if ( !hm.strTitle.length ) {
        
        cell.labelTitle.text = @"no data";
    } else {
        
        cell.labelTitle.text = hm.strTitle;
    }
    
    if ([hm.isFavorite integerValue] == 0) {
        cell.btnFavorite.selected = NO;
    } else {
        cell.btnFavorite.selected = YES;
    }
    
    cell.labelDate.text = hm.strCreatedAt;
    
    
//    cell.labelName.text = hm.strArtistName;
//    cell.labelPrice.text = [NSString stringWithFormat:@"$%@",hm.strPrice];
//    cell.labelTitle.text = hm.strTitle;

     [cell.imageViewPost sd_setImageWithURL:[NSURL URLWithString:hm.strPostImage]];
    
    cell.hm = hm;
   
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.view layoutIfNeeded];
    [self.view setNeedsDisplay];
        HomeCategoryCollectionViewCell *cell1 = (HomeCategoryCollectionViewCell *) cell;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell1.viewContent.bounds];
    [cell.layer setMasksToBounds:NO];
    cell1.viewContent.layer.masksToBounds = NO;
    cell1.viewContent.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell1.viewContent.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    cell1.viewContent.layer.shadowOpacity = 0.35f;
    cell1.viewContent.layer.shadowPath = shadowPath.CGPath;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGRect frame = [[UIScreen mainScreen] bounds];
    return CGSizeMake((frame.size.width - 26) / 2 , 221);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *hm = [_arrTableData objectAtIndex:indexPath.row];
    SingleItemCategoryDetail *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleItemCategoryDetail"];
    [VC getModel:hm];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - Touches BEgan

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



@end
