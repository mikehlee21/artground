//
//  SearchModel.m
//  ArtGround
//
//  Created by Kunal Gupta on 16/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

-(void)getUserDetails:(NSString *)userID :(NSString *)artistID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:USER_VIEW_OTHER_USER_PROFILE,BASE_URL,userID,artistID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}

-(void)searchArt:(NSString *)userID  :(NSDictionary *)parameters :(void (^)(NSDictionary *))success :(void (^)(NSError *))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:SEARCH_ART_API,BASE_URL,userID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
+ (NSArray*)parseFeedToArray:(NSArray*)array{
    
    NSMutableArray * arr = [NSMutableArray new];
    
    for (NSDictionary * dict  in array){
        
        SearchModel * fm = [[SearchModel alloc]initWithAttribute:dict];
        
        [arr addObject:fm];
    }
    
    return arr;
}
-(SearchModel *)initWithAttribute:(NSDictionary*)attributes{
    
    SearchModel * fm = [[SearchModel alloc]init];
    
    fm.strArtistID = [attributes objectForKey:@"artist_id"];
    fm.strArtistName = [attributes objectForKey:@"artist_name"];
    fm.strCategoryID = [attributes objectForKey:@"category_id"];
    fm.strDescription = [attributes objectForKey:@"description"];
    fm.strPostImage = [attributes objectForKey:@"image"];
    fm.strArtID = [attributes objectForKey:@"id"];
    fm.strPrice = [attributes objectForKey:@"price"];
    fm.strRating = [attributes objectForKey:@"rating"];
    fm.strTitle = [attributes objectForKey:@"title"];
    fm.strUserID = [attributes objectForKey:@"user_id"];
    fm.strArtistCountry = [attributes objectForKey:@"artist_country"];
    fm.strArtistProfilePic = [attributes objectForKey:@"artist_image"];
    fm.isFavorite = [attributes objectForKey:@"is_favourite"];
     fm.strCatName = [attributes objectForKey:@"category_name"];
    return fm;
}

- (void)searchArtist:(NSString *)userID  : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:USER_SEARCH_ARTIST_API,BASE_URL,userID] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
    
}
+ (NSArray*)parseDataToArray:(NSArray*)array{

    NSMutableArray * arr = [NSMutableArray new];
    
    for (NSDictionary * dict  in array){
        
        SearchModel * fm = [[SearchModel alloc]initWithAttributes:dict];
        
        [arr addObject:fm];
    }
    
    return arr;
}
-(SearchModel *)initWithAttributes:(NSDictionary*)attributes{
    
    SearchModel * fm = [[SearchModel alloc]init];
    
    fm.strArtCount = [attributes objectForKey:@"art_count"];
    fm.strCountry = [attributes objectForKey:@"country"];
    fm.strDateOfBirth = [attributes objectForKey:@"dob"];
    fm.strEmail = [attributes objectForKey:@"email"];
    fm.strGender = [attributes objectForKey:@"gender"];
    fm.strID = [attributes objectForKey:@"id"];
    fm.strProfilePic = [attributes objectForKey:@"image"];
    fm.strMediaCount = [attributes objectForKey:@"media_count"];
    fm.strName = [attributes objectForKey:@"name"];
    fm.strUserRating = [attributes objectForKey:@"rating"];
    fm.strSpecialityCount = [attributes objectForKey:@"speciality_count"];
    fm.strTagCount = [attributes objectForKey:@"tag_count"];
    fm.arrMedia = [attributes objectForKey:@"media"];
    fm.arrSpeciality = [attributes objectForKey:@"speciality"];
    fm.arrTags = [attributes objectForKey:@"tag"];
    fm.strAboutMe = [attributes objectForKey:@"about"];
    fm.strCoverPic = [attributes objectForKey:@"cover_pic"];
    
    return fm;
}

@end
