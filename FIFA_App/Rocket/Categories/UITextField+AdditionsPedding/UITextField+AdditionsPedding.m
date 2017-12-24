 //
//  UITextField+AdditionsPedding.m
//  SocialNightApp
//
//  Created by Chandan Kumar on 05/11/14.
//  Copyright (c) 2014 Deepesh. All rights reserved.
//

#import "UITextField+AdditionsPedding.h"

@implementation UITextField (AdditionsPedding)

-(void) setLeftPadding:(int) paddingValue
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingValue, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(void) setRightPadding:(int) paddingValue
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingValue, self.frame.size.height)];
    self.rightView = paddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
}
-(void)addRightImageView:(UITextField*)txtField
{
    UIImageView *imgSearch=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imgSearch setImage:[UIImage imageNamed:@"pencil"]];
    [imgSearch setContentMode:UIViewContentModeRight];
    txtField.rightView=imgSearch;
    txtField.rightViewMode=UITextFieldViewModeAlways;
}

-(void)setTextFieldPlaceHolderText:(NSString *)placeHolderText {
    UIColor *color = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolderText attributes:@{NSForegroundColorAttributeName: color}];
}


@end
