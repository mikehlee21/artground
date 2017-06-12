//
//  HomeVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialise];
//    [self initializeAPI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initializeAPI];
     NSLog(@"View controllers %@",self.navigationController.viewControllers);
    

}

#pragma mark - self made

-(void)startLoader{
    
    _spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_spinner];
    [_spinner startLoader];

}

-(void)stopLoader{
    [_spinner stopLoader];
    [_spinner removeFromSuperview];
}
-(void)initialise{
   
    super.tabBarItemIndex = self.tabBarItem.tag ;
    _tableViewHome.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _arrImages = [[NSMutableArray alloc]init];
    
    _accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:UD_TOKEN];
    
    [self startLoader];
    if([super internetWorking] == NO){
        [super showAlert:@"Please Check your internet connection"];
    }


}

-(void)initializeAPI{

    NSString *userID = UserID;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:_accessToken forKey:@"access_token"];
    HomeModel *model = [[HomeModel alloc]init];
    [model homeDetail:userID :dict :^(NSDictionary *response_success) {
    
        [self stopLoader];
        NSLog(@"%@",response_success);
       if([[response_success valueForKey:@"success"] integerValue] == 1){
           [_tableViewHome setHidden:NO];
           [[UserInfo sharedUserInfo] setArrCategories:[response_success valueForKeyPath:@"categories.name"]];
       [[UserInfo sharedUserInfo] setArrCatID:[response_success valueForKeyPath:@"categories.id"]];           [[UserInfo sharedUserInfo] setArrMedia:[response_success valueForKeyPath:@"medias"]];
           [[UserInfo sharedUserInfo] setArrSpecialization:[response_success valueForKeyPath:@"spec"]];
       _arrTableData = [[NSMutableArray alloc]init];
       _arrTableData = [[HomeModel parseFeedToArray:[response_success valueForKey:@"categories"]]mutableCopy];
       [_tableViewHome reloadData];
           if([[[response_success valueForKey:@"unread"] stringValue] isEqualToString:@"0"]){
               [self.tabBarController.items objectAtIndex:3].badgeValue = nil;
           }
           else {
                [self.tabBarController.items objectAtIndex:3].badgeValue = [[response_success valueForKey:@"unread"] stringValue];
//               self.tabBarItem.badgeValue = [[response_success valueForKey:@"unread"] stringValue];
           }
           
       }
       else if([[response_success valueForKey:@"success"] integerValue] == 5){
           [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_TOKEN];
           [[NSUserDefaults standardUserDefaults] setValue:nil forKey:UD_USER_INFO];
           [super logout:[response_success valueForKey:@"msg"] SegueIdentifier:@"HomeVC"];
       }
       else{
           [_tableViewHome setHidden:YES];
       }
       
   } :^(NSError *response_error) {
       NSLog(@"%@",response_error);
      [self stopLoader];
      [_labelAlert setHidden:NO];
       _labelAlert.text = @"Something went wrong. Please try again";
       [_tableViewHome setHidden:YES];
   }];
    
}

#pragma mark - tableView delegate and data sources

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrTableData.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeModel *hm = [self.arrTableData objectAtIndex:indexPath.row];

    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
    cell.labelCategoryName.text = hm.strCatName;
    NSURL *url = [NSURL URLWithString:hm.strImage];

    [cell.imageViewCategory sd_setImageWithURL:url];
    _catID = hm.strCatID;
    
    if(indexPath.row %2 == 0){
        cell.labelCategoryName.textAlignment = NSTextAlignmentRight;
    }
    else{
        cell.labelCategoryName.textAlignment = NSTextAlignmentLeft;
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *hm = [self.arrTableData objectAtIndex:indexPath.row];
    _catID = hm.strCatID;
    _catName = hm.strCatName;
    HomeCategoryDetails *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeCategoryDetails"];
    [VC getCatID: _catName :_catID];
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
