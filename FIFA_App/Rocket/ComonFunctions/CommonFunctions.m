//
//  CommonFunctions.m
//  AlcoholApp
//
//  Created by Konstant on 14/11/16.
//  Copyright © 2016 Konstant Infosolutions. All rights reserved.
//

#import "CommonFunctions.h"

#import <objc/runtime.h>
#import "Reachability.h"

@implementation CommonFunctions

/**
 *  Selector used to get array of model properties
 *
 *  @param modelClass : model whose properties to be returned in array
 *
 *  @return : returns array of properties
 */
+ (NSArray *)getModelPropertiesToArray:(Class)modelClass {
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(modelClass, &count);
    NSMutableArray *arrModelProperties = [[NSMutableArray alloc] init];
    
    for (int counter = 0 ;counter<count; counter++){
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[counter])];
        [arrModelProperties addObject:key];
    }
    return arrModelProperties;
}

#pragma mark - NSUserDefault methods
+ (void)setUserDefaultForKey:(NSString *)key value:(NSString *)value {
    if (key != nil && value != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:key];
        [userDefaults setObject:value forKey:key];
        [userDefaults synchronize];
    }
}

+ (id)getUserDefaultValueForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:key]) {
        return [userDefaults objectForKey:key];
    }
    return nil;
}

#pragma mark - Navigation bar methods

+ (void)setLeftBarButtonItemWithimage:(UIImage *)image andSelector:(SEL)selector withTarget: (id)target onController:(UIViewController *)controller {
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    //leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    controller.navigationItem.leftBarButtonItem = leftBtnItem;
}

+ (void)setRightBarButtonItemWithTitle:(NSString *)title andBackGroundImage:(UIImage *)backImage andSelector:(SEL)selector withTarget: (id)target onController:(UIViewController *)controller {
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if (backImage != nil) {
        [rightBtn setImage:backImage forState:UIControlStateNormal];
        [rightBtn.titleLabel setFont:[UIFont fontWithName:@"Optima-Regular" size:10.f]];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else {
        rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -7);
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [rightBtn.titleLabel setFont:[UIFont fontWithName:@"Optima-Regular" size:13.f]];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    controller.navigationItem.rightBarButtonItem = rightBtnItem;
}

+(void)setNavigationBar:(UINavigationController*)navController
{
    //    [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navController.navigationBar setShadowImage:[UIImage new]];
    [navController.navigationBar setTranslucent:NO];
    [navController setNavigationBarHidden:NO];
    [navController.navigationBar setTintColor:[UIColor whiteColor]];
}

+(void)setNavigationTitle:(NSString *) title ForNavigationItem:(UINavigationItem *) navigationItem
{
    float width = SCREEN_WIDTH;
    
    if (navigationItem.leftBarButtonItem.customView && navigationItem.rightBarButtonItem.customView)
    {
        width = SCREEN_WIDTH - (navigationItem.leftBarButtonItem.customView.frame.size.width+navigationItem.rightBarButtonItem.customView.frame.size.width);
    }
    else if (navigationItem.leftBarButtonItem.customView && !navigationItem.rightBarButtonItem.customView)
    {
        width = SCREEN_WIDTH - (navigationItem.leftBarButtonItem.customView.frame.size.width*2);
    }
    else if (!navigationItem.leftBarButtonItem.customView && !navigationItem.rightBarButtonItem.customView)
    {
        width = SCREEN_WIDTH - (2*navigationItem.rightBarButtonItem.customView.frame.size.width);
    }
    
    
    // find the text width; so that btn width can be calculate
    CGSize constrainedSize = CGSizeMake(SCREEN_WIDTH  , 9999);
    
    static UIFont *fontUsed = nil;
    
    if (fontUsed == nil) fontUsed = [UIFont fontWithName:FONT_BOLD size:16.0f];
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          fontUsed, NSFontAttributeName,
                                          nil];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:title attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    if (requiredHeight.size.width < width-40)
        width = requiredHeight.size.width;
    else
        width = requiredHeight.size.width-40;
    
    UIView *view;
    
    if(navigationItem.titleView == nil)
    {
        view = [[UIView alloc]  initWithFrame:CGRectMake(0.0f, 0.0f, width, 44.0f)];
    }
    else
    {
        view = navigationItem.titleView;
    }
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 6.0f, width,32.0f)];
    [titleLbl setTag:10];
    
    [titleLbl setFont:[UIFont fontWithName:FONT_BOLD size:16.0]];
    
    
    [titleLbl setBackgroundColor:[UIColor clearColor]];
    [titleLbl setTextAlignment:NSTextAlignmentCenter];
    
    [titleLbl setTextColor:[UIColor blackColor]];
    
    [titleLbl setText:title];
    [view addSubview:titleLbl];
    [navigationItem setTitleView:view];
}

