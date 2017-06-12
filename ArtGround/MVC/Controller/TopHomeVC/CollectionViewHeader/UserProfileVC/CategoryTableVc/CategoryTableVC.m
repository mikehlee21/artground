//
//  CategoryTableVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 28/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "CategoryTableVC.h"

@interface CategoryTableVC ()

@end

@implementation CategoryTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellSelected = [NSMutableArray array];
    [self initialise];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - self made

-(void)initialise{
    _labelInfo.text = [NSString stringWithFormat:@"%lu/5 selected",(unsigned long)_prepareArr.count];
    _labelHeading.text = _tagsType;
    _viewTop.backgroundColor = kAppColor;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}
-(void)getArray:(NSMutableArray *)arr andType:(NSString *)type{
    _tagsType = type;
    _arrData = [arr mutableCopy];
    _prepareArr = [arr mutableCopy];
    
    if([type isEqualToString:@"Media"]){
        _arrComplete = [[UserInfo sharedUserInfo]arrMedia];
    }
    else{
        _arrComplete = [[UserInfo sharedUserInfo]arrSpecialization];
    }
}

#pragma mark - Table View data souce and Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrComplete.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];
    cell.labelName.text = [_arrComplete objectAtIndex:indexPath.row];
    
    if([_prepareArr containsObject:[_arrComplete objectAtIndex:indexPath.row]]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
//    if ([self.cellSelected containsObject:indexPath]){
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //if you want only one cell to be selected use a local NSIndexPath property instead of array. and use the code below
    //self.selectedIndexPath = indexPath;
    
    //the below code will allow multiple selection
    if ([self.prepareArr containsObject:[_arrComplete objectAtIndex:indexPath.row]])
    {
        [self.cellSelected removeObject:[_arrComplete objectAtIndex:indexPath.row]];
        [self.prepareArr removeObject:[_arrComplete objectAtIndex:indexPath.row]];
    }
    else
    {
        if(_prepareArr.count < 5 ){
        [self.cellSelected addObject:[_arrComplete objectAtIndex:indexPath.row]];
        [self.prepareArr addObject:[_arrComplete objectAtIndex:indexPath.row]];
        }
    }
    [_tableView reloadData];
    _labelInfo.text = [NSString stringWithFormat:@"%lu/5 selected",(unsigned long)_prepareArr.count];
        
    
    NSLog(@"%@",_prepareArr);
}
#pragma mark - action Button

- (IBAction)actionBtnDone:(id)sender {
    [self.delegate getArray:_prepareArr withType:_tagsType];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)actionBtnCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
