//
//  UserPaintingsCollectionViewHeader.h
//  ArtGround
//
//  Created by Kunal Gupta on 25/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserPaintingsCollectionViewHeader : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UIView *viewImage;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelCountry;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *labelGender;
@property (strong, nonatomic) IBOutlet UILabel *labelAboutMe;

@end
