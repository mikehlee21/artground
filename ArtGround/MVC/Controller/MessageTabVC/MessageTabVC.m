//
//  MessageTabVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "MessageTabVC.h"

@interface MessageTabVC ()

@end

@implementation MessageTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialise];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPushData:) name:@"send_data" object:nil];
    
    [self initializeAPI];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)startSpinner{
    _spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_spinner];
    [_spinner startLoader];
}
-(void)stopSpinner{
    [_spinner stopLoader];
    [_spinner removeFromSuperview];
}

-(void)initialise{
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    _viewTop.backgroundColor = kAppColor;
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    _timeZone = [timeZone name];
    
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//     _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerRanOut:) userInfo:nil repeats:YES];
    [self startSpinner];
    if([super internetWorking] == NO){
        [super showAlert:@"Please Check your internet connection"];
    }

    
}

-(void)initializeAPI{
    
    ChatModel *model = [[ChatModel alloc]init];
    NSString *userID = UserID;
    NSString *accessToken = TOKEN;
    NSMutableDictionary *dict  = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
    [dict setObject:_timeZone forKey:@"zone"];
    
    [model getAllMessages:userID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        [self stopSpinner];
        
        if([[response_success valueForKey:@"success"] integerValue] == 1){
            [_tableView setHidden:NO];
            _arrTableData = [[NSMutableArray alloc]init];
        _arrTableData = [[ChatModel parseFeedToArray:[response_success valueForKey:@"msg"]] mutableCopy] ;
        [_tableView reloadData];
            NSString *badgeValue = [[response_success valueForKey:@"unread_count"] stringValue];
            if([badgeValue isEqualToString:@"0"]){
            self.tabBarItem.badgeValue = nil;
                [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            }
            else {
                self.tabBarItem.badgeValue = badgeValue;
                [UIApplication sharedApplication].applicationIconBadgeNumber = [badgeValue integerValue];
            }
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[response_success valueForKey:@"unread_count"]  integerValue]];

        }
        else{
            [_tableView setHidden:YES];
        }
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [self stopSpinner];
    }];
}

//-(void)timerRanOut:(NSTimer *)timer{
//    [self initializeAPI];
//}

-(void)deleteChat{
    NSString *userID = UserID;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[NSString stringWithFormat:@"%@",TOKEN] forKey:@"access_token"];
    
    ChatModel *chat = [[ChatModel alloc]init];
    [chat deleteChat:userID :_artistID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        [self initializeAPI];
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
    }];
}

-(void)getPushData:(NSNotification *)noti{
    _artistID = [noti.userInfo valueForKey:@"id"];
    _artistName = [noti.userInfo valueForKey:@"name"];
    _artistPic = [noti.userInfo valueForKey:@"pic"];
 
        ChatVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
//        [VC getUserDetails:_artistID:_artistName :_artistPic];
        [self.navigationController pushViewController:VC animated:NO];
}

#pragma mark - Alert View delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        [self deleteChat];
        [self startSpinner];
    }
    else if(buttonIndex == 1){
    
    }
}

#pragma mark - table view delegate and data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrTableData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatModel *cm = [_arrTableData objectAtIndex:indexPath.row];
    
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell"];
    cell.labelName.text = cm.strName;
    cell.labelMessage.text = cm.message;
    cell.labelTime.text = cm.strTime;
    
    cell.labelName.font = [UIFont fontWithName:@"Gotham bold" size:15.0];
    cell.labelName.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    cell.labelMessage.font = [UIFont fontWithName:@"Omnes_GirlScouts-Medium" size:12.0];
    cell.labelMessage.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    cell.labelTime.font = [UIFont fontWithName:@"Omnes_GirlScouts-Medium" size:9.0];
    cell.labelTime.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    
    
    NSString* wholeImageUrl = [NSString stringWithFormat:@"https://artground.xyz/artground/%@", cm.strProfilePic];
    [cell.imageViewProfilePIc sd_setImageWithURL:[NSURL URLWithString:wholeImageUrl] placeholderImage:kDefaultPic];
    
    if([cm.strUnread integerValue] != 0){
        [cell.viewBadge setHidden:NO];
        cell.labelBadge.text = cm.strUnread;
    
    }
    else{
        [cell.viewBadge setHidden:YES];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    ChatModel *cm = [_arrTableData objectAtIndex:indexPath.row];
    ChatVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:cm.strArtistID,@"id",cm.strName,@"name",cm.strProfilePic,@"image",cm.strBlocked,@"blocked" ,nil];
    [VC getUserDetails:dict];
    [self.navigationController pushViewController:VC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatModel *cm = [_arrTableData objectAtIndex:indexPath.row];

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        _artistID = cm.strArtistID;
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Do you want to delete this chat?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
        [alert show];
    }
}

#pragma mark - action buttons

- (IBAction)actionBtnSound:(id)sender {
}
- (IBAction)actionBtnMenu:(id)sender {
}
@end
