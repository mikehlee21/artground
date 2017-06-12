//
//  BlockedUserVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 30/03/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

#import "BlockedUserVC.h"

@interface BlockedUserVC ()

@end

@implementation BlockedUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hitAPI];
    [self initialise];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  SELF MADE

-(void)initialise{
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

-(void)hitAPI{
    NSString *userID = UserID;
    NSString *accessToken = TOKEN;
    [self startSpinner];
    BlockedUserModel *model = [BlockedUserModel new];

    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:accessToken forKey:@"access_token"];
    [model getBlockedList:userID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        if([[response_success valueForKey:@"success"] integerValue] == 1){
            [self handleSuccess:response_success];
        }
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        [_tableView setHidden:YES];
        _labelAlert.text = @"Something went wrong.";
    }];
}

-(void)handleSuccess:(NSDictionary *)dict{
    _arrTableData = [[BlockedUserModel parseDataToArray:[dict valueForKey:@"blocked_users"]] mutableCopy];

    if([_arrTableData count] == 0){
        [_tableView setHidden:YES];
        _labelAlert.text = @"No user blocked yet";
    }
    else{
        [_tableView setHidden:NO];
        [_tableView reloadData];
    }
}

#pragma mark - CELL DELEGATE

-(void)unblockUser:(NSIndexPath *)index{
    
    [self startSpinner];
    NSString *userID = UserID;

    ChatModel *model = [ChatModel new];
    NSString *accessToken = TOKEN;
    NSMutableDictionary *dict  = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
    [dict setObject:@"0" forKey:@"art"];
    [dict setObject:[[_arrTableData objectAtIndex:index.row] strUserID] forKey:@"oid"];
    [dict setObject:@"0" forKey:@"block"];
    
    [model blockUser:userID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        [self handleUnblockSuccess:response_success :index];
    } :^(NSError *response_error) {
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        NSLog(@"%@",response_error);
    }];
}

-(void)handleUnblockSuccess:(NSDictionary *)dict :(NSIndexPath *)index{

    if([[dict valueForKey:@"success"] integerValue] == 1){

        NSArray *deleteIndexPaths = [[NSArray alloc] initWithObjects:index,nil];
        [self.tableView beginUpdates];
        
        [_arrTableData removeObject:[_arrTableData objectAtIndex:index.row]];
        [self.tableView deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        
        if([_arrTableData count] == 0){
            [_tableView setHidden:YES];
            _labelAlert.text = @"No user blocked yet";
   }
    }
}

-(void)startSpinner{
    _spinner  = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    [kWindow addSubview:_spinner];
    [_spinner startLoader];
}

#pragma mark - TABLE VIEW DELEGATES AND DATA SOURCES

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrTableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BlockedUserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlockedUserTableCell"];
    cell.index = indexPath;
    cell.delegate = self;
    [cell configureCell:[_arrTableData objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark - ACTION BUTTONS

- (IBAction)actionBtnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
