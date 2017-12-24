//
//  AlertView.h
//  eCitizens
//
//  Created by Ghanshyam on 3/9/15.
//  Copyright (c) 2015 Suchita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  This class is used to show alert view through out the app
 */
@interface AlertView : NSObject<UIAlertViewDelegate>{
    NSMutableArray     *arrTabs;
}

/**
 *  Used to show alert view
 *
 *  @param title      : alertView title
 *  @param message    : alertView message
 *  @param arrActions : actions container array
 */
- (void)showAlertViewWithTitle:(NSString *)title
                  withMessage:(NSString *)message
                   arrActions:(NSArray *)arrActions;

/**
 *  Used to show custom Alert
 *
 *  @param alertTitle  title
 *  @param message     message
 *  @param cancelTitle cancel button title
 *  @param otherTitle  other title
 *  @param tag         tag
 *  @param delegate    alert delegate
 *  @param delay       delay time
 *  @param vc          controller
 */
+ (void)showAlertWithTitle:(NSString *)alertTitle
                   message:(NSString *)message
               cancelTitle:(NSString *)cancelTitle
                otherTitle:(NSString *)otherTitle
                       tag:(NSInteger)tag delegate:(id)delegate
                 withDelay:(float)delay
          onViewController:(UIViewController *)vc;

/**
*  Used to show alert view with action array having block as tap-handler
*
*  @param title        : AlertView Title
*  @param errorMessage : AlertView error message
*  @param arrActions   : Action container array
*/
+ (void)showAlertViewWithTitle:(NSString *)title
                  withMessage:(NSString *)errorMessage
                   arrActions:(NSArray *)arrActions;


@end