#pragma mark - HUD methods
+(void)showHUDWithLabel:(NSString *)messageLabel ForNavigationController:(UINavigationController*) navController
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:APPDELEGATE.window animated:YES];
    HUD.color = [UIColor colorWithRed:98/255.0f green:141/255.0f blue:225/255.0f alpha:1.0f];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.removeFromSuperViewOnHide = YES;
    
    UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage animatedImageWithImages:[NSArray arrayWithObjects:   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   [UIImage imageNamed:@"logo11"],
                                                                                                   nil] duration:1.0]];
    [customView startAnimating];
    HUD.customView = customView;
    
    if(messageLabel != nil) {
        HUD.labelText= messageLabel;
    }
    
    [HUD bringSubviewToFront:navController.view];
}
+ (void)removeActivityIndicator {
    [MBProgressHUD hideAllHUDsForView:APPDELEGATE.window animated:YES];
    [MBProgressHUD hideHUDForView:APPDELEGATE.window animated:YES];
}

+ (void)showActivityIndicatorWithText:(NSString *)text {
    [self removeActivityIndicator];
    
    MBProgressHUD *hud   = [MBProgressHUD showHUDAddedTo:APPDELEGATE.window animated:YES];
    hud.detailsLabelText = text;
}

#pragma mark-
#pragma mark - ReachabiltyCheck methods
/**
 *  Used to identify whether network available or not
 *
 *  @return YES if network available / NO if network not available
 */
+(BOOL)networkConnectionAvailability{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    if ([self networkStatus:reachability]==NO) {
        [CommonFunctions alertTitle:@"TripMood" withMessage:NSLocalizedString(@"NO_NETWORK", @"") withDelegate:nil];
    }
    
    return [self networkStatus:reachability];
}
+(BOOL)networkStatus:(Reachability *)reachability{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable: {
            return NO;
        }
        case ReachableViaWWAN: {
            return YES;
        }
        case ReachableViaWiFi: {
            return YES;
        }
    }
}
+ (BOOL)isValueNotEmpty:(NSString*)aString{
    if (aString == nil || [aString length] == 0){
        
        return NO;
    }
    return YES;
}

/*!
 @function	getStatusForNetworkConnectionAndShowUnavailabilityMessage
 @abstract	get internet reachability status and optionally can show network unavailability message.
 @param	showMessage
 to decide whether to show network unreachability message.
 */

+(BOOL)getStatusForNetworkConnectionAndShowUnavailabilityMessage:(BOOL)showMessage
{
    if ([[Reachability reachabilityWithHostName:[API_URL host]] currentReachabilityStatus]== NotReachable) {
        if (showMessage == NO)
            return NO;
        
        return NO;
    }
    return YES;
}

