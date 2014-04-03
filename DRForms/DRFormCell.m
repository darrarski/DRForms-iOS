//
//  DRFormCell.m
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormCell.h"

@interface DRFormCell ()

@property (nonatomic, weak) id observedObject;
@property (nonatomic, strong) NSString *observedKeyPath;
@property (nonatomic, assign, getter = isObserving) BOOL observing;

@end

@implementation DRFormCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self prepareForReuse];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
	
	[self cleanupObservers];
	
	self.observedObject = nil;
	self.observedKeyPath = nil;
}

#pragma mark - Public cell methods

- (void)setObservedObject:(id)object andKeyPath:(NSString *)keyPath
{
	BOOL wasObserfing = self.isObserving;
	
	[self cleanupObservers];
	
    self.observedObject = object;
    self.observedKeyPath = keyPath;
	
	if (wasObserfing) {
		[self setupObservers];
	}
}

- (void)refreshValue
{
    
}

- (void)selectCell
{
    
}

#pragma mark - KVO

- (void)setupObservers
{
	if (self.isObserving) {
		return;
	}
	
	if (!self.observedObject || !self.observedKeyPath) {
		return;
	}
	
	self.observing = YES;
	
	[self.observedObject addObserver:self
                          forKeyPath:self.observedKeyPath
                             options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial)
                             context:nil];
}

- (void)cleanupObservers
{
	if (!self.isObserving) {
		return;
	}
	
	if (!self.observedObject || !self.observedKeyPath) {
		return;
	}
	
	self.observing = NO;
	
	[self.observedObject removeObserver:self
							 forKeyPath:self.observedKeyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if(self.isObserving && [object isEqual:self.observedObject] && [keyPath isEqualToString:self.observedKeyPath]) {
		[self refreshValue];
	}
}

@end
