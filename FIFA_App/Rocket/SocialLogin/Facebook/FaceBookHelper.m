//  FaceBookHelper
//
//  Created by Deepesh on 21/08/15.
//  Copyright (c) 2013 Konstant Info Private Limited. All rights reserved.
//

#import "FaceBookHelper.h"
#import "MBProgressHUD.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKLoginKit/FBSDKLoginManager.h>
/**
    
 FaceBookHelper:-
 
 FaceBookHelper class will allow various possibilities with facebook.
 
 */
NSString *const FBSessionStateChangedNotification = @"com.example.Login:FBSessionStateChangedNotification";

#define LAST_LOGIN_STATUS_KEY @"LAST_LOGIN_STATUS_KEY"

@implementation FaceBookHelper


#pragma mark---
#pragma mark---FaceBook Implementation

+ (NSArray *)getRequiredPermissions {
    return [[NSArray alloc] initWithObjects:@"read_stream",@"email",@"user_birthday",@"gender",nil];
    
  //  return [[NSArray alloc] initWithObjects:@"public_profile",@"email",@"user_birthday",@"user_location",@"user_hometown",@"user_photos",@"user_friends",@"user_education_history",@"user_relationships",@"user_posts",@"user_events",nil];
    
}

-(void)fbLogin
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];  
//    [login logOut];
    [login logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
        
        if (error)
        {
            //             DLog(@"Facebook Login Error %@", error);
            
            [_delegate FbLoginError:error];
            
        }
        else if (result.isCancelled)
        {
            //             DLog(@"Facebook Cancel Button Pressed ");
            
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:@"facebook login error" forKey:NSLocalizedDescriptionKey];
            
            NSError *error = [NSError errorWithDomain:@"FaceBook Login" code:401 userInfo:details];;
            
            [_delegate FbLoginError:error];
        }
        else
        {
            
            [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
            
            [self performSelector:@selector(FbdataReceived:) withObject:nil afterDelay:0.0];
        }
    }];
//    [login logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
//     {
//
//     }];
}


-(void)FbdataReceived:(id )responseData
{
//    DLog(@"Facebook Login response is %@",responseData);
    if ([FBSDKAccessToken currentAccessToken])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id,name,first_name,last_name,picture.height(300).width(640),email,birthday,gender"}]
         
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 if ([_delegate conformsToProtocol:@protocol(FBSharingDelegate)] && [_delegate respondsToSelector:@selector(FbdataReceived:)]) {
                     
                     [_delegate FbdataReceived:result];
                 }
                 
//                 DLog(@"fetched user:%@", result);
//                 [_delegate FbdataReceived:result];
             }
             else{
                 [_delegate FbgetUserProfileError:error];
             }
         }];
    }
    
}

@end
