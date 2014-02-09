//
//  DRFormViewController.h
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRFormViewController;
@class DRFormCell;

@protocol DRFormViewControllerDelegate <NSObject>

/**
 *  This method should return number of rows for given section of the form
 *
 *  @param formViewController from view controller
 *  @param section            section number
 *
 *  @return number of rows for given section of the form
 */
- (NSInteger)formViewController:(DRFormViewController *)formViewController numberOfRowsInSection:(NSInteger)section;

/**
 *  This method should return a cell for given index path of the form
 *
 *  @param formViewController form view controller
 *  @param indexPath          index path of the cell
 *
 *  @return cell for given index path of the form
 */
- (DRFormCell *)formViewController:(DRFormViewController *)formViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  This method should return number of form's sections
 *
 *  @param formViewController form view controller
 *
 *  @return number of sections in form
 */
- (NSInteger)formViewControllerNumberOfSections:(DRFormViewController *)formViewController;

/**
 *  This method should return header text for given section of the form
 *
 *  @param formViewController form view controller
 *  @param section            section number
 *
 *  @return header text
 */
- (NSString *)formViewController:(DRFormViewController *)formViewController headerForSection:(NSInteger)section;

/**
 *  This method should return footer text for given section of the form
 *
 *  @param formViewController form view controller
 *  @param section            section number
 *
 *  @return footer text
 */
- (NSString *)formViewController:(DRFormViewController *)formViewController footerForSection:(NSInteger)section;

/**
 *  This method will be called when user selects cell with given idex path
 *
 *  @param formViewController form view controller
 *  @param indexPath          index path of the cell
 */
- (void)formViewController:(DRFormViewController *)formViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DRFormViewController : UITableViewController

/**
 *  Form view controller delegate
 */
@property (weak, nonatomic) id<DRFormViewControllerDelegate> formViewControllerDelegate;

/**
 *  Realod form table
 */
- (void)reloadForm;

/**
 *  Returns form's cell
 *
 *  @param indexPath index path of a cell
 *
 *  @return form's cell
 */
- (DRFormCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Deselects currently selected cell
 *
 *  @param animated if YES will animate deselection
 */
- (void)deselectRowAnimated:(BOOL)animated;

/**
 *  Dequeues reusable form cell with given identifier and returns it
 *
 *  @param identifier cell's identifier
 *  @param indexPath  cell's index path
 *
 *  @return dequeued reusable cell
 */
- (DRFormCell *)reusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

@end
