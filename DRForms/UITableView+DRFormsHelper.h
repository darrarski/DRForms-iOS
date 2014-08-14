//
//  UITableView+DRFormsHelper.h
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 15/08/14.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DRFormsHelper)

/**
 *  Returns currently visible form cells
 *
 *  @return array of DRFormCell objects
 */
- (NSArray *)DRForm_visibleFormCells;

/**
 * Setup observing for all visible form cells
 *
 * Should be called when view that contains form's table appears on screen
 */
- (void)DRForms_setupObserversForVisibleCells;

/**
 * Cleanup observing for all visible form cells
 *
 * Should be called when view that contains form's table disappears from screen
 */
- (void)DRForms_cleanupObserversForVisibleCells;

/**
 *  Deselect currentluy selected cell
 *
 *  @param animated use animation
 */
- (void)DRForms_deselectRowAnimated:(BOOL)animated;

@end
