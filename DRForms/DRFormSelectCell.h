//
//  DRFormSelectCell.h
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormCell.h"

/**
 *  A cell that can be selected by tapping on it. When user selects the cell,
 *  given value will be set to associated property. The select cell shows also
 *  visual representation of selection when its value equals to associated
 *  property value.
 */
@interface DRFormSelectCell : DRFormCell

/**
 *  Title label
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  Cell value. Set an object representaion of value that will be
 *  associated with the cell.
 */
@property (strong, nonatomic) id cellValue;

/**
 *  This block will be called in order to determine if cell should be
 *  selected for given value. Current value of observed property will be
 *  passed as a argument. Set this block to implement custom value comparison.
 */
@property (copy, nonatomic, setter = setShouldSelectForValueBlock:) BOOL (^shouldSelectForValue)(id value);

/**
 *  This optional block will be called everytime the cell selection
 *  state changes. Boolean property passed as a argument to this block tells
 *  if cell should be selected. You can set the block in order to customize
 *  cell's selection style.
 */
@property (copy, nonatomic, setter = setUpdateSelectionAppearanceBlock:) void (^updateSelectionAppearance)(BOOL selected);

@end
