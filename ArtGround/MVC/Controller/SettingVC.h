//
//  SettingVC.h
//  ArtGround
//
//  Created by Lucky Clover on 2017/06/12.
//  Copyright © 2017 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Macro.h"
#import "SpinnerView.h"
#import "LoginRegisterationModel.h"
#import "MessageTabVC.h"
#import <Google/SignIn.h>
#import <GIDGoogleUser.h>
#import "TabBarControllerVC.h"
#import "BlockedUserVC.h"
#import "TermsAndConditionsVC.h"

@interface SettingVC : UITableViewController
- (IBAction)onLogout:(id)sender;

@end
