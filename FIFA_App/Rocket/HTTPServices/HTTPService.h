//
//  HTTPService.h
//
//  Created by Ashish Sharma on 30/05/15.
//  Copyright (c) 2015 Konstant Info. All rights reserved.
//

#import <Foundation/Foundation.h> 

#import "AFNetworking.h"

// base Stagging URL for all HTTP communication
//#define BASE_URL @""

// base Development URL for all HTTP communication
#define BASE_URL @"http://192.168.0.131:7464/"

// base PRODUCTION URL for all HTTP communication
//#define BASE_URL @""


//Header parameters

#define HEADER_CONTENT_TYPE @"application/json"
#define HEADER_VERSION @"1.0"
#define HEADER_OS_TYPE @"ios"
#define HEADER_LANGUAGE @"en"

typedef NS_ENUM(NSInteger, kHttpMethodType) {
    kHttpMethodTypeGet      = 0,    // GET
    kHttpMethodTypePost     = 1,    // POST
    kHttpMethodTypeDelete   = 2,    // DELETE
    kHttpMethodTypePut      = 3     // PUT
};

typedef NS_ENUM(NSInteger, kHttpStatusCode) {
    kHttpStatusCodeOK   = 0,    //200 SUCCESS
    kHttpStatusCodeNoResponse   = 1,    //204 NO RESPONSE
    kHttpStatusCodeBadRequest   = 2,    //400 BAD REQUEST
    kHttpStatusCodeUnAuthorized   = 3,    //401 UNAUTHORIZED
    kHttpStatusCodeNoSession   = 4    //404 NO SESSION
};

@interface HTTPService : NSObject
{
    /**
     *  HTTP session manager (AFNetworking Client)
     */
    AFHTTPSessionManager *httpSessionManager;
    
    /**
     *  Base URL for all http communication
     */
    NSString *httpBaseURL;
}

#pragma mark - Designated Initializer

/**
 *  Designated initializer, initialize ServiceManager with base URL and URL session configuration
 *
 *  @param baseURL base URL
 *  @param config  URL session configuration
 *
 *  @return self
 */
- (id)initWithBaseURL:(NSURL*) baseURL andSessionConfig:(NSURLSessionConfiguration*) config;

#pragma mark - Instance Methods

/**
 *  Call this to create a request with any HTTP method
 *  NOTE: It posts params in raw JSON format
 *
 *  @param httpMethodType HTTP method type post,get etc
 *  @param headers        HTTP header key-value pair (no need to Content-Type,Accept)
 *  @param serviceName    name of service which need to call
 *  @param params         parameters in key-value pair
 *  @param success        success callback handler
 *  @param failure        failure callback handler
 */
- (void) startRequestWithHttpMethod:(kHttpMethodType) httpMethodType
                    withHttpHeaders:(NSMutableDictionary*) headers
                    withServiceName:(NSString*) serviceName
                     withParameters:(NSMutableDictionary*) params
                        withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        withFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  Call this to create a request with multipart/form-data
 *  NOTE: It posts params in raw form-data format
 *
 *  @param headers     HTTP header key-value pair (no need to Content-Type)
 *  @param serviceName name of service which need to call
 *  @param params      parameters in key-value pair
 *  @param files       array of NSData objects for file content
 *  @param success     success callback handler
 *  @param failure     failure callback handler
 */
- (void) uploadFileRequestWithHttpHeaders:(NSMutableDictionary*) headers
                          withServiceName:(NSString*) serviceName
                           withParameters:(NSMutableDictionary*) params
                             withFileData:(NSArray*) files
                              withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              withFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  Call this to create a request with multipart/form-data
 *  NOTE: It posts params in raw form-data format
 *
 *  @param headers     HTTP header key-value pair (no need to Content-Type)
 *  @param serviceName name of service which need to call
 *  @param params      parameters in key-value pair
 *  @param files       array of NSData objects for file content
 *  @param success     success callback handler
 *  @param failure     failure callback handler
 */
- (void) uploadMultipleFileRequestWithHttpHeaders:(NSMutableDictionary*) headers
                          withServiceName:(NSString*) serviceName
                           withParameters:(NSMutableDictionary*) params
                             withFileData:(NSArray*) files
                              withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              withFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