+(void)showNetworkAlert
{
    [self removeActivityIndicator];
    
    NSString *strMsg = @"No network available please check your network setting";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""  message:strMsg    delegate:nil    cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
+(void)showSlowNetworkAlert
{
    NSString *strMsg = @"Please check your network connection and try again";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""  message:strMsg    delegate:nil    cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

/**
 *  Used to convert TripMood Unicode to emoji
 *
 *  @param str_receiveMessage : UniCode String
 *
 *  @return : Converted String
 */
+(NSString *)convertTripMoodUnicodeToEmoji:(NSString *)uniCode{
    if ([uniCode isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (!uniCode) {
        return @"";
    }
    
    NSData *data1 = [uniCode dataUsingEncoding:NSUTF8StringEncoding];
    NSString *return_emojiStr = [[NSString alloc] initWithData:data1 encoding:NSNonLossyASCIIStringEncoding];
    
    return return_emojiStr;
    
}
/**
 *  Used to remove special characters from string
 *
 *  @param string : String to be processed for special characters
 *
 *  @return : return well formated string which consist only numerics
 */
+(NSString *)removeSpecialCharectorsOtherThenNumericFromString:(NSString *)string
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    if ([string rangeOfCharacterFromSet:set].location != NSNotFound)
    {
        // newString consists only of the digits 0 through 9
        
        NSString *strippedNumber = [string stringByReplacingOccurrencesOfString:@"[^0-9\\+]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])];
        
        return strippedNumber;
        
    } else {
        
        NSString *strippedNumber = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
        strippedNumber = [strippedNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
        strippedNumber = [strippedNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
        strippedNumber = [strippedNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        return strippedNumber;
    }
}
#pragma mark - User Default Methods

/**
 *  Used to set user default key-value pair
 *
 *  @param key   : key
 *  @param value : value
 */
+(void)setUserDefault:(NSString *)key value:(id)value{
    if (key != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //[userDefaults removeObjectForKey:key];
        [userDefaults setObject:value forKey:key];
        [userDefaults synchronize];
    }
}

/**
 *  Used to get user default key-value pair
 *
 *  @param key : key
 *
 *  @return : value
 */
+(id)getUserDefaultValue:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:key]) {
        return [userDefaults objectForKey:key];
    }
    return nil;
}

/**
 *  Used to validate whether email is in email format or not
 *
 *  @param email : email string to be tested for valid email
 *
 *  @return : YES if email is following email constraints or NO if email is not following email constraints
 */
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 Used to compare two images whether they are same or not
 
 @param image1 image1 reference
 @param image2 image2 reference
 @return true/false
 */
+(BOOL)compareImageWithFirstImage:(UIImage *)image1 isEqualTo:(UIImage *)image2 {
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    
    return [data1 isEqualToData:data2];
}

/**
 *  Used to identify whether property type is Boolean
 *
 *  @param property   : Property to be validated
 *  @param modelClass : ModelClass in which above property to be checked
 *
 *  @return : YES if property type is Boolean else NO
 */
+(BOOL)isPropertyBOOLType:(NSString *)property modelClass:(Class)modelClass{
    NSArray *arrProperties = [self getModelPropertiesToArray:modelClass];
    
    if ([arrProperties containsObject:property]) {
        
        objc_property_t coreProperty = class_getProperty(modelClass, [property UTF8String]);
        
        const char *corePropertyAttr = property_getAttributes(coreProperty);
        
        NSString *corePropStringValue = [NSString stringWithUTF8String:corePropertyAttr];
        
        if ([corePropStringValue rangeOfString:@"Tc"].location != NSNotFound) {
            return YES;
        }
    }
    
    return NO;
}

/**
 *  Used to set Show alert Message
 *
 */
+ (void)alertTitle:(NSString*)aTitle withMessage:(NSString*)aMsg withDelegate:(id)delegate {
    [[[UIAlertView alloc] initWithTitle:aTitle message:aMsg delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}
/**
 *  Used to set Show alert Message with Tag
 *
 */
+ (void)alertTitle:(NSString*)aTitle withMessage:(NSString*)aMsg withTag:(int)aTag withDelegate:(id)delegate {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:aTitle message:aMsg delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alert.tag = aTag;
    [alert show];
}
/**
 *  Used to show alert message for contacts permission
 *
 */
+(void)showContactsPermissionAlertWithDelegate:(id)delegate {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Device Contacts Permission Disabled!"
                                                        message:@"Please allow contacts permission for better results! We promise to keep your data private."
                                                       delegate:delegate
                                              cancelButtonTitle:@"Settings"
                                              otherButtonTitles:@"Cancel", nil];
    alertView.tag = 100;
    [alertView show];
}

+(NSString *)encodeInBase64String:(NSString *)_string {
    NSData *nsdata = [_string
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    return base64Encoded;
}

+(NSString *)decodeBase64String:(NSString *)_string {
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:_string options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    
    return base64Decoded;
}

+(NSString*)date2str:(NSDate*)myNSDateInstance onlyDate:(BOOL)onlyDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
    if (onlyDate) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }else {
        [formatter setDateFormat: @"dd-MM-yyyy HH:mm:ss"];
    }
    
    return [formatter stringFromDate:myNSDateInstance];
}

+(NSString *)langFromLocale:(NSString *)locale {
    NSRange r = [locale rangeOfString:@"_"];
    if (r.length == 0) r.location = locale.length;
    NSRange r2 = [locale rangeOfString:@"-"];
    if (r2.length == 0) r2.location = locale.length;
    return [[locale substringToIndex:MIN(r.location, r2.location)] lowercaseString];
}
+(NSString*)date2str:(NSDate*)myNSDateInstance withFormat:(NSString *)strFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:strFormat];
    
    //Optionally for time zone conversions
    //   [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *stringFromDate = [formatter stringFromDate:myNSDateInstance];
    return stringFromDate;
}

/**
 method for generate time stamp from date
 
 @param NSDate date of challenge
 @return timestamp value
 */
+(int)getTimeStampWithDate :(NSDate *)_date {
    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    //    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
//    [dateFormat setDateFormat:@"dd MMM yyyy | hh:mm aa"];
//    NSDate *date = [dateFormat dateFromString:_dateStr];
    return [_date timeIntervalSince1970];;
}

+(NSString *) convertTimeStampToDate :(double) timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    [formatter setDateFormat:@"dd MMM"];
    
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}

+ (void) viewCornerRadious :(UIView *) _aView  withRadious:(float) radious {
    _aView.layer.cornerRadius = radious;
    _aView.layer.masksToBounds = YES;
    _aView.clipsToBounds = YES;
}

#pragma mark -
#pragma mark - Method for calculation Dynamic height/width

+(CGFloat) calculateRowHeight:(CGFloat) height{
    CGFloat fHeight;
    
    fHeight = (height/667)*SCREEN_HEIGHT;
    return fHeight;
}

+(CGFloat) calculateRowWidth:(CGFloat) width{
    CGFloat fWidth;
    
    fWidth = (width/375)*SCREEN_WIDTH;
    return fWidth;
}


@end
