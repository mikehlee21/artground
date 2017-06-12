//
//  TagsView.h
//  ArtGround
//
//  Created by Kunal Gupta on 24/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VENTokenField.h"
#import "Macro.h"


@interface TagsView : UIView <VENTokenFieldDataSource, VENTokenFieldDelegate>

-(id)initWithFrame:(CGRect)frame andArray:(NSMutableArray *)arr;

-(void)getArr:(NSMutableArray *)arr;
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UILabel *labelHeading;
@property (strong, nonatomic) IBOutlet UIView *viewTags;

@property NSMutableArray *arrTags;
@property (weak, nonatomic) IBOutlet VENTokenField *tokenField;

- (IBAction)actionBnCancel:(id)sender;
- (IBAction)actionBtnSave:(id)sender;


@end
