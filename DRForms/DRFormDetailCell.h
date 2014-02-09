//
//  DRFormDetailCell.h
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormCell.h"

@interface DRFormDetailCell : DRFormCell

/**
 *  Title label
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  Detail label
 */
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

/**
 *  This block will be called everytime the observed property changes its value.
 *  Current value of observed property will be passed as a argument.
 *  String returned by the block will be displayed in cell's detail label.
 */
@property (nonatomic, copy, setter = setDetailLabelTextBlock:) NSString *(^detailLabelText)(id value);

/**
 *  This block will be called when user selects the cell.
 */
@property (copy, nonatomic, setter = setSelectCellActionBlock:) void (^selectCellAction)();

@end
