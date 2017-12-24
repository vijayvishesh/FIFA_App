//
//  Validate.h
//
//  Created by Deepesh on 11/19/13.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validate : NSObject


+ (BOOL)isNull:(NSString*)str;
+ (BOOL)isValidEmailId:(NSString*)email;
+ (BOOL)isValidMobileNumber:(NSString*)number;
+ (BOOL) isValidUserName:(NSString*)userName;
+ (BOOL) isValidPassword:(NSString*)password;
+ (BOOL) isValidAge:(NSString*)age;
+ (BOOL)isValidURL:(NSString*)urlStr;

+ (NSString *)trimTextField:(NSString*)value;

@end
