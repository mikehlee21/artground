//
//  SellTabVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "HomeModel.h"
#import "BaseVC.h"
#import "UserInfo.h"
#import "PostActivityModel.h"
#import "SpinnerView.h"
#import "HomeModel.h"
#import "SingleItemCategoryDetail.h"
#import "TabBarControllerVC.h"
#import <UIImageView+WebCache.h>


@protocol PostDetailDelegate

-(void)getPostDetails:(HomeModel *)hm;

@end

@interface SellTabVC : BaseVC <UIActionSheetDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate >

- (IBAction)actionBtnBack:(id)sender;
- (IBAction)actionBtnAdd:(id)sender;
- (IBAction)actionBtnCross:(id)sender;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
-(void)getModel:(HomeModel *)model;
@property (nonatomic, weak) id <PostDetailDelegate> delegate;

@property HomeModel *hm;
@property NSString *strImage;
@property NSString  *keyBoardHeight;
@property NSString *catID;
@property NSMutableArray *arrCategory;
@property NSInteger totalCategories;
@property UIActionSheet *actionCategories;
@property UIActionSheet *actionPhoto;
@property UIImage *imgSelectedImage;
@property SpinnerView *spinner;
@property NSString *addNew;
@property HomeModel *shiftHomeModel;

@property (strong, nonatomic) IBOutlet UIButton *btnBrowse;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *labelHeading;
@property (strong, nonatomic) IBOutlet UIButton *btnAdd;

@property (strong, nonatomic) IBOutlet UIButton *btnCross;

@property (strong, nonatomic) IBOutlet UITextField *tfTitle;
@property (strong, nonatomic) IBOutlet UITextField *tfDescription;
- (IBAction)actionBtnBrowse:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property (strong, nonatomic) IBOutlet UITextField *tfPrice;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPost;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;

@end

