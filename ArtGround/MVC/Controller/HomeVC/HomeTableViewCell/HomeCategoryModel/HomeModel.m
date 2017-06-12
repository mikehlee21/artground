//
//  HomeCategoryModel.m
//  ArtGround
//
//  Created by Kunal Gupta on 05/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (void)categorySearch:(NSString *)userID :(NSString *) catID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:SEARCH_ART_IN_CATEGORY,BASE_URL,userID,catID] :parameters :^(NSDictionary *response_success){
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}

- (void)homeDetail:(NSString *)userID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    [iOSRequest postData:[NSString stringWithFormat:HOME_DETAILS_API,BASE_URL,userID] :parameters :^(NSDictionary *response_success){
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}
-(HomeModel *)initWithAttributes:(NSDictionary*)attributes{
    
    HomeModel * fm = [[HomeModel alloc]init];
    
    fm.strCatID = [attributes objectForKey:@"id"];
    fm.strCatName = [attributes objectForKey:@"name"];
    fm.strImage = [attributes objectForKey:@"image"];
    return fm;
}
+ (NSArray*)parseFeedToArray:(NSArray*)array{
    
    NSMutableArray * arr = [NSMutableArray new];
    
    for (NSDictionary * dict  in array){
        
        HomeModel * fm = [[HomeModel alloc]initWithAttributes:dict];
        
        [arr addObject:fm];
    }
    
    return arr;
}

- (void)categoryDetail:(NSString *)userID :(NSString *) catID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    [iOSRequest postData:[NSString stringWithFormat:CATEGORY_DETAILS_API,BASE_URL,userID , catID] :parameters :^(NSDictionary *response_success){
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];

}

+ (NSArray*)parseDataToArray:(NSArray*)array{
    
    NSMutableArray * arr = [NSMutableArray new];
    
    for (NSDictionary * dict  in array){
        
        HomeModel * fm = [[HomeModel alloc]initWithAttribute:dict];
        
        [arr addObject:fm];
    }
    
    return arr;
}

-(HomeModel *)initWithAttribute:(NSDictionary*)attributes{
    
    HomeModel * fm = [[HomeModel alloc]init];
    
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
    fm.strArtistAbout = [attributes objectForKey:@"about"];
    fm.strArtistGender = [attributes objectForKey:@"artist_gender"];
    
    return fm;

}

- (void)topPosts:(NSString *)userID : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;{
    [iOSRequest postData:[NSString stringWithFormat:TOP_POSTS_API,BASE_URL,userID] :parameters :^(NSDictionary *response_success){
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}

@end
