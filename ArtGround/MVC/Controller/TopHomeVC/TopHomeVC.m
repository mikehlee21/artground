//
//  TopHomeVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "TopHomeVC.h"

@interface TopHomeVC ()

@end

@implementation TopHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeAPI];
    [self initialise];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initializeAPI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageTapped:) name:@"headerTapped" object:nil];
}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - self made

-(void)initialise{
    
    
   _spinner  = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:_spinner];
    [self.view addSubview:_spinner];
    [_spinner startLoader];
    
    [_collectionViewPost setHidden:YES];
//    [_collectionViewHeader setHidden:YES];
       [_labelAlert setHidden:YES];
    

}
-(void)initializeAPI{
    NSString *userID = UserID;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[[NSUserDefaults standardUserDefaults]valueForKey:UD_TOKEN] forKey:@"access_token"];
    HomeModel *model = [[HomeModel alloc]init];
    [model topPosts:userID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        _arrTableData = [[NSMutableArray alloc]init];
        _arrTableData = [[HomeModel parseDataToArray:[response_success valueForKey:@"arts"]]mutableCopy];
        
        if([_arrTableData count] >=3){
            _topPages = 3;
            
        }
        else{
            
            _topPages = [_arrTableData count];
        }
        _headerView.pageControl.numberOfPages = _topPages;
        _headerView.totalPages = _topPages;
        _arrCollectionHeader = [_arrTableData subarrayWithRange:NSMakeRange(0, _topPages)];
        
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        
            [_labelAlert setHidden:YES];
            [_collectionViewPost setHidden:NO];
//            [_collectionViewHeader setHidden:NO];
            [_collectionViewPost reloadData];
      
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [_collectionViewPost setHidden:YES];
//        [_collectionViewHeader setHidden:YES];
        [_spinner stopLoader];
        [_labelAlert setHidden:NO];
        [_spinner removeFromSuperview];
    }];
}
-(void)setImageUI{

}

-(void)imageTapped:(NSNotification *)noti{
    HomeModel *hm = [noti.userInfo valueForKey:@"model"];
    [self pushToVC:hm];
}

-(void)pushToVC:(HomeModel *)model{
    SingleItemCategoryDetail *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleItemCategoryDetail"];
    [VC getModel:model];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma  mark - collection view data souce and delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _arrTableData.count - _topPages;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCategoryCollectionViewCell" forIndexPath:indexPath];

    
    HomeModel *hm = [_arrTableData objectAtIndex:indexPath.row + _topPages];
    cell.labelName.text = hm.strArtistName;
    cell.labelPrice.text = [NSString stringWithFormat:@"$%@",hm.strPrice];
    cell.labelTitle.text = hm.strTitle;
    
    [cell.imageViewPost sd_setImageWithURL:[NSURL URLWithString:hm.strPostImage] placeholderImage:[UIImage imageNamed:@"img_default"]];
    //[cell.imageViewPost sd_setImageWithURL:[NSURL URLWithString:hm.strPostImage]];
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

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    return CGSizeMake((frame.size.width - 26) / 2 , (frame.size.width -  26 )/2);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    _headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionViewHeader" forIndexPath:indexPath];
//        HomeModel *hm = [_arrTableData objectAtIndex:0];

    _headerView.arrCollectionViewPosts = _arrCollectionHeader;
    [_headerView.collectionViewHeader reloadData];
    _headerView.pageControl.currentPage = 0;
//    _headerView.labelArtName.text = hm.strTitle;
    
    return _headerView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     HomeModel *hm = [_arrTableData objectAtIndex:indexPath.row + _topPages];
    [self pushToVC:hm];
}


@end
