//
//  CommonFunctions.h
//  AlcoholApp
//
//  Created by Konstant on 14/11/16.
//  Copyright © 2016 Konstant Infosolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  Used to create common methods used in application
 */
@interface CommonFunctions : NSObject

/**
 *  Used to get user default key-value pair
 *
 *  @param key : key
 *
 *  @return : value
 */
+ (id)getUserDefaultValueForKey:(NSString *)key;

/**
 *  Used to set user default key-value pair
 *
 *  @param key   : key
 *  @param value : value
 */
+ (void)setUserDefaultForKey:(NSString *)key
                       value:(id)value;


/**
 *  Selector used to get array of model properties
 *
 *  @param modelClass : model whose properties to be returned in array
 *
 *  @return : returns array of properties
 */
+ (NSArray *)getModelPropertiesToArray:(Class)modelClass;

/**
 *  Used to set left bar button item on navigation bar
 *
 *  @param image      image to set
 *  @param selector   selector method to be called on click
 *  @param target     target object
 *  @param controller Controller on which button is to be shown
 */
+ (void) setLeftBarButtonItemWithimage:(UIImage *)image andSelector:(SEL)selector withTarget: (id)target onController:(UIViewController *)controller;

/**
 *  Used to set right bar button item on navigation bar
 *
 *  @param title      title to set
 *  @param backImage      image to set
 *  @param selector   selector method to be called on click
 *  @param target     target object
 *  @param controller Controller on which button is to be shown
 */
+ (void)setRightBarButtonItemWithTitle:(NSString *)title andBackGroundImage:(UIImage *)backImage andSelector:(SEL)selector withTarget: (id)target onController:(UIViewController *)controller;

/**
 *  Used to set Title navigation bar
 *
 */
+(void) setNavigationTitle:(NSString *) title ForNavigationItem:(UINavigationItem *) navigationItem;
+(void) setNavigationBar:(UINavigationController*)navController;

/**
 *  Used to set Loading HUD
 *  @param messageLabel      loading title
 *  @param navController     NavigationController
 */
+(void) showHUDWithLabel:(NSString *)messageLabel ForNavigationController:(UINavigationController*) navController;
+ (void)showActivityIndicatorWithText:(NSString *)text;
+ (void)removeActivityIndicator;

/**
 *  Used to set Network Unavialabe Message
 *
 */
+ (void)showNetworkAlert;
+ (void)showSlowNetworkAlert;


/**
 *  Used to identify whether network available or not
 *
 *  @return YES if network available / NO if network not available
 */
+(BOOL)networkConnectionAvailability;

/**
 method to check network reachability status and show proper alert message if required
 */
+ (BOOL)getStatusForNetworkConnectionAndShowUnavailabilityMessage:(BOOL)showMessage;

/**
 Used to convert Unicode to emoji
 
 @param uniCode unicode string
 @return converted code
 */
+(NSString *)convertTripMoodUnicodeToEmoji:(NSString *)uniCode;

/**
 *  Used to remove special characters from string
 *
 *  @param string : String to be processed for special characters
 *
 *  @return : return well formated string which consist only numerics
 */
+(NSString *)removeSpecialCharectorsOtherThenNumericFromString:(NSString *)string;

/**
 *  Used to set user default key-value pair
 *
 *  @param key   : key
 *  @param value : value
 */

+(void)setUserDefault:(NSString *)key value:(id)value;

/**
 *  Used to get user default key-value pair
 *
 *  @param key : key
 *
 *  @return : value
 */
+(id)getUserDefaultValue:(NSString *)key;

/**
 *  Used to validate whether email is in email format or not
 *
 *  @param email : email string to be tested for valid email
 *
 *  @return : YES if email is following email constraints or NO if email is not following email constraints
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 Used to compare two images whether they are same or not
 
 @param image1 image1 reference
 @param image2 image2 reference
 @return true/false
 */
+(BOOL)compareImageWithFirstImage:(UIImage *)image1 isEqualTo:(UIImage *)image2;

/**
 *  Used to identify whether property type is Boolean
 *
 *  @param property   : Property to be validated
 *  @param modelClass : ModelClass in which above property to be checked
 *
 *  @return : YES if property type is Boolean else NO
 */
+(BOOL)isPropertyBOOLType:(NSString *)property modelClass:(Class)modelClass;


/**
 *  Used to set Show alert Message
 *
 */
+ (void)alertTitle:(NSString*)aTitle withMessage:(NSString*)aMsg withDelegate:(id)delegate;

/**
 *  Used to set Show alert Message with Tag
 *
 */
+ (void)alertTitle:(NSString*)aTitle withMessage:(NSString*)aMsg withTag:(int)aTag withDelegate:(id)delegate;

+ (NSString *)encodeInBase64String:(NSString *)_string;

+ (NSString *)decodeBase64String:(NSString *)_string;

+ (NSString *)langFromLocale:(NSString *)locale;

+ (void) viewCornerRadious :(UIView *) _aView  withRadious:(float) radious;

+(CGFloat) calculateRowHeight:(CGFloat) height;
+(CGFloat) calculateRowWidth:(CGFloat) width;
+(NSString*)date2str:(NSDate*)myNSDateInstance withFormat:(NSString *)strFormat;

+(int)getTimeStampWithDate :(NSDate *)_date;

+(NSString *) convertTimeStampToDate :(double) timeStamp;

@end
