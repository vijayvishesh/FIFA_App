//
//  Fast Packout
//
//  Created by Alok on 07/10/13.
//  Copyright (c) 2013 Konstant Info Private Limited. All rights reserved.
//

#ifndef ViewController_Macros_h
#define ViewController_Macros_h

#define APPDELEGATE  ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define USERDEFAULT  [NSUserDefaults standardUserDefaults]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define DEVICE_RETINA  ([UIScreen mainScreen].scale)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define RETURN_IF_THIS_VIEW_IS_NOT_A_TOPVIEW_CONTROLLER if (self.navigationController) if (!(self.navigationController.topViewController == self)) return;

#define SHOW_STATUS_BAR               [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
#define HIDE_STATUS_BAR               [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

#define SET_STATUS_BAR_COLOR_WHITE   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

#define SHOW_NAVIGATION_BAR           [self.navigationController setNavigationBarHidden:FALSE];
#define HIDE_NAVIGATION_BAR           [self.navigationController setNavigationBarHidden:TRUE];

#define VC_OBJ(x) [[x alloc] init]
#define VC_OBJ_WITH_NIB(x) [[x alloc] initWithNibName : (NSString *)CFSTR(#x) bundle : nil]

#define RESIGN_KEYBOARD [UIView animateWithDuration:0.3 animations:^{[[[UIApplication sharedApplication] keyWindow] endEditing:YES];}];

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define FONT_REGULAR                  @"Optima-Regular"
#define FONT_MEDIUM                   @""
#define FONT_LIGHT                    @"Optima"
#define FONT_BOLD                     @"Optima-Bold"

#define HIDE_NETWORK_ACTIVITY_INDICATOR                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
#define SHOW_NETWORK_ACTIVITY_INDICATOR                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

#define SCREEN_FRAME_RECT                               [[UIScreen mainScreen] bounds]

#define NAVIGATION_BAR_HEIGHT 44

#define currentLanguageBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSLocale preferredLanguages] objectAtIndex:0] ofType:@"lproj"]]

//Social info for passing to api
#define TWITTER_CONSUMER_KEY @"FG58nl4GJRDt99DHCK5v0K36Q"
#define TWITTER_SECRET_KEY @"EK147l2nBZOks43T8QAKi8J4PUEeZAlU8SDg4bpJovHyAGwoAt"
#define name1 @"name"
#define email1 @"email"
#define Id @"social_id"
#define Picture @"picture"
#define Cover @"cover_photo"
#define AccountType @"account_type"
#define Accesstoken @"access_token"
#define Intermediate @"intermediate"

#endif
