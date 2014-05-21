//
//  DRFormTextCell.m
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormTextCell.h"

@interface DRFormTextCell () <UITextFieldDelegate>

@end

@implementation DRFormTextCell

- (void)awakeFromNib
{
    self.textField.delegate = self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.titleLabel.text = nil;
    self.textField.text = nil;
	self.textField.placeholder = nil;
    self.cursorPosition = nil;
    self.returnKeyAction = nil;
}

- (void)refreshValue
{
    if (!self.observedObject || !self.observedKeyPath) {
        self.textField.text = nil;
        return;
    }
    
    id currentValue = [self.observedObject valueForKeyPath:self.observedKeyPath];
    
    if ([currentValue isKindOfClass:[NSString class]]) {
        self.textField.text = currentValue;
        if (self.cursorPosition) {
            // restore cursor position
            UITextPosition *textPosition = [self.textField positionFromPosition:self.textField.beginningOfDocument
                                                                         offset:[self.cursorPosition unsignedIntegerValue]];
            self.textField.selectedTextRange = [self.textField textRangeFromPosition:textPosition
                                                                          toPosition:textPosition];
            self.cursorPosition = nil;
        }
    }
    else {
        self.textField.text = nil;
    }
}

- (void)selectCell
{
    [self.textField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.returnKeyAction) {
        self.returnKeyAction();
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.observedObject && self.observedKeyPath) {
		
		BOOL abortChange = NO;
		NSString *text = nil;
		
		// save cursor position
		self.cursorPosition = @(range.location + string.length);
		
		if (self.changeCharactersInRangeBlock) {
			text = self.changeCharactersInRangeBlock(&abortChange, textField.text, range, string);
		}
		else {
			text = [textField.text stringByReplacingCharactersInRange:range withString:string];
			
			#pragma clang diagnostic push
			#pragma clang diagnostic ignored "-Wdeprecated-declarations"
			if (self.textModificationBlock) {
				text = self.textModificationBlock(text);
			}
			#pragma clang diagnostic pop
		}
		
		if (!abortChange) {
			[self.observedObject setValue:text
								   forKey:self.observedKeyPath];
		}
    }
    
    return NO;
}

@end
