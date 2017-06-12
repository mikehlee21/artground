//
//  iOSRequest.m
//  ArtGround
//
//  Created by Kunal Gupta on 03/11/15.
//  Copyright © 2015 Kunal Gupta. All rights reserved.
//

#import "iOSRequest.h"
#import "AFHTTPRequestOperation.h"

@implementation iOSRequest

+(void)getJSONResponse :(NSString *)urlStr :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
+(void)getImageResponse :(NSString *)urlStr :(void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        success(responseObject);
//        _imageView.image = responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [requestOperation start];
}


+(void)postData : (NSString *)urlStr : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
            }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              //              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
}

+(void)postMutipartRedditPost: (NSString *)urlStr :(NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        [formData appendPartWithFormData:[self convertStringToData:[parameters valueForKey:@"title"]] name:@"title"];
        [formData appendPartWithFormData:[self convertStringToData:[parameters valueForKey:@"kind"]] name:@"kind"];
        [formData appendPartWithFormData:[self convertStringToData:[parameters valueForKey:@"sr"]] name:@"sr"];
        [formData appendPartWithFormData:[self convertStringToData:[parameters valueForKey:@"captcha"] ] name:@"captcha"];
        [formData appendPartWithFormData:[self convertStringToData:[parameters valueForKey:@"iden"]] name:@"iden"];
        [formData appendPartWithFormData:[self convertStringToData:[parameters valueForKey:@"api_type"] ] name:@"api_type"];
        [formData appendPartWithFormData:[self convertStringToData:[parameters valueForKey:@"url"]] name:@"url"];
        [formData appendPartWithFormData:[self convertStringToData:[parameters valueForKey:@"uh"]] name:@"uh"];
             } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         failure(error);
     }];
}
+(void)postMutliPartData : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (NSData*) thumbnail : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        if(isImage == true){
            [formData appendPartWithFileData: data name:@"image" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
        }
        else{
            [formData appendPartWithFileData:data  name:@"video" fileName:@"filename.mp4" mimeType:@"video/quicktime"];
            [formData appendPartWithFileData:thumbnail name:@"thumb" fileName:@"temp.jpg" mimeType:@"image/jpeg"];
        }
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              //              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
}

+(void)postPic : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        if(isImage == true){
            [formData appendPartWithFileData: data name:@"image" fileName:@"temp.jpg" mimeType:@"image/jpg"];
        }
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              //              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              failure(error);
          }];
}

+(void)loginWithImage : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        if(isImage == true){
            [formData appendPartWithFileData: data name:@"profile_pic" fileName:@"temp.jpeg" mimeType:@"image/jpg"];
        }
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              //              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              failure(error);
          }];
}

+(void)updateArt : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        if(isImage == true){
            [formData appendPartWithFileData: data name:@"image" fileName:@"temp.jpg" mimeType:@"image/jpg"];
        }
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              //              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              failure(error);
          }];
}

+(void)postCoverPic : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        if(isImage == true){
            [formData appendPartWithFileData: data name:@"cover_pic" fileName:@"temp.jpg" mimeType:@"image/jpg"];
        }
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              //              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              failure(error);
          }];
}

+(void)postArt : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        if(isImage == true){
            [formData appendPartWithFileData: data name:@"media0" fileName:@"temp.jpg" mimeType:@"image/jpeg"];
        }
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              //              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              failure(error);
          }];
}
+(void)postImageMessage : (NSString *)urlStr : (NSDictionary *)parameters :(BOOL)isImage : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        if(isImage == true){
            [formData appendPartWithFileData: data name:@"media" fileName:@"temp.jpg" mimeType:@"image/jpg"];
        }
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              //              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              failure(error);
          }];    
}


+(void)postEmoticons : (NSString *)urlStr : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         failure(error);
     }];
}

+(void)postEmoticons : (NSString *)url parameters:(NSDictionary *)dparameters  success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure

{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:dparameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject)
                                  {
                                      NSError* error = nil;
                                      success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error]);
                                      
                                      
                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      failure(error);
                                      
                                  }];
    [op start];
}


+(NSData *)convertStringToData:(NSString *)str{

    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}
@end
