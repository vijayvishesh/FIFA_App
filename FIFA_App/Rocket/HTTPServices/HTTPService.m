//
//  HTTPService.m
//
//  Created by Ashish Sharma on 30/05/15.
//  Copyright (c) 2015 Konstant Info. All rights reserved.
//

#import "HTTPService.h"

@interface HTTPService ()

/**
 *  Call this to set HTTP headers for request
 *
 *  @param headers HTTP headers
 */
- (void) setHeaders:(NSDictionary*) headers;

/**
 *  Call this to convert params in raw json format
 *
 *  @param params params to post
 */
- (void) addQueryStringWithParams:(NSDictionary*) params;

@end

@implementation HTTPService

#pragma mark - Designated Initializer

- (id)initWithBaseURL:(NSURL*) baseURL andSessionConfig:(NSURLSessionConfiguration*) config
{
    self = [super init];
    
    if (self)
    {
        NSAssert (baseURL, ([NSString stringWithFormat:@"\n<------------------->\n%@\n%sn<------------------->",@"baseURL can't be nil",__PRETTY_FUNCTION__]));
        
        httpBaseURL = [baseURL absoluteString];
        
        if (config)
            httpSessionManager = [[AFHTTPSessionManager alloc]
                                  initWithBaseURL:baseURL sessionConfiguration:config];
        else
            httpSessionManager = [[AFHTTPSessionManager alloc]
                                  initWithBaseURL:baseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        httpSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

#pragma mark - Super Class Methods

- (id)init
{
    self = [super init];
    
    if (self)
    {
        httpBaseURL = BASE_URL;
        
        httpSessionManager = [[AFHTTPSessionManager alloc]
                              initWithBaseURL:[NSURL URLWithString:httpBaseURL]];
        httpSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        httpSessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

- (void)dealloc
{
    httpSessionManager = nil;
}

#pragma mark - Instance Methods (Private)

- (void) setHeaders:(NSDictionary*) headers
{
    if (headers != nil)
    {
        NSArray *allHeaders = [headers allKeys];
        
        for (NSString *key in allHeaders)
        {
            [httpSessionManager.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
        }
    }
}

- (void) addQueryStringWithParams:(NSDictionary*) params
{
    [httpSessionManager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        __block NSMutableString *query = [NSMutableString stringWithString:@""];
        
        NSError *err;
        NSData *jsonData = [NSJSONSerialization  dataWithJSONObject:params options:0 error:&err];
        NSMutableString *jsonString = [[NSMutableString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        query = jsonString;
        
        return query;
    }];
}

#pragma mark - Instance Methods

- (void) startRequestWithHttpMethod:(kHttpMethodType) httpMethodType
                    withHttpHeaders:(NSMutableDictionary*) headers
                    withServiceName:(NSString*) serviceName
                     withParameters:(NSMutableDictionary*) params
                        withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        withFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSAssert(serviceName, ([NSString stringWithFormat:@"\n<------------------->\n%@\n%sn<------------------->",@"serviceName can't be nil",__PRETTY_FUNCTION__]));
    
    NSString *serviceUrl = [httpBaseURL stringByAppendingPathComponent:serviceName];
    NSLog(@"serviceUrl important full%@",serviceUrl);
    if (headers == nil)
    {
        NSDictionary *headers = [[NSDictionary alloc] initWithObjectsAndKeys:@"application/json; charset=utf-8",@"Content-Type",@"ios",@"os",@"en",@"language",@"1.0",@"version",nil];
        [self setHeaders:headers];
    }
    else
    {
        [headers setObject:@"application/json" forKey:@"Accept"];
        [headers setObject:@"application/json; charset=utf-8" forKey:@"Content-Type"];
        [self setHeaders:headers];
    }
    
    if (params != nil)
        [self addQueryStringWithParams:params];
    
    switch (httpMethodType)
    {
        case kHttpMethodTypeGet:
        {
            [httpSessionManager GET:serviceUrl
                         parameters:params
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                                if (success != nil) {
                                    NSLog(@"Response :==> %@", responseObject);
                                    success(task,responseObject);
                                }
                            }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                
                                if (failure != nil) {
                                    [self handleErrorCode:error withTask:task];
                                    failure(task,error);
                                }
                            }];
        }
            break;
        case kHttpMethodTypePost:
        {
            NSLog(@"Parameters -> %@",params);
            
            [httpSessionManager POST:serviceUrl
                          parameters:params
                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                 
                                 if (success != nil) {
                                     NSLog(@"Response :==> %@", responseObject);
                                     success(task,responseObject);
                                 }
                             }
                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                 
                                 if (failure != nil) {
                                     [self handleErrorCode:error withTask:task];
                                     failure(task,error);
                                 }
                             }];
        }
            break;
        case kHttpMethodTypeDelete:
        {
            [httpSessionManager DELETE:serviceUrl
                            parameters:params
                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                   
                                   if (success != nil)
                                       success(task,responseObject);
                               }
                               failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   
                                   if (failure != nil) {
                                       [self handleErrorCode:error withTask:task];
                                       failure(task,error);
                                   }
                               }];
        }
            break;
        case kHttpMethodTypePut:
        {
            [httpSessionManager PUT:serviceUrl
                         parameters:params
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                                if (success != nil)
                                    success(task,responseObject);
                            }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                
                                if (failure != nil) {
                                    [self handleErrorCode:error withTask:task];
                                    failure(task,error);
                                }
                            }];
        }
            break;
            
        default:
            break;
    }
}

