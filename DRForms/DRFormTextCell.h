//
//  DRFormTextCell.h
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormCell.h"

/**
 *  A cell with UITextField, dynamically connected with given property, defined
 *  by setting observedObject and observedKetPath.
 */
@interface DRFormTextCell : DRFormCell

/**
 *  Title label
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  Text field
 */
@property (weak, nonatomic) IBOutlet UITextField *textField;

/**
 *  You can set this block in order to customize action connected
 *  with keyboard Return key (optional)
 */
@property (copy, nonatomic, setter = setReturnKeyActionBlock:) void (^returnKeyAction)();

@end
