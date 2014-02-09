//
//  DRFormsFruitsViewController.m
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormsFruitsViewController.h"
#import "DRFormViewController.h"
#import "DRFormSelectCell.h"

@interface DRFormsFruitsViewController () <DRFormViewControllerDelegate>

@property (strong, nonatomic) DRFormViewController *formViewController;

@end

@implementation DRFormsFruitsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add form view controller
    [self addChildViewController:self.formViewController];
    self.formViewController.view.frame = self.view.frame;
    self.formViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.formViewController.view];
    [self.formViewController didMoveToParentViewController:self];
}

- (DRFormViewController *)formViewController
{
    if (!_formViewController) {
        _formViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"FormViewController"];
        _formViewController.formViewControllerDelegate = self;
    }
    return _formViewController;
}

#pragma mark - DRFormViewControllerDelegate

- (NSInteger)formViewControllerNumberOfSections:(DRFormViewController *)formViewController
{
    return 1;
}

- (NSInteger)formViewController:(DRFormViewController *)formViewController numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            
        default:
            return 0;
    }
}

- (NSString *)formViewController:(DRFormViewController *)formViewController headerForSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Fruits";
            
        default:
            return nil;
    }
}

- (DRFormCell *)formViewController:(DRFormViewController *)formViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        DRFormSelectCell *cell = (DRFormSelectCell *)[formViewController reusableCellWithIdentifier:@"SelectCell" forIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"Apple";
                cell.cellValue = @"Apple";
                break;
                
            case 1:
                cell.titleLabel.text = @"Banana";
                cell.cellValue = @"Banana";
                break;
                
            case 2:
                cell.titleLabel.text = @"Pear";
                cell.cellValue = @"Pear";
                break;
                
            default:
                break;
        }
        
        __weak DRFormSelectCell *cellWeak = cell;
        
        [cell setShouldSelectForValueBlock:^BOOL(id value) {
            return ([cellWeak.cellValue isKindOfClass:[NSString class]] &&
                    [value isKindOfClass:[NSString class]] &&
                    [cellWeak.cellValue isEqualToString:value]);
        }];
        
        [cell setObservedObject:self.observedObject
                     andKeyPath:self.observedKeyPath];
        
        return cell;
    }
    
    return nil;
}

- (void)formViewController:(DRFormViewController *)formViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
