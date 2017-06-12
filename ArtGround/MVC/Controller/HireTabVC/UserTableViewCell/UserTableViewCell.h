//
//  UserTableViewCell.h
//  ArtGround
//
//  Created by Kunal Gupta on 18/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JCTagListView.h>

@interface UserTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UIView *viewImage;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelLocation;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintSpecialization;
@property (strong, nonatomic) IBOutlet UILabel *labelMedia;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintLabelSpecialization;
@property (strong, nonatomic) IBOutlet UILabel *labelSpecialization;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintLabelMedia;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintMedia;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintCountrybtn;
@property (strong, nonatomic) IBOutlet UIButton *btnTag2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintCountry;
@property (strong, nonatomic) IBOutlet JCTagListView *viewTags;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cellTopConstraint;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewStar5;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintViewTags;

@property (strong, nonatomic) IBOutlet UIButton *btnTag3;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewStar1;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewStar4;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewStar2;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewStar3;

@property (strong, nonatomic) IBOutlet UIButton *btnTag1;

@end
