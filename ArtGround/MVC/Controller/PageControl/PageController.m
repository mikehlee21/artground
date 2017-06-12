//
//  PageController.m
//  ArtGround
//
//  Created by Kunal Gupta on 11/12/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "PageController.h"

@interface PageController ()

@end

@implementation PageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUI{
    [self startTimer];
    
    _arrImages = [NSMutableArray new];
    [_arrImages addObject:[UIImage imageNamed:@"po1"]];
    [_arrImages addObject:[UIImage imageNamed:@"po2"]];
    [_arrImages addObject:[UIImage imageNamed:@"po3"]];
    [_arrImages addObject:[UIImage imageNamed:@"po1"]];
}

-(void)timerRanOut:(NSTimer *)timer{
    
    if(_index == 3){
        _index = -1;
    }
    else{
    [_collectionViewPage scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(_index +1) inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}
-(void)startTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerRanOut:) userInfo:nil repeats:YES];
}
-(void)stopTimer{
    [_timer invalidate];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cc = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    _index = indexPath.row;
   
    cc.ImageView.image = [_arrImages objectAtIndex:indexPath.row];
    return cc;
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

    
    if(indexPath.row == 2){
        [_collectionViewPage scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    }
    if(indexPath.row == 3){
        _pageControl.currentPage = 0;
    }
    else{
        _pageControl.currentPage = indexPath.row+1;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    [self stopTimer];
//}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    [self startTimer];
//    
//}

@end
