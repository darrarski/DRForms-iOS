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

@end

@implementation DRFormCell

- (void)dealloc
{
    if (self.observedObject && self.observedKeyPath) {
        [self.observedObject removeObserver:self
                                 forKeyPath:self.observedKeyPath];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self prepareForReuse];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    if (self.observedObject && self.observedKeyPath) {
        [self.observedObject removeObserver:self
                                 forKeyPath:self.observedKeyPath];
        self.observedObject = nil;
        self.observedKeyPath = nil;
    }
}

#pragma mark - Public cell methods

- (void)setObservedObject:(id)object andKeyPath:(NSString *)keyPath
{
    if (self.observedObject && self.observedKeyPath) {
        [self.observedObject removeObserver:self
                                 forKeyPath:self.observedKeyPath];
    }
    
    self.observedObject = object;
    self.observedKeyPath = keyPath;
    
    [self.observedObject addObserver:self
                          forKeyPath:self.observedKeyPath
                             options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                             context:nil];
}

- (void)refreshValue
{
    
}

- (void)selectCell
{
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if([object isEqual:self.observedObject] && [keyPath isEqualToString:self.observedKeyPath]) {
		[self refreshValue];
	}
}

@end
