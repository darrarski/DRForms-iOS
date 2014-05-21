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

/**
 *  You can set this block in order to do some text modification 
 *  or validation in the real time.
 *  Deprecated. Use changeCharactersInRangeBlock instead.
 */
@property (copy, nonatomic, setter = setTextModificationBlock:) NSString *(^textModificationBlock)(NSString *text) DEPRECATED_ATTRIBUTE;

/**
 *  You can set this block in order to do some custom text modification.
 *
 *  There are several parameters:
 *
 *  BOOL *abortChange - a pointer to boolean variable, set this variable to YES if you want to abort text changes
 *
 *  NSString *string - string before changes
 *
 *  NSrange range - the range of characters to be replaced
 *
 *  NSString *replacementString - replacement string
 *
 *  The block should return string after character change.
 */
@property (copy, nonatomic) NSString *(^changeCharactersInRangeBlock)(BOOL *abortChange, NSString *string, NSRange range, NSString *replacementString);

/**
 *  This property holds cusrsor position when editing text. It is set before changeCharactersInRangeBlock is 
 *  invoked and applied to text field just after updating its content. If you do some custom text modifications 
 *  in changeCharactersInRangeBlock, you should update this property inside the block as well.
 *  For example, after changing the replacementString, you should set: 
 *
 *  cursorPosition = @(range.location + replacementString.length)
 *
 *  which should do the work in most cases.
 */
@property (nonatomic, strong) NSNumber *cursorPosition;

@end
