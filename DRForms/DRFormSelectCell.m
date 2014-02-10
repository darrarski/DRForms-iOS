//
//  DRFormSelectCell.m
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormSelectCell.h"

@implementation DRFormSelectCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.titleLabel.text = nil;
    self.cellValue = nil;
    self.shouldSelectForValue = nil;
    self.updateSelectionAppearance = nil;
    self.updateSelectionAppearance(NO);
}

- (void)selectCell
{
    if (self.observedObject && self.observedKeyPath && self.cellValue) {
        [self.observedObject setValue:self.cellValue
                               forKey:self.observedKeyPath];
    }
}

- (void)refreshValue
{
    if (!self.observedObject || !self.observedKeyPath) {
        self.updateSelectionAppearance(NO);
        return;
    }
    
    id currentValue = [self.observedObject valueForKeyPath:self.observedKeyPath];
    
    self.updateSelectionAppearance(self.shouldSelectForValue(currentValue));
}

- (BOOL (^)(id))shouldSelectForValue
{
    if (!_shouldSelectForValue) {
        __weak DRFormSelectCell *selfWeak = self;
        _shouldSelectForValue = ^BOOL (id currentValue) {
            return [currentValue isEqual:selfWeak.cellValue];
        };
    }
    return _shouldSelectForValue;
}

- (void (^)(BOOL))updateSelectionAppearance
{
    if (!_updateSelectionAppearance) {
        __weak DRFormSelectCell *selfWeak = self;
        _updateSelectionAppearance = ^(BOOL selected) {
            selfWeak.accessoryType = selected?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
        };
    }
    return _updateSelectionAppearance;
}

@end
