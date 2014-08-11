//
//  UIView+DRFormsHelper.m
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 12/08/14.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "UIView+DRFormsHelper.h"

@implementation UIView (DRFormsHelper)

- (BOOL)DRForms_containsFirstResponder
{
    if (self.isFirstResponder) {
        return YES;
    }
    __block BOOL firstResponderFound = NO;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        firstResponderFound = [subview DRForms_containsFirstResponder];
        if (firstResponderFound) {
            *stop = YES;
        }
    }];
    
    return firstResponderFound;
}

@end
