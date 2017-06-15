//
//  CountryVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "CountryVC.h"

@interface CountryVC ()

@end

@implementation CountryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - self made
-(void)initialize{
    //self.searchBar.tintColor = [UIColor redColor];
    
    // change search bar Outer border color to clear color
    /*
    [[UISearchBar appearance] setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"ic_search_bar"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"ic_cross"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    */
    // Setting up Search Text Field UI
    UITextField *txfSearchField = [_searchBar valueForKey:@"_searchField"];
    txfSearchField.backgroundColor = [UIColor colorWithRed:213/255.f green:213/255.f blue:213/255.f alpha:1];
    txfSearchField.textColor = [UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:1];
    [txfSearchField setValue:[UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    _tableViewCountry.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

-(void)getCountryArray:(NSMutableArray *)arrCountry : (NSString *)selectedCountry{
    _arrCountry = arrCountry;
    _arrAllCountries = arrCountry;
    _strCountry = selectedCountry;
    
}

#pragma mark - Table view delegate and Data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _arrCountry.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCell"];
    cell.labelCountry.text = [_arrCountry objectAtIndex:indexPath.row];
    if([cell.labelCountry.text isEqualToString:_strCountry]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    NSLog(@"%@",[_arrCountry objectAtIndex:indexPath.row]);
    [self.delegate getCountry:[_arrCountry objectAtIndex:indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark search Bar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchText isEqualToString:@""]){
        _arrCountry  = _arrAllCountries;
    }
    else{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    NSMutableArray * filteredCountryList = [NSMutableArray arrayWithArray:[_arrAllCountries filteredArrayUsingPredicate:predicate]];
        
    _arrCountry = filteredCountryList;
    }
    [_tableViewCountry reloadData];
    
}

@end
