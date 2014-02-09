//
//  DRFormsFirstViewController.m
//  DRFormsDemo
//
//  Created by Dariusz Rybicki on 09.02.2014.
//  Copyright (c) 2014 Darrarski. All rights reserved.
//

#import "DRFormsFirstViewController.h"
#import "DRNavigationController.h"
#import "DRFormDataModel.h"
#import "DRFormViewController.h"
#import "DRFormSelectCell.h"
#import "DRFormDetailCell.h"
#import "DRFormsFruitsViewController.h"
#import "DRFormTextCell.h"

@interface DRFormsFirstViewController () <DRFormViewControllerDelegate>

@property (strong, nonatomic) DRFormViewController *formViewController;

@end

@implementation DRFormsFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add form view controller
    [self addChildViewController:self.formViewController];
    self.formViewController.view.frame = self.formContainerView.frame;
    self.formViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.formContainerView addSubview:self.formViewController.view];
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
    return 5;
}

- (NSInteger)formViewController:(DRFormViewController *)formViewController numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            
        case 1:
            return 3;
            
        case 2:
            return 2;
            
        case 3:
            return 1;
            
        case 4:
            return 1;
            
        default:
            return 0;
    }
}

- (NSString *)formViewController:(DRFormViewController *)formViewController headerForSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Property 1";
            
        case 1:
            return @"Property 2";
            
        case 2:
            return @"Property 2 (again)";
            
        case 3:
            return @"Property 3";
            
        case 4:
            return @"Property 4";
            
        default:
            return nil;
    }
}

- (NSString *)formViewController:(DRFormViewController *)formViewController footerForSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Cells above are connected to fromData.property1";
            
        case 1:
            return @"Cells above are connected to fromData.property2 and have customized selection appearance.";
            
        case 2:
            return @"Cells above are also connected to fromData.property2, but there are only two options defined.";
            
        case 3:
            return @"Cell above shows how to display additional view controller for picking a value.";
            
        case 4:
            return @"Cell above is connected to formData.property4";
            
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
                cell.titleLabel.text = @"Option 1";
                cell.cellValue = @1;
                break;
                
            case 1:
                cell.titleLabel.text = @"Option 2";
                cell.cellValue = @2;
                break;
                
            case 2:
                cell.titleLabel.text = @"Option 3";
                cell.cellValue = @3;
                break;
                
            default:
                break;
        }
        
        __weak DRFormSelectCell *cellWeak = cell;
        
        [cell setShouldSelectForValueBlock:^BOOL(id value) {
            return ([cellWeak.cellValue isKindOfClass:[NSNumber class]] &&
                    [value isKindOfClass:[NSNumber class]] &&
                    [cellWeak.cellValue compare:value] == NSOrderedSame);
        }];
        
        [cell setObservedObject:((DRNavigationController *)self.navigationController).formData
                     andKeyPath:NSStringFromSelector(@selector(property1))];
        
        return cell;
    }
    else if (indexPath.section == 1) {
        
        DRFormSelectCell *cell = (DRFormSelectCell *)[formViewController reusableCellWithIdentifier:@"SelectCell" forIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"Option A";
                cell.cellValue = @"A";
                break;
                
            case 1:
                cell.titleLabel.text = @"Option B";
                cell.cellValue = @"B";
                break;
                
            case 2:
                cell.titleLabel.text = @"Option C";
                cell.cellValue = @"C";
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
        
        [cell setUpdateSelectionAppearanceBlock:^(BOOL selected) {
            cellWeak.backgroundColor = selected?[UIColor colorWithWhite:0.9 alpha:1.000]:[UIColor whiteColor];
        }];
        
        [cell setObservedObject:((DRNavigationController *)self.navigationController).formData
                     andKeyPath:NSStringFromSelector(@selector(property2))];
        
        return cell;
    }
    else if (indexPath.section == 2) {
        
        DRFormSelectCell *cell = (DRFormSelectCell *)[formViewController reusableCellWithIdentifier:@"SelectCell" forIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"Option A";
                cell.cellValue = @"A";
                break;
                
            case 1:
                cell.titleLabel.text = @"Option B";
                cell.cellValue = @"B";
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
        
        [cell setObservedObject:((DRNavigationController *)self.navigationController).formData
                     andKeyPath:NSStringFromSelector(@selector(property2))];
        
        return cell;
    }
    else if (indexPath.section == 3) {
        
        DRFormDetailCell *cell = (DRFormDetailCell *)[formViewController reusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
        
        cell.titleLabel.text = @"Property 3";
        
        [cell setDetailLabelTextBlock:^NSString *(id value) {
            return [value isKindOfClass:[NSString class]] ? value : nil;
        }];
        
        [cell setSelectCellActionBlock:^{
            DRFormsFruitsViewController *fruitsViewController = [[DRFormsFruitsViewController alloc] init];
            fruitsViewController.observedObject = ((DRNavigationController *)self.navigationController).formData;
            fruitsViewController.observedKeyPath = NSStringFromSelector(@selector(property3));
            [self.navigationController pushViewController:fruitsViewController animated:YES];
        }];
        
        [cell setObservedObject:((DRNavigationController *)self.navigationController).formData
                     andKeyPath:NSStringFromSelector(@selector(property3))];
        
        return cell;
    }
    else if (indexPath.section == 4) {
        
        DRFormTextCell *cell = (DRFormTextCell *)[formViewController reusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
        
        cell.titleLabel.text = @"Property 4";
        
        [cell setObservedObject:((DRNavigationController *)self.navigationController).formData
                     andKeyPath:NSStringFromSelector(@selector(property4))];
        
        return cell;
    }
    
    return nil;
}

@end
