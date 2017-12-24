//
//  TwitterHelper.h
//  TweetyPad
//
//  Created by Mohit Mathur on 14/09/16.
//  Copyright © 2016 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>

// Block type that takes any object
typedef void (^operationFinishedBlockTwitter)( NSString *accessToken,id responseData);

@interface TwitterHelper : NSObject
{
    operationFinishedBlockTwitter operationFinishedBlockTWT_;
}
/**
 *  This Method allow user to login with Twitter default permisions which can be got without any review includes public_profile,email,friends using the app
 *  @param arrayPermission will hold the permission logged in user want to get info
 *  @param operationFinishedBlock custom block to handle from calling class
 */
- (void)loginViaTwitterSDK:(NSArray *)arrayPermission
      finishedBlock:(operationFinishedBlockTwitter)operationFinishedBlock;

/**
 *  Allow to logout from Twitter
 */
- (void)logout;

@end
