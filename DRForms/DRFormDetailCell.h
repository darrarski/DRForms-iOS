//
//  DRFormDetailCell.h
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormCell.h"

@interface DRFormDetailCell : DRFormCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic, copy, setter = setDetailLabelTextBlock:) NSString *(^detailLabelText)(id value);

@property (copy, nonatomic, setter = setSelectCellActionBlock:) void (^selectCellAction)();

@end
