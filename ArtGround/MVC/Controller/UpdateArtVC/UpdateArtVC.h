//
//  UpdateArtVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 30/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "Macro.h"
#import <UIImageView+WebCache.h>
#import "UserInfo.h"
#import "BaseVC.h"
#import "SpinnerView.h"
#import "PostActivityModel.h"


@interface UpdateArtVC : BaseVC <UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *viewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewPost;
@property (strong, nonatomic) IBOutlet UITextField *tfTitle;
@property (strong, nonatomic) IBOutlet UITextField *tfPrice;
@property (strong, nonatomic) IBOutlet UITextField *tfDescription;

@property (strong, nonatomic) IBOutlet UIButton *btnBrowse;
@property (strong, nonatomic) IBOutlet UIButton *btnCross;

@property UIActionSheet *actionCategories;
@property UIActionSheet *actionPhoto;
@property HomeModel *hm;
@property CGFloat keyBoardHeight;
@property NSMutableArray   *arrCategory;
@property NSString *strImage;
@property NSString *catID;



-(void)getModel:(HomeModel *)model;


- (IBAction)actionBtnUpload:(id)sender;
- (IBAction)actionBtnBrowse:(id)sender;
- (IBAction)actionBtnCross:(id)sender;
- (IBAction)actionBtnUpdate:(id)sender;
- (IBAction)actionBtnBack:(id)sender;


@end