- (void) uploadFileRequestWithHttpHeaders:(NSMutableDictionary*) headers
                          withServiceName:(NSString*) serviceName
                           withParameters:(NSMutableDictionary*) params
                             withFileData:(NSArray*) files
                              withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              withFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSAssert(serviceName, ([NSString stringWithFormat:@"\n<------------------->\n%@\n%sn<------------------->",@"serviceName can't be nil",__PRETTY_FUNCTION__]));
    
    NSString *serviceUrl = [httpBaseURL stringByAppendingPathComponent:serviceName];
    
    NSString *imageName = nil;
    if (headers == nil)
    {
        NSDictionary *headers = [[NSDictionary alloc] initWithObjectsAndKeys:@"multipart/form-data",@"Content-Type",@"ios",@"os",@"en",@"language",@"1.0",@"version",nil];
        [self setHeaders:headers];
    }
    else
    {
        if ([self isNotNull:[headers objectForKey:@"name"]]) {
            imageName = [headers objectForKey:@"name"];
            [headers removeObjectForKey:@"name"];
        }
        
        [headers setObject:@"multipart/form-data" forKey:@"Content-Type"];
        [headers setObject:@"ios" forKey:@"os"];
        [headers setObject:@"en" forKey:@"language"];
        [headers setObject:@"1.0" forKey:@"version"];
        
        [self setHeaders:headers];
    }
    
    [httpSessionManager POST:serviceUrl
                  parameters:params
   constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       
       if (files.count>0) {
           [formData appendPartWithFileData:[files objectAtIndex:0] name:imageName fileName:[NSString stringWithFormat:@"%@.jpg",imageName] mimeType:@"image/jpeg"];
       }
   }
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         
                         if (success != nil) {
                             NSLog(@"Response :==> %@", responseObject);
                             success(task,responseObject);
                         }
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         
                         if (failure != nil) {
                             [self handleErrorCode:error withTask:task];
                             failure(task,error);
                         }
                     }];
}

- (void) uploadMultipleFileRequestWithHttpHeaders:(NSMutableDictionary*) headers
                          withServiceName:(NSString*) serviceName
                           withParameters:(NSMutableDictionary*) params
                             withFileData:(NSArray*) files
                              withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              withFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSAssert(serviceName, ([NSString stringWithFormat:@"\n<------------------->\n%@\n%sn<------------------->",@"serviceName can't be nil",__PRETTY_FUNCTION__]));
    
    NSString *serviceUrl = [httpBaseURL stringByAppendingPathComponent:serviceName];
    
    if (headers == nil)
    {
        NSDictionary *headers = [[NSDictionary alloc] initWithObjectsAndKeys:@"multipart/form-data",@"Content-Type",@"ios",@"os",@"en",@"language",@"1.0",@"version",nil];
        [self setHeaders:headers];
    }
    else
    {
        [headers setObject:@"multipart/form-data" forKey:@"Content-Type"];
        [headers setObject:@"ios" forKey:@"os"];
        [headers setObject:@"en" forKey:@"language"];
        [headers setObject:@"1.0" forKey:@"version"];
        
        [self setHeaders:headers];
    }
    
    NSArray *imgsNameAry = [params objectForKey:@"images_name"];
    
    [params removeObjectForKey:@"images_name"];
    
    [httpSessionManager POST:serviceUrl
                  parameters:params
   constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       
       for (int i = 0; i< files.count; i++) {
           [formData appendPartWithFileData:[files objectAtIndex:i] name:imgsNameAry[i] fileName:[NSString stringWithFormat:@"%@.jpg",imgsNameAry[i]] mimeType:@"image/jpeg"];
       }
   }
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         
                         if (success != nil) {
                             NSLog(@"Response :==> %@", responseObject);
                             success(task,responseObject);
                         }
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         
                         if (failure != nil) {
                             [self handleErrorCode:error withTask:task];
                             failure(task,error);
                         }
                     }];
}

-(void)handleErrorCode:(NSError*)error withTask:(NSURLSessionDataTask*)task
{
    NSLog(@"Error Code IS = %@",[error description]);
    if (error.code==-1004)    {
        [CommonFunctions alertTitle:@"TripMood" withMessage:NSLocalizedString(@"ERROR_NETWROK_1004", @"") withDelegate:self];
    }
    else if(error.code==-1005)
    {
        [CommonFunctions alertTitle:@"TripMood" withMessage:NSLocalizedString(@"ERROR_NETWROK_1005", @"") withDelegate:self];
    }
    else
    {
        NSDictionary *errorDic = [self getErrorData:error andStatusCode:task];
        if (errorDic) {
            [CommonFunctions alertTitle:@"TripMood" withMessage:[errorDic objectForKey:@"message"] withDelegate:self];
        }
        NSLog(@"%@",errorDic);
    }
}
-(NSDictionary *)getErrorData :(NSError *) error andStatusCode :(NSURLSessionDataTask *) task {
    
    NSDictionary *serializedData;
    
    NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (errorData) {
        serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
    }
    return serializedData;
}

@end
