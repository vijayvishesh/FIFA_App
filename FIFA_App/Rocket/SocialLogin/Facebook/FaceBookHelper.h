//  FaceBookHelper
//
//  Created by Deepesh on 21/08/15.
//  Copyright (c) 2013 Konstant Info Private Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FBSharingDelegate <NSObject>
@optional
-(void)FbdataReceived:(id )responseData;
-(void)FbLoginError:(NSError*)error;
-(void)FbgetUserProfileError:(NSError*)error;
-(void)requestSent;


typedef void (^operationFinishedBlockFBH)(id responseData);

@end

@interface FaceBookHelper : NSObject
{
    operationFinishedBlockFBH operationFinishedBlockFBH_;
    BOOL                processing;
}

@property (nonatomic,weak)    id<FBSharingDelegate>    delegate;

@property (nonatomic,weak)  NSString           *lastRequest;
@property (nonatomic,weak)  NSString           *lastRequestImage;
@property (nonatomic,weak)  NSOutputStream     *outputStream;


+ (NSArray *)getRequiredPermissions;
-(void)fbLogin;




@end
