//
//  UserPaintingsVCViewController.m
//  ArtGround
//
//  Created by Kunal Gupta on 25/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "UserPaintingsVC.h"

@interface UserPaintingsVC()

@end

@implementation UserPaintingsVC

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

#pragma  mark - self made

-(void)getModel:(SearchModel *)model{
    _sm = model;
}

-(void)initialize{
    _spinner  = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    //    [[[[UIApplication sharedApplication] delegate] window] addSubview:_spinner];
    [self.view addSubview:_spinner];
    [_spinner startLoader];
    _viewTop.backgroundColor = kAppColor;
    [_collectionView reloadData];
}

-(void)initializeAPI{
    
    NSString *userID = UserID;
    NSString *artistID = _sm.strID;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[[NSUserDefaults standardUserDefaults]valueForKey:UD_TOKEN] forKey:@"access_token"];
    UserProfileModel *model = [[UserProfileModel alloc]init];
    [model userViewOtherUserArts:userID :artistID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        _arrTableData = [[NSMutableArray alloc]init];
        _arrTableData = [[HomeModel parseDataToArray:[response_success valueForKey:@"arts"]]mutableCopy];
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        [_collectionView reloadData];
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
    }];
    
}

#pragma mark - collection view delegate and data sources

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrTableData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *hm = [_arrTableData objectAtIndex:indexPath.row];
    ProfileCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionCell" forIndexPath:indexPath];
    [cell.imageViewPost sd_setImageWithURL:[NSURL URLWithString:hm.strPostImage]];
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
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UserPaintingsCollectionViewHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UserPaintingsCollectionViewHeader" forIndexPath:indexPath];

    headerView.viewImage.layer.cornerRadius = headerView.viewImage.frame.size.width/2;
    [headerView.viewImage setClipsToBounds:YES];
    
    headerView.viewImage.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    headerView.viewImage.layer.borderWidth = 2.0;
    
    headerView.imageViewProfilePic.layer.cornerRadius = headerView.imageViewProfilePic.frame.size.width/2;
    [headerView.imageViewProfilePic setClipsToBounds:YES];
    
    headerView.labelAboutMe.text = _sm.strAboutMe;
    headerView.labelName.text = _sm.strName;
    headerView.labelCountry.text = _sm.strCountry;
    headerView.labelGender.text = _sm.strGender;
    
    
    [headerView.imageViewProfilePic sd_setImageWithURL:[NSURL URLWithString:_sm.strProfilePic] placeholderImage:kDefaultPic];
    
    return headerView;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

#pragma mark - action buttons

- (IBAction)actionBtnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
