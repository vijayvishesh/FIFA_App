//
//  AlertView.m
//  eCitizens
//
//  Created by Ghanshyam on 3/9/15.
//  Copyright (c) 2015 Suchita. All rights reserved.
//

#import "AlertView.h"
#import "AppDelegate.h"

@implementation AlertView

#pragma mark-- AlertView Methods

- (void)showAlertViewWithTitle:(NSString *)title
                   withMessage:(NSString *)message
                    arrActions:(NSArray *)arrActions {
    
    //Holding reference of all Tabs
    if (!arrTabs) {
        arrTabs = [[NSMutableArray alloc] init];
    }
    [arrTabs removeAllObjects];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    for (int counter = 0; counter<arrActions.count; counter++) {
            NSString *buttonTitle = [[arrActions objectAtIndex:counter] objectForKey:@"title"];
            void(^tabAction)() = [[arrActions objectAtIndex:counter] objectForKey:@"action"];
            UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:tabAction];
            [alert addAction:action];
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
}

+ (void) showAlertWithTitle:(NSString*)alertTitle
                    message:(NSString*)message
                cancelTitle:(NSString*)cancelTitle
                 otherTitle:(NSString*)otherTitle
                        tag:(NSInteger)tag
                   delegate:(id)delegate
                  withDelay:(float)delay
           onViewController:(UIViewController *)vc {
    
    float delayInSeconds = delay;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        // code to be executed on the main queue after delay
        UIAlertController *alert;
        
        NSString *alTitle = alertTitle;
        
        if(alTitle == nil || alTitle.length<=0)
            alTitle= @"";
        
        alert = [UIAlertController alertControllerWithTitle:alTitle message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        [alert addAction:ok];
        [vc presentViewController:alert animated:YES completion:nil];
    });
}


/**
 *  Used to show alert view with action array having block as tap-handler
 *
 *  @param title        : AlertView Title
 *  @param errorMessage : AlertView error message
 *  @param arrActions   : Action container array
 */
+ (void)showAlertViewWithTitle:(NSString *)title
                   withMessage:(NSString *)errorMessage
                    arrActions:(NSArray *)arrActions {
    AlertView *alert = [[AlertView alloc]init];
    [alert showAlertViewWithTitle:title withMessage:errorMessage arrActions:arrActions];
}


@end
