//
//  ChatVC.m
//  ArtGround
//
//  Created by Kunal Gupta on 26/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "ChatVC.h"

@interface ChatVC ()

@end

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initalise];
    [self initializeAPI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:_artistID,@"id", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNotificationForUserID" object:dict];
}
-(void)viewDidDisappear:(BOOL)animated{
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"0",@"id", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNotificationForUserID" object:dict];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    

    if([_isBlocked integerValue] == 1){
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:0.5 animations:^{
            _heightViewContentConstraint.constant = 0;

        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - self made

-(void)startTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerRanOut:) userInfo:nil repeats:YES];
}

-(void)startSpinner{
    _spinner = [[SpinnerView alloc]initWithFrame:CGRectMake(0, 0, kframe.width, kframe.height) andColor:[UIColor whiteColor]];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_spinner];
    [_spinner startLoader];
}

-(void)initalise{
    
    _nameTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nameTapped:)];
    [_labelName addGestureRecognizer:_nameTapGesture];
    
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedTableView:)];
    [_tableView addGestureRecognizer:_tapGesture];
    
    _textViewMessages.placeholder = @"Hey, I'm interested in buying...";
    _textViewMessages.backgroundColor = [UIColor clearColor];
    
    _viewTop.backgroundColor = kAppColor;
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    _timeZone = [timeZone name];
    
    _imageViewProfilePic.layer.cornerRadius = _imageViewProfilePic.frame.size.width/2;
    [_imageViewProfilePic setClipsToBounds:YES];
    
    _labelName.text = _artistName;
//    [_imageViewProfilePic sd_setImageWithURL:[NSURL URLWithString:_artistImage] placeholderImage:kDefaultPic];

    //_viewMessage.layer.borderColor = [[UIColor colorWithRed:255/255.f green:99/255.f blue:100/255.f alpha:1]CGColor] ;
    //_viewMessage.layer.borderWidth = 2.0;
    _viewMessage.layer.cornerRadius = 5.0;
    //_viewContent.backgroundColor = [UIColor whiteColor];
    
    _labelPlaceholder = [[UILabel alloc] init];
    [_labelPlaceholder.font fontWithSize:10.0f];
    _labelPlaceholder.text = @"Hey,iring you!";
    [_labelPlaceholder setBackgroundColor:[UIColor redColor]];
    [_labelPlaceholder setTextColor:[UIColor lightGrayColor]];
    [_textViewMessages.layer addSublayer:_labelPlaceholder.layer];
    
    _textViewMessages.delegate = self;
    [self startSpinner];
    
   
}

-(void)initializeAPI{
    ChatModel *model = [[ChatModel alloc]init];
    NSString *userID = UserID;
    NSString *accessToken = TOKEN;
    NSMutableDictionary *dict  = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
    [dict setObject:_timeZone forKey:@"zone"];
    
    [model viewSingleUserChat:userID :_artistID :dict :^(NSDictionary *response_success) {
        [self startTimer];
        NSLog(@"%@",response_success);
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        if([[response_success valueForKey:@"success"] integerValue ] == 1){
            _arrTableData = [[NSMutableArray alloc]init];
            _arrTableData = [[ChatModel parseDataToArray:[response_success valueForKey:@"msg"]] mutableCopy] ;
            
            _arrDates = [NSArray new];
            _arrDates = [response_success valueForKeyPath:@"msg.date"];
            NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:_arrDates];
            _arrDates = [orderedSet array];
            
            [_tableView reloadData];
            
            if(_arrTableData.count != 0){
                NSIndexPath* ipath = [NSIndexPath indexPathForRow: _arrTableData.count-1 inSection: 0];
                [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: NO];
            }

        }
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
    }];
}

-(void)scrollTableToLastComment:(BOOL)animated{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if([_arrTableData count] >0){
        NSIndexPath* ipath = [NSIndexPath indexPathForRow: _arrTableData.count-1 inSection: 0];
        [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
        }
    });
}

