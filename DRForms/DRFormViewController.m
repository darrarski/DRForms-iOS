//
//  DRFormViewController.m
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormViewController.h"
#import "DRFormCell.h"

@implementation DRFormViewController

#pragma mark - Public form methods

- (void)reloadForm
{
    [self.tableView reloadData];
}

- (DRFormCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[DRFormCell class]]) {
        return (DRFormCell *)cell;
    }
    
    return nil;
}

- (void)deselectRowAnimated:(BOOL)animated
{
    NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
    if (selectedRowIndexPath) {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow]
                                      animated:animated];
    }
}

- (DRFormCell *)reusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (DRFormCell *)reusableCellForIndexPath:(NSIndexPath *)indexPath
{
    NSAssert([self.formViewControllerDelegate respondsToSelector:@selector(formViewController:cellIdenfirierForRowAtIndexPath:)],
             @"Missing implementation of method formViewController:cellIdenfirierForRowAtIndexPath: in form view controller delegate");
    
    NSString *cellIdentifier = [self.formViewControllerDelegate formViewController:self cellIdenfirierForRowAtIndexPath:indexPath];
    
    NSAssert(cellIdentifier && ![cellIdentifier isEqualToString:@""],
             @"Method formViewController:cellIdenfirierForRowAtIndexPath: not implemented for index path {%d, %d}", indexPath.section, indexPath.row);
    
    return [self reusableCellWithIdentifier:cellIdentifier
                               forIndexPath:indexPath];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.formViewControllerDelegate respondsToSelector:@selector(formViewControllerNumberOfSections:)]) {
        return [self.formViewControllerDelegate formViewControllerNumberOfSections:self];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.formViewControllerDelegate formViewController:self numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.formViewControllerDelegate respondsToSelector:@selector(formViewController:headerForSection:)]) {
        return [self.formViewControllerDelegate formViewController:self headerForSection:section];
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if ([self.formViewControllerDelegate respondsToSelector:@selector(formViewController:footerForSection:)]) {
        return [self.formViewControllerDelegate formViewController:self footerForSection:section];
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.formViewControllerDelegate formViewController:self cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self.formViewControllerDelegate respondsToSelector:@selector(formViewController:cellIdenfirierForRowAtIndexPath:)]) {
        return [self.tableView rowHeight];
    }
    
    NSString *cellIdentifier = [self.formViewControllerDelegate formViewController:self cellIdenfirierForRowAtIndexPath:indexPath];
    
    if (!cellIdentifier || [cellIdentifier isEqualToString:@""]) {
        return [self.tableView rowHeight];
    }
    
    static NSMutableDictionary *heightCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        heightCache = [[NSMutableDictionary alloc] init];
    });
    
    NSNumber *cachedHeight = heightCache[cellIdentifier];
    if (cachedHeight) {
        return cachedHeight.floatValue;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    CGFloat height = cell.bounds.size.height;
    heightCache[cellIdentifier] = @(height);
    return height;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAnimated:YES];
    
    [self.view endEditing:YES];
    
    DRFormCell *cell = [self cellForRowAtIndexPath:indexPath];
    [cell selectCell];
    
    if ([self.formViewControllerDelegate respondsToSelector:@selector(formViewController:didSelectRowAtIndexPath:)]) {
        [self.formViewControllerDelegate formViewController:self didSelectRowAtIndexPath:indexPath];
    }
}

@end
