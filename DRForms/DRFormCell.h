//
//  DRFormCell.h
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRFormCell : UITableViewCell

/**
 *  Cell's observed object.
 */
@property (nonatomic, readonly, weak) id observedObject;

/**
 *  Cell's observed keypath that points to a property of obseverdObject
 *  that will be associated with the cell.
 */
@property (nonatomic, readonly, strong) NSString *observedKeyPath;

/**
 *  Use this method to set property associated with the cell
 *
 *  @param object  observed object
 *  @param keyPath property keypath
 */
- (void)setObservedObject:(id)object andKeyPath:(NSString *)keyPath;

/**
 *  This method will be called when observed property value changes
 */
- (void)refreshValue;

/**
 *  This method will be called when user selects the cell
 */
- (void)selectCell;

@end
