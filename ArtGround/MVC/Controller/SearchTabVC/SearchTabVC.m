//
//  SearchTabVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "SearchTabVC.h"

@interface SearchTabVC ()

@end

@implementation SearchTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([[_dictSearch valueForKey:@"search"] length] != 0){
        [self hitSearchAPI];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - self made

-(void)initialize{
    super.tabBarItemIndex = self.tabBarItem.tag ;
    
    _viewTop.backgroundColor = kAppColor;
    [_collectionView setHidden:YES];
    //self.searchBar.tintColor = [UIColor redColor];
    
    // Setting up Search Text Field UI

    
    UITextField *txfSearchField = [_searchBar valueForKey:@"_searchField"];
    txfSearchField.backgroundColor = [UIColor colorWithRed:213/255.f green:213/255.f blue:213/255.f alpha:1];
    txfSearchField.textColor = [UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:1];
    [txfSearchField setValue:[UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    /*
    // change search bar Outer border color to clear color

    [[UISearchBar appearance] setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"ic_search_bar"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"ic_cross"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
     
    
    // setting the image size of lens

    UIImage *whatSearchImage = [UIImage imageNamed:@"icon_search.png"];
    UIImageView *whatSearchView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    whatSearchView.image = whatSearchImage;
    txfSearchField.leftViewMode = UITextFieldViewModeAlways;
    txfSearchField.leftView = whatSearchView;
*/
}

-(void)hitSearchAPI{
    NSString *userID = UserID;
    
    SearchModel *model  = [[SearchModel alloc]init];
    [model searchArt:userID :_dictSearch :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        if([[response_success valueForKey:@"success"] integerValue ] == 0){
            // Handle Here
            [_spinner stopLoader];
            [_spinner removeFromSuperview];
            if([[response_success valueForKey:@"msg"] isEqualToString:@"No Art Found"]){
                _labelAlert.text = @"No result corresponding to that search.";
            }
        }
        else if([[response_success valueForKey:@"success"] integerValue ] == 1){
            [_spinner stopLoader];
            [_collectionView setHidden:NO];
            [_spinner removeFromSuperview];
            _arrTableData = [[NSMutableArray alloc]init];
            _arrTableData = [[HomeModel parseDataToArray:[response_success valueForKey:@"art"]]mutableCopy];
            
            [_collectionView reloadData];
        }
        
    } :^(NSError *response_error) {
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        NSLog(@"%@",response_error);
        [_collectionView setHidden:YES];
        _labelAlert.text = @"Something went wrong please try again.";
    }];

}
#pragma mark - Touches Began

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma mark - search Bar delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    if([super internetWorking] == NO){
        [super showAlert:@"Please Check your internet connection"];
    }
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:UD_TOKEN];
    _dictSearch = [[NSMutableDictionary alloc]init];
    [_dictSearch setObject:accessToken forKey:@"access_token"];
    [_dictSearch setObject:searchBar.text forKey:@"search"];
    
     _spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    [kWindow addSubview:_spinner];
    [_spinner startLoader];
    [self hitSearchAPI];
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchText isEqualToString:@""]){
        [_collectionView setHidden:YES];
        _labelAlert.text = @"Type something to search";
    }
}

#pragma mark - collection View Delegates

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrTableData.count ;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *hm = [_arrTableData objectAtIndex:indexPath.row];
    
    HomeCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCategoryCollectionViewCell" forIndexPath:indexPath];
    //    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.labelPrice.text = [NSString stringWithFormat:@"$%@",hm.strPrice];
    cell.labelTitle.text = hm.strTitle;
    
    [cell.imageViewPost sd_setImageWithURL:[NSURL URLWithString:hm.strPostImage]];
    
    if ([hm.isFavorite integerValue] == 0) {
        cell.btnFavorite.selected = NO;
    } else {
        cell.btnFavorite.selected = YES;
    }
    
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
    [self.view endEditing:YES];
}


@end
