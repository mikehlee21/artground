//
//  CollectionViewHeader.m
//  ArtGround
//
//  Created by Kunal Gupta on 20/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "CollectionViewHeader.h"

@implementation CollectionViewHeader

-(void)awakeFromNib{
    [super awakeFromNib];

    _collectionViewHeader.delegate =self;
    _collectionViewHeader.dataSource = self;
    [_collectionViewHeader setBackgroundColor:[UIColor whiteColor]];
    [self startTimer];
}


-(void)startTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(timerRanOut:) userInfo:nil repeats:YES];
}

-(void)stopTimer{
    [_timer invalidate];
}

-(void)timerRanOut:(NSTimer *)timer{
    
    if(_index == _totalPages){
        _index = -1;
    }
    else{
        [_collectionViewHeader scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(_index +1) inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

#pragma mark - collection View Delegate and data sources

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _totalPages+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewHeaderCell *cellHeader = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewHeaderCell" forIndexPath:indexPath];
  
    if(_totalPages > 0){
        if(indexPath.row < _totalPages){
            _hm = [_arrCollectionViewPosts objectAtIndex:indexPath.row];
        }
        else{
            _hm = [_arrCollectionViewPosts objectAtIndex:0];
        }
        [cellHeader.imageViewPost sd_setImageWithURL:[NSURL URLWithString:_hm.strPostImage]];
        _labelArtName.text = _hm.strTitle;
        
        _index = indexPath.row;
    }
    else{
        _labelArtName.text = @"No Arts added yet.";
    }
    return cellHeader;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(_collectionViewHeader.frame.size.width,self.frame.size.height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *hm = [_arrCollectionViewPosts objectAtIndex:indexPath.row];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:hm,@"model", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"headerTapped" object:nil userInfo:dict];
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);
    
    // if collection view scrolled LEFT
    if([_scrollDirection isEqualToString:@"left"]){
        _pageControl.currentPage = indexPath.row - 1;
        if (indexPath.row == _totalPages){
            _pageControl.currentPage = 0;
        }
    }
        // if collection view scrolled RIGHT
    else{
        if(indexPath.row == _totalPages-1){
            [_collectionViewHeader scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        }
        else{
        _pageControl.currentPage = indexPath.row +1;
        }
    
    }
}

#pragma mark - scroll View delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.lastContentOffset > scrollView.contentOffset.x){
        NSLog(@"Scrolling Left");
        _scrollDirection = @"left";
    }
    else if (self.lastContentOffset < scrollView.contentOffset.x){
        _scrollDirection = @"right";
        NSLog(@"Scrolling Right");
    }
     self.lastContentOffset = scrollView.contentOffset.x;
}

@end
