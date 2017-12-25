//
//  Config.h
//  FIFA_App
//
//  Created by Rajneesh Saini on 24/12/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import <Reachability/Reachability.h>
#import <CoreLocation/CoreLocation.h>
#import <Twitter/Twitter.h>

#import "UI+Macros.h"
#import "AllCategories.h"
#import "HTTPService.h"
#import "AlertView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

#define DATABASE_NAME @""

//Local
//#define API_URL ([NSURL URLWithString:@""])

//Testing
#define API_URL ([NSURL URLWithString:@""])

//Google api key for places api and maps
#define GOOGLE_API_KEY @"AIzaSyCE3qWJOtYAQM5x9erHRnRN1srNkBmi3xg"

#define DEVICE_TOKEN    @"device_token"
#define USER_SID        @"sid"
#define USER_ID         @"user_id"
#define USER_EMAIL      @"email"
#define USER_NAME       @"username"

@interface Config : NSObject

extern CLLocationManager                *locationManager;
extern CLLocationCoordinate2D           currentLocationCords;
extern  NSString                        *currentLocation;

@end
