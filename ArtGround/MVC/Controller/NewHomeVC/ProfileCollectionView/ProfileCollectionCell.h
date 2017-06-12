//
//  ProfileCollectionCell.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCollectionCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imageViewPost;
@property NSString *postID;
- (IBAction)actionBtnDelete:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnDelete;

@end
