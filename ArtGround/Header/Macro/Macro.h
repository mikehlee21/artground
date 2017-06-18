//
//  Macro.h
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iOSRequest.h"
#import "Colors.h"


#define OLD_URL @"http://code-brew.com/projects/Artground/public/"
//#define BASE_URL @"http://52.34.201.105/"
#define BASE_URL @"http://192.168.1.118:8000/"
#define REDDIT_BASE_URL @"https://www.reddit.com/"

#define KEYBOARD_HEIGHT @"ArtGroundKeyBoardHeight"
#define FBUSER_ID @"ArtGroundFBUserID"
#define UD_TOKEN @"ArtGroundToken"
#define UD_USER_INFO @"ArtGroundUserInfo"
#define TOKEN [[NSUserDefaults standardUserDefaults]valueForKey:UD_TOKEN]
#define UserID [[[NSUserDefaults standardUserDefaults] valueForKey:UD_USER_INFO]valueForKey:@"id"]
#define IMAGE_URL @"@%@uploads/images/%@"
#define UserDict [[NSUserDefaults standardUserDefaults] valueForKey:UD_USER_INFO]
#define UD_GMAIL_TOKEN @"ArtGroundGmailToken"
#define UD_DEVICE_TOKEN @"ArtGroundDeviceToken"
#define UD_NOTIFICATION_INFO @"ArtGroundNotificationInfo"
#define N_NOTI_INFO @"ArtGroundNotiInfo"
#define REDDIT_ACCESS_TOKEN @"RedditAccessToken"


#define REGISTER_API @"%@user/register"
#define LOGIN_API @"%@user/login"
#define LOGOUT_API @"%@user/%@/user/logout"
#define HOME_DETAILS_API @"%@user/%@/home"
#define USER_PROFILE_API @"%@user/%@/profile"
#define UPDATE_USER_INFO_API @"%@user/%@/profile/update"
#define CATEGORY_DETAILS_API @"%@user/%@/home/%@"
#define ADD_FAVORITE_API @"%@user/%@/art/%@/save"
#define REMOVE_FAVORITE_API @"%@user/%@/art/%@/remove"
#define MARK_AS_SOLD_API @"%@user/%@/art/%@/markassold"
#define COUNT_OF_FAVORITE @"%@user/%@/art/saved"
#define COUNT_OF_ARTS_FAVORITE @"%@user/%@/art/favorites"
#define SEARCH_ART_API @"%@user/%@/search/art"
#define POST_ART @"%@user/%@/add"
#define USER_SEARCH_ARTIST_API @"%@user/%@/search/user"
#define TOP_POSTS_API @"%@user/%@/toparts"
#define FORGOT_PASSWORD_API @"%@password/forget"
#define USER_RATE_OTHER_USER @"%@user/%@/artist/%@/rate"
#define USER_VIEW_OTHER_ATRIST_PAINTINGS @"%@user/%@/artist/%@/profile"
#define USER_VIEW_OTHER_USER_PROFILE @"%@user/%@/artist/%@/profile"
#define VIEW_SINGLE_CHAT @"%@user/%@/view/%@"
#define SEND_MESSAGE_TO_SINGLE_USER @"%@user/%@/send/%@"
#define GET_NEW_MESSAGES @"%@user/%@/message/%@"
#define GET_ALL_MESSAGES @"%@user/%@/viewchats"
#define DELETE_CHAT @"%@user/%@/clearall/%@"
#define DELETE_PERSONAL_ART @"%@user/%@/part/%@/delete"
#define SEARCH_ART_IN_CATEGORY @"%@user/%@/search/%@/category"
#define UPDATE_ART @"%@user/%@/part/%@/update"
#define BLOCK_OTHER_USER @"%@user/%@/block/ouser"
#define GET_BLOCKED_LIST @"%@/user/%@/blocked/users"
#define PRIVACY_POLICY_URL @"http://52.34.201.105/privacy_policy"
#define REDDIT_LOGIN @"%@api/login"
#define REDDIT_SUBMIT @"%@api/submit"
#define GET_CAPTCHA @"%@captcha/%@.png"

@interface Macro : NSObject

@end
