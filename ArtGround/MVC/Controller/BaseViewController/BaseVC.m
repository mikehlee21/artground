//
//  BaseVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

@synthesize arrCategories;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initialize{
    arrCategories = [[NSMutableArray alloc]init];
    
}
-(void)showLoader{
    
}
-(void)hideLoader{
    
}

-(BOOL)internetWorking {
    
    Reachability *reachTest = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus internetStatus = [reachTest  currentReachabilityStatus];
    
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)){
        
        return NO;
    }
    else{
        
        return YES;
    }
}
- (void)showAlert:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];

    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

-(id)initWithFrame:(CGRect)frame{
    return  self;
}

-(void)logout:(NSString *)message SegueIdentifier :(NSString *) identifier{
    _identifier = identifier;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex != alertView.cancelButtonIndex){
        [self performSegueWithIdentifier:_identifier sender:nil];
    }
}
-(void)showSuccess :(NSString *)title :(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    alert.titleColor = [UIColor colorWithRed:249/255.f green:109/255.f blue:115/255.f alpha:1];
//    alert.messageColor = [UIColor lightGrayColor];
//    alert.cancelButtonColor = [UIColor colorWithRed:249/255.f green:109/255.f blue:115/255.f alpha:1];
    
    [alert show];
    
}


@end