-(void)tappedTableView:(UITapGestureRecognizer*)gesture{
    
    CGPoint point = [gesture locationInView:_tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    if ([_textViewMessages isFirstResponder]){
        
        [self.view endEditing:YES];
    }
    else{
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
-(void)nameTapped:(UITapGestureRecognizer *)tap{
    ProfileHomeVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileHomeVC"];
   
    [VC getArtistDetails:_dictArtist];
    [self.navigationController pushViewController:VC animated:YES];
    [_timer invalidate];
    
}

-(void)timerRanOut:(NSTimer *)timer{
    
    ChatModel *model = [[ChatModel alloc]init];
    NSString *userID = UserID;
    NSString *lastMessageID = [[_arrTableData lastObject] strmessageID];
    NSString *accessToken = TOKEN;
    NSMutableDictionary *dict  = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
    [dict setObject:_artistID forKey:@"id"];
    [dict setObject:_timeZone forKey:@"zone"];
    
    if(lastMessageID == nil) {
        lastMessageID = @"0";
    }
    [model getNewMessage:userID :lastMessageID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        if([[response_success valueForKey:@"success"] integerValue ] == 1){
            NSMutableArray *arrNewMessages = [[NSMutableArray alloc]init];
            arrNewMessages = [[ChatModel parseDataToArray:[response_success valueForKey:@"msg"]] mutableCopy] ;
            [_arrTableData addObjectsFromArray:arrNewMessages];
            [self scrollTableToLastComment:YES];
            [_tableView reloadData];
        }
    } :^(NSError *response_error) {
        NSLog(@"%@",response_error);
    }];
}

-(void)hitBlockAPI{
    
    [self startSpinner];
    _userID = UserID;
    ChatModel *model = [ChatModel new];
    NSString *accessToken = TOKEN;
    NSMutableDictionary *dict  = [[NSMutableDictionary alloc]init];
    [dict setObject:accessToken forKey:@"access_token"];
    [dict setObject:_artistID forKey:@"oid"];
    [dict setObject:@"0" forKey:@"art"];
    [dict setObject:[NSString stringWithFormat:@"%d",![_isBlocked integerValue]] forKey:@"block"];
    
    [model blockUser:_userID :dict :^(NSDictionary *response_success) {
        NSLog(@"%@",response_success);
        if([[response_success valueForKeyPath:@"success"] integerValue] == 1){
            _isBlocked = [NSString stringWithFormat:@"%d",![_isBlocked integerValue]];
            if([_isBlocked integerValue] == 1){
                [self.view layoutIfNeeded];
                [UIView animateWithDuration:0.5 animations:^{
                    [self.viewContent layoutIfNeeded];
                    _heightViewContentConstraint.constant = 0;
                }completion:^(BOOL finished) {
                    [self scrollTableToLastComment:YES];
                    [_tableView reloadData];
                }];
            }
            else{
                [self.view layoutIfNeeded];
                    [UIView animateWithDuration:0.5 animations:^{
                    _heightViewContentConstraint.constant = 48;
                }completion:^(BOOL finished) {
                    [self scrollTableToLastComment:YES];
                    [_tableView reloadData];
                }];
            }
        }
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
            
    } :^(NSError *response_error) {
        [_spinner stopLoader];
        [_spinner removeFromSuperview];
        NSLog(@"%@",response_error);
    }];
}


#pragma mark - keyboard Methods

- (void)keyboardDidShow: (NSNotification *) notif{
    [self liftView];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    if (![_textViewMessages hasText]) {
        _labelPlaceholder.hidden = NO;
    }
    [self resetView];
    
}

-(void)resetView{
    _viewContentBottomConstraint.constant = 4;
}

-(void) liftView{
    _viewContentBottomConstraint.constant = [_keyBoardHeight integerValue];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void) keyboardWillChangeFrame:(NSNotification*)notification {
    
    NSDictionary* notificationInfo = [notification userInfo];
    CGRect keyboardFrame = [[notificationInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:[[notificationInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] delay:0 options:[[notificationInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] animations:^{
        _keyBoardHeight = [NSString stringWithFormat:@"%f",keyboardFrame.size.height];
        [self liftView];
        } completion:nil];
}

-(void)getUserDetails:(NSMutableDictionary *)dict{
    _dictArtist = dict;
    _artistID = [dict valueForKey:@"id"];
    _artistImage = [dict valueForKey:@"image"];
    _artistName = [dict valueForKey:@"name"];
    _isBlocked = [dict valueForKeyPath:@"blocked"];
}

#pragma  mark - touches Began

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - text view delagate

//-(void)textViewDidBeginEditing:(UITextView *)textView{
//    _viewContentBottomConstraint.constant = _keyBoardHeight;
//
//    [self.view setNeedsUpdateConstraints];
//    [self.view updateConstraintsIfNeeded];
//    [UIView animateWithDuration:0.2 animations:^{
//        [self.view layoutIfNeeded];
//    }];
//
//}
//-(void)textViewDidEndEditing:(UITextView *)textView{
//    _viewContentBottomConstraint.constant = 0;
//}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (void) textViewDidChange:(UITextView *)textView{
    
    if(![textView hasText]) {
        _labelPlaceholder.hidden = NO;
    }
    else{
        _labelPlaceholder.hidden = YES;
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if(_arrTableData.count > 0){
    [self scrollTableToLastComment:YES];
    }
}

#pragma mark - Table View Data sources and Delegate

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//  return _arrDates.count;
//}
//- (UIView *) tableview:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view;
//    if(section == 0) {
//        view.backgroundColor = [UIColor redColor];
//    } else {
//        view.backgroundColor = [UIColor greenColor];
//    }
//    return view;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrTableData count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatModel *cm = [_arrTableData objectAtIndex:indexPath.row];
    
    ChatMyMessageCell *myMessage = [tableView dequeueReusableCellWithIdentifier:@"ChatMyMessageCell"];
    ChatOtherMessageCell *otherMessage = [tableView dequeueReusableCellWithIdentifier:@"ChatOtherMessageCell"];
    ChatMyMessageImageCell *myImageCell = [tableView dequeueReusableCellWithIdentifier:@"ChatMyMessageImageCell"];
    ChatOtherImageCell *otherImageCell = [tableView dequeueReusableCellWithIdentifier:@"ChatOtherImageCell"];
    
    NSString *userID = UserID;
    
    
    if([cm.strSendBy integerValue] == [userID integerValue]){
        
        if((cm.strMedia.length != 0) || (cm.imageMessage != nil)){
            if(indexPath.row == 0){
                myImageCell.heightViewDate.constant = 24;
                
            }
            else{
                ChatModel *pm = [_arrTableData objectAtIndex:indexPath.row-1];
                if([pm.strDate isEqualToString:cm.strDate]){
                    myImageCell.heightViewDate.constant = 0;
                }
                else{
                    myImageCell.heightViewDate.constant = 24;
                }
            }
            
            
            if(cm.strMedia.length != 0){
                [myImageCell.imageViewMessage sd_setImageWithURL:[NSURL URLWithString:cm.strMedia]];
                myImageCell.strImage = cm.strMedia;
            }
            else{
                myImageCell.imageViewMessage.image = cm.imageMessage;
                myImageCell.imageMessage = cm.imageMessage;
            }
            myImageCell.labelDate.text = cm.strDate;
            return myImageCell;
        }
        else{
            if(indexPath.row == 0){
                myMessage.heightViewDate.constant = 24;
            }
            else{
                ChatModel *pm = [_arrTableData objectAtIndex:indexPath.row-1];
                if([pm.strDate isEqualToString:cm.strDate]){
                    myMessage.heightViewDate.constant = 0;
                }
                else{
                    myMessage.heightViewDate.constant = 24;
                }
            }
            
            myMessage.viewMyMessage.layer.cornerRadius = 10.0;
            myMessage.labelMyMessage.text = cm.strMessage;
            myMessage.labelDate.text = cm.strDate;
            
            /*
            myMessage.viewMyMessage.backgroundColor = [UIColor whiteColor];
            myMessage.viewMyMessage.layer.borderColor = [[UIColor colorWithRed:255/255.f green:99/255.f blue:100/255.f alpha:1] CGColor];
            myMessage.viewMyMessage.layer.borderWidth = 2.0;
            myMessage.labelMyMessage.textColor = kAppColor;
            myMessage.labelMyMessage.font = [UIFont fontWithName:@"MyriadPro-Regular" size:15.0];
            */
            return myMessage;
        }
    }
    else{
        
        
        if((cm.strMedia.length != 0) || (cm.imageMessage != nil)){
            
            if(indexPath.row == 0){
                otherImageCell.heightViewDate.constant = 24;
                
            }
            else{
                ChatModel *pm = [_arrTableData objectAtIndex:indexPath.row-1];
                if([pm.strDate isEqualToString:cm.strDate]){
                    otherImageCell.heightViewDate.constant = 0;
                }
                else{
                    otherImageCell.heightViewDate.constant = 24;
                }
            }

           if(cm.strMedia.length != 0){
                [otherImageCell.imageViewMessage sd_setImageWithURL:[NSURL URLWithString:cm.strMedia]];
                otherImageCell.strImage = cm.strMedia;
            }
            else{
                otherImageCell.imageViewMessage.image = cm.imageMessage;
                otherImageCell.imageMessage = cm.imageMessage;
            }
            otherImageCell.labelDate.text = cm.strDate;
            return otherImageCell;
        }
        else{
            if(indexPath.row == 0){
                otherMessage.heightViewdate.constant = 24;
                
            }
            else{
                
                ChatModel *pm = [_arrTableData objectAtIndex:indexPath.row-1];
                if([pm.strDate isEqualToString:cm.strDate]){
                    otherMessage.heightViewdate.constant = 0;
                }
                else{
                    otherMessage.heightViewdate.constant = 24;
                }
            }
            
            otherMessage.viewOtherMessage.layer.cornerRadius = 10.0;
            otherMessage.labelOtherMessage.text = cm.strMessage;
            otherMessage.labelDate.text = cm.strDate;
            
            /*
            otherMessage.viewOtherMessage.backgroundColor = kAppColor;
            otherMessage.labelOtherMessage.textColor = [UIColor whiteColor];
            otherMessage.labelOtherMessage.font = [UIFont fontWithName:@"MyriadPro-Regular" size:15.0];
            */
            return otherMessage;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - action Sheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet == _actionMedia){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        if (buttonIndex == 0){
            // open camera
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:NULL];
        }
        else if(buttonIndex == 1){
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [NSArray arrayWithObjects : (NSString *) kUTTypeImage , nil];
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
    else{
        if (buttonIndex == 0){
            if (buttonIndex == 0){
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"Do you want to block this user?" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self hitBlockAPI];
                }]];
                
                
                dispatch_async(dispatch_get_main_queue(), ^ {
                    [self presentViewController:alertController animated:YES completion:nil];
                });
                
            }
        }
    }
}

#pragma mark - imagePicker Delegate


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy"];
        NSString *date = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
        
        NSData *profilePicData = UIImagePNGRepresentation(info[UIImagePickerControllerEditedImage]);
        
        _imageCell = info[UIImagePickerControllerEditedImage];
        ChatModel *cm = [[ChatModel alloc]init];
        cm.imageMessage =  info[UIImagePickerControllerEditedImage];
        
        if([_arrTableData lastObject] != nil){
            NSUInteger messageID = [[[_arrTableData lastObject] strmessageID] integerValue] + 1;
            cm.strmessageID = [NSString stringWithFormat:@"%lu",(unsigned long)messageID];
        }
        else{
            cm.strmessageID = [NSString stringWithFormat:@"1"];
        }
        
        cm.strSendBy = [NSString stringWithFormat:@"%@",UserID];
        cm.strDate = date;
        [_arrTableData addObject:cm];
        
        [self scrollTableToLastComment:YES];
        
        [_tableView reloadData];
        
        NSString *userID = UserID;
        NSString *accessToken = TOKEN;
        NSMutableDictionary *dict  = [[NSMutableDictionary alloc]init];
        [dict setObject:accessToken forKey:@"access_token"];
        //        [dict setObject:_artistID forKey:@"id"];
        [dict setObject:_timeZone forKey:@"zone"];
        
        ChatModel *model = [[ChatModel alloc]init];
        [model sendImageMessage:userID :_artistID :dict :profilePicData :YES :^(NSDictionary *response_success) {
            NSLog(@"%@",response_success);
        } :^(NSError *response_error) {
            NSLog(@"%@",response_error);
        }];
        
    }];
}

