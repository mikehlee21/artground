//
//  CountryVC.h
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryCell.h"
#import "Macro.h"

@protocol CountryDelegate;

@interface CountryVC : UIViewController <UISearchBarDelegate>

-(void)getCountryArray:(NSMutableArray *)arrCountry : (NSString *)selectedCountry;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property NSMutableArray *arrCountry;
@property NSMutableArray *arrAllCountries;
@property NSString *strCountry;
@property (nonatomic, weak) id <CountryDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableViewCountry;
@end

@protocol CountryDelegate
-(void)getCountry:(NSString *)country;
@end