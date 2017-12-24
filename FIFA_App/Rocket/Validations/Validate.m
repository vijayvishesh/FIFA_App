//
//  Validate.m
//
//  Created by Deepesh on 11/19/13.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Validate.h"


@implementation Validate

/**
 * Function name isNull                         
 *                                              
 * @paramsstr NSString *str
 *                                              
 * @object: function to check a string to null  
 *
 * return BOOL
 */

+ (BOOL)isNull:(NSString*)str{
	if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || str==nil) {
		return YES;
	}
	return NO;
}
/**
 * Function name isValidEmailId                
 *                                              
 * @paramsemail NSString                            
 *                                              
 * @object: function to check a valid email id  
 *
 * return BOOL
 */
+ (BOOL)isValidEmailId:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
	return [emailTest evaluateWithObject:email];
}
/**
 * Function name isValidMobileNumber           
 *                                              
 * @paramsnumber NSString                            
 *                                              
 * @object: function to check a valid Mobile # 
 *
 * return BOOL
 */
+ (BOOL)isValidMobileNumber:(NSString*)number
{
    number=[number stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if ([number length]<5 || [number length]>17) {
		return FALSE;
	}
	NSString *Regex = @"^([0-9]*)$"; 
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex]; 
	
    return [mobileTest evaluateWithObject:number];
}
/**
 * Function name isValidUserName                
 *                                             
 * @paramsuserName NSString                            
 *                                              
 * @object: function to check a valid user name 
 *
 * return BOOL
 */
+ (BOOL) isValidUserName:(NSString*)userName{
    NSString *regex=@"^[a-zA-Z0-9@,.-]{1,200}$";
    NSPredicate *userNameTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [userNameTest evaluateWithObject:userName];
}


/**
 * Function name isValidPassword                
 *                                              
 * @paramspassword NSString                            
 *                                              
 * @object: function to check a valid password 
 *
 * return BOOL
 */
+ (BOOL) isValidPassword:(NSString*)password{
//    NSString *regex=@"^[a-zA-Z0-9_-[!#$%&@=]]{5,15}$";
//    NSPredicate *passwordTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    
    if(password.length>=6)
    {
        return YES;
    }else
    {
      return NO;
    }
    
//    return [passwordTest evaluateWithObject:password];
}


+ (BOOL) isValidAge:(NSString*)age {
    NSString *regex=@"^[0-9_-]{1,3}$";
    NSPredicate *ageTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [ageTest evaluateWithObject:age];
}

+ (BOOL)isValidURL:(NSString*)urlStr {
    BOOL isValidURL = NO;
    
    NSURL *candidateURL = [NSURL URLWithString:urlStr];
    
    if (candidateURL && candidateURL.scheme && candidateURL.host)
        isValidURL = YES;
    
    return isValidURL;
}

+ (NSString *)trimTextField:(NSString*)value
{
    return [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
}

@end
