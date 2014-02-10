//
//  DRFormDetailCell.m
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormDetailCell.h"

@implementation DRFormDetailCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.titleLabel.text = nil;
    self.detailLabel.text = nil;
    self.detailLabelText = nil;
    self.selectCellAction = nil;
}

- (void)refreshValue
{
    if (!self.observedObject || !self.observedKeyPath) {
        self.detailLabel.text = nil;
        return;
    }
    
    id currentValue = [self.observedObject valueForKeyPath:self.observedKeyPath];
    
    if (self.detailLabelText) {
        self.detailLabel.text = self.detailLabelText(currentValue);
    }
    else {
        self.detailLabel.text = nil;
    }
}

- (void)selectCell
{
    if (self.selectCellAction) {
        self.selectCellAction();
    }
}

@end
