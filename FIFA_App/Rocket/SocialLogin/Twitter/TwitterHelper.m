//
//  TwitterHelper.m
//  TweetyPad
//
//  Created by Mohit Mathur on 14/09/16.
//  Copyright © 2016 KT. All rights reserved.
//

#import "TwitterHelper.h"
#import "CommonFunctions.h"
#import "Config.h"

@implementation TwitterHelper

- (void)loginViaTwitterSDK:(NSArray *)arrayPermission
             finishedBlock:(operationFinishedBlockTwitter)operationFinishedBlock {
    
    [[Twitter sharedInstance] startWithConsumerKey:TWITTER_CONSUMER_KEY consumerSecret:TWITTER_SECRET_KEY];
    
    operationFinishedBlockTWT_ = operationFinishedBlock;
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"signed in as %@", [session userName]);
            [self getUserInfo:session];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
            operationFinishedBlockTWT_(@"",error);
        }
    }];
}

- (void)getUserInfo:(TWTRSession *)userSession {
    
    TWTRAPIClient *client = [TWTRAPIClient clientWithCurrentUser];
    NSURLRequest *request = [client URLRequestWithMethod:@"GET"
                                                     URL:@"https://api.twitter.com/1.1/account/verify_credentials.json"
                                              parameters:@{@"include_email": @"true", @"skip_status": @"true"}
                                                   error:nil];
    
    [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"%@",response);
        if (connectionError) {
            operationFinishedBlockTWT_(@"",connectionError);
        }
        else {
            NSError *jsonError;
            NSDictionary *responseJSON = [NSJSONSerialization
                                          JSONObjectWithData:data
                                          options:NSJSONReadingAllowFragments
                                          error:&jsonError];
            
            NSLog(@"%@",responseJSON);
            operationFinishedBlockTWT_([userSession authToken],responseJSON);
        }
        
    }];
}

- (void)logout {
    
}

@end