#pragma mark - Action Button

- (IBAction)actionBtnBack:(id)sender {
    NSArray *arrControllers = self.navigationController.viewControllers;
    
    for (int i = (int) arrControllers.count; i>0; i--) {
        
        if (![arrControllers[i-1] isKindOfClass:[self class]]) {
            [self.navigationController popToViewController:arrControllers[i-1] animated:YES];
            break;
        }
    }
    [_timer invalidate];
}


- (IBAction)actionBtnSend:(id)sender{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    NSString *date = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    
    
    _message = [_textViewMessages.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(![_message isEqualToString:@""]){
        _textViewMessages.text = @"";
        ChatModel *cm = [[ChatModel alloc]init];
        if([_arrTableData lastObject] != nil){
            NSUInteger messageID = [[[_arrTableData lastObject] strmessageID] integerValue] + 1;
            cm.strmessageID = [NSString stringWithFormat:@"%lu",(unsigned long)messageID];
        }
        else{
            cm.strmessageID = [NSString stringWithFormat:@"1"];
            _arrTableData = [[NSMutableArray alloc]init];
        }
        
        [_arrTableData addObject:cm];
       
        cm.strMessage = _message;
        cm.strSendBy = [NSString stringWithFormat:@"%@",UserID];
        cm.strDate = date;
        
        [self scrollTableToLastComment:YES];
        
        
        [_tableView reloadData];
        
        
        ChatModel *model = [[ChatModel alloc]init];
        NSString *userID = UserID;
        NSString *accessToken = TOKEN;
        NSMutableDictionary *dict  = [[NSMutableDictionary alloc]init];
        [dict setObject:accessToken forKey:@"access_token"];
        [dict setObject:_message forKey:@"message"];
        
        [model sendMessage:userID :_artistID :dict :^(NSDictionary *response_success) {
            NSLog(@"%@",response_success);
            //            if(_arrTableData.count == 1){
            //               cm.strmessageID = [NSString stringWithFormat:@"%@",[response_success valueForKey:@"msg_id"]];
            //            }
        } :^(NSError *response_error) {
            NSLog(@"%@",response_error);
        }];
    }
}

- (IBAction)actionBtnCamera:(id)sender {
    [self.view endEditing:YES];
    _actionMedia = [[UIActionSheet alloc]initWithTitle:@"Choose mode" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Library", nil];
    [_actionMedia showInView:self.view];
}

- (IBAction)actionBtnOptions:(id)sender {
    [self.view endEditing:YES];
    NSString *strBlocked = @"Unblock";

    if([_isBlocked integerValue] == 0){
        strBlocked = @"Block";
    }
    
    _actionOptions = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:strBlocked, nil];
    [_actionOptions showInView:self.view];
}

@end
