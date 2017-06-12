//
//  ChatVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 26/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMyMessageCell.h"
#import "ChatOtherMessageCell.h"
#import "Macro.h"
#import "ChatModel.h"
#import "SpinnerView.h"
#import "ChatOtherImageCell.h"
#import "ChatMyMessageImageCell.h"
#import "ProfileHomeVC.h"
#import "UITextViewPlaceholder.h"
#import <UIImageView+WebCache.h>

@interface ChatVC : UIViewController <UITableViewDataSource , UITableViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UIActionSheetDelegate >

@property (strong, nonatomic) IBOutlet UIView *viewTop;
- (IBAction)actionBtnOptions:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnCamera;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewContentBottomConstraint;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIPlaceholderTextView *textViewMessages;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewContentConstraint;

@property (strong, nonatomic) IBOutlet UIView *viewMessage;
@property (strong, nonatomic) IBOutlet UIView *viewContent;

@property UIImage *imageCell;
@property NSString *userID;
@property NSString *artistID;
@property NSString  *keyBoardHeight;
@property SpinnerView *spinner;
@property UILabel *labelPlaceholder;
@property NSMutableArray *arrTableData;
@property NSString *message;
@property NSString *artistName;
@property NSString *artistImage;
@property NSTimer *timer;
@property NSString *timeZone;
@property NSData *dataImage;
@property NSArray *arrDates;
@property UITapGestureRecognizer *tapGesture;
@property NSMutableDictionary *dictArtist;
@property UITapGestureRecognizer * nameTapGesture;
@property UIActionSheet *actionMedia;
@property UIActionSheet *actionOptions;
@property NSString *isBlocked;

- (IBAction)actionBtnCamera:(id)sender;
- (IBAction)actionBtnSend:(id)sender;
- (IBAction)actionBtnBack:(id)sender;

-(void)getUserDetails:(NSMutableDictionary *)dict;
@end
