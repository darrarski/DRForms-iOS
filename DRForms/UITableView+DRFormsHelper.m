//
//  UITableView+DRFormsHelper.m
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 15/08/14.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "UITableView+DRFormsHelper.h"
#import "DRFormCell.h"

@implementation UITableView (DRFormsHelper)

- (NSArray *)DRForm_visibleFormCells
{
    NSArray *visibleFormCells = [self.visibleCells filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UITableViewCell *cell, NSDictionary *bindings) {
        return [cell isKindOfClass:[DRFormCell class]];
    }]];
    
    return visibleFormCells;
}

- (void)DRForms_setupObserversForVisibleCells
{
    [[self DRForm_visibleFormCells] enumerateObjectsUsingBlock:^(DRFormCell *cell, NSUInteger idx, BOOL *stop) {
        [cell setupObservers];
    }];
}

- (void)DRForms_cleanupObserversForVisibleCells
{
    [[self DRForm_visibleFormCells] enumerateObjectsUsingBlock:^(DRFormCell *cell, NSUInteger idx, BOOL *stop) {
        [cell cleanupObservers];
    }];
}

- (void)DRForms_deselectRowAnimated:(BOOL)animated
{
    NSIndexPath *selectedRowIndexPath = [self indexPathForSelectedRow];
    if (selectedRowIndexPath) {
        [self deselectRowAtIndexPath:selectedRowIndexPath
                            animated:animated];
    }
}

@end
