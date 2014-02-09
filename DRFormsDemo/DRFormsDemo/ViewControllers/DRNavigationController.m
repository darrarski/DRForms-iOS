//
//  DRNavigationController.m
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRNavigationController.h"
#import "DRFormDataModel.h"

@implementation DRNavigationController

- (DRFormDataModel *)formData
{
    if (!_formData) {
        _formData = [[DRFormDataModel alloc] init];
    }
    return _formData;
}

@end
