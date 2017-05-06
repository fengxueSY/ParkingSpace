//
//  RMUniversalAlert.m
//  RMUniversalAlert
//
//  Created by Ryan Maxwell on 19/11/14.
//  Copyright (c) 2014 Ryan Maxwell. All rights reserved.
//

#import <UIAlertController+Blocks/UIAlertController+Blocks.h>
#import <BlocksKit/UIAlertView+BlocksKit.h>
#import <BlocksKit/UIActionSheet+BlocksKit.h>

#import "RMUniversalAlert.h"

#define NSArrayObjectMaybeNil(__ARRAY__, __INDEX__) ((__INDEX__ >= [__ARRAY__ count]) ? nil : [__ARRAY__ objectAtIndex:__INDEX__])
// This is a hack to turn an array into a variable argument list. There is no good way to expand arrays into variable argument lists in Objective-C. This works by nil-terminating the list as soon as we overstep the bounds of the array. The obvious glitch is that we only support a finite number of buttons.
#define NSArrayToVariableArgumentsList(__ARRAYNAME__) NSArrayObjectMaybeNil(__ARRAYNAME__, 0), NSArrayObjectMaybeNil(__ARRAYNAME__, 1), NSArrayObjectMaybeNil(__ARRAYNAME__, 2), NSArrayObjectMaybeNil(__ARRAYNAME__, 3), NSArrayObjectMaybeNil(__ARRAYNAME__, 4), NSArrayObjectMaybeNil(__ARRAYNAME__, 5), NSArrayObjectMaybeNil(__ARRAYNAME__, 6), NSArrayObjectMaybeNil(__ARRAYNAME__, 7), NSArrayObjectMaybeNil(__ARRAYNAME__, 8), NSArrayObjectMaybeNil(__ARRAYNAME__, 9), nil

static NSInteger const RMUniversalAlertNoButtonExistsIndex = -1;

static NSInteger const RMUniversalAlertCancelButtonIndex = 0;
static NSInteger const RMUniversalAlertDestructiveButtonIndex = 1;
static NSInteger const RMUniversalAlertFirstOtherButtonIndex = 2;

@interface RMUniversalAlert ()

@property (nonatomic, weak) UIAlertController *alertController;
@property (nonatomic, weak) UIAlertView *alertView;
@property (nonatomic, weak) UIActionSheet *actionSheet;

@property (nonatomic, assign) BOOL hasCancelButton;
@property (nonatomic, assign) BOOL hasDestructiveButton;
@property (nonatomic, assign) BOOL hasOtherButtons;

@end

@implementation RMUniversalAlert

+ (instancetype)showAlertInViewController:(UIViewController *)viewController
                                withTitle:(NSString *)title
                                  message:(NSString *)message
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
                                 tapBlock:(RMUniversalAlertCompletionBlock)tapBlock
{
    RMUniversalAlert *alert = [[RMUniversalAlert alloc] init];
    
    alert.hasCancelButton = cancelButtonTitle != nil;
    alert.hasDestructiveButton = destructiveButtonTitle != nil;
    alert.hasOtherButtons = otherButtonTitles.count > 0;
    
    if ([UIAlertController class]) {
        alert.alertController = [UIAlertController showAlertInViewController:viewController
                                                                   withTitle:title message:message
                                                           cancelButtonTitle:cancelButtonTitle
                                                      destructiveButtonTitle:destructiveButtonTitle
                                                           otherButtonTitles:otherButtonTitles
                                                                    tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                                                        if (tapBlock) {
                                                                            tapBlock(alert, buttonIndex);
                                                                        }
                                                                    }];
    } else {
        NSMutableArray *other = [NSMutableArray array];
        
        if (destructiveButtonTitle) {
            [other addObject:destructiveButtonTitle];
        }
        
        if (otherButtonTitles) {
            [other addObjectsFromArray:otherButtonTitles];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:NSArrayToVariableArgumentsList(other)];
        
        alert.alertView = alertView;
        
        [alert.alertView bk_setDidDismissBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (tapBlock) {
                if (buttonIndex == alertView.cancelButtonIndex) {
                    tapBlock(alert, RMUniversalAlertCancelButtonIndex);
                } else if (destructiveButtonTitle) {
                    if (buttonIndex == alertView.firstOtherButtonIndex) {
                        tapBlock(alert, RMUniversalAlertDestructiveButtonIndex);
                    } else if (otherButtonTitles.count) {
                        NSInteger otherOffset = buttonIndex - alertView.firstOtherButtonIndex;
                        tapBlock(alert, RMUniversalAlertFirstOtherButtonIndex + otherOffset - 1);
                    }
                } else if (otherButtonTitles.count) {
                    NSInteger otherOffset = buttonIndex - alertView.firstOtherButtonIndex;
                    tapBlock(alert, RMUniversalAlertFirstOtherButtonIndex + otherOffset);
                }
            }
        }];
        
        [alert.alertView show];
    }
    
    return alert;
}

+ (instancetype)showActionSheetInViewController:(UIViewController *)viewController
                                      withTitle:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                         destructiveButtonTitle:(NSString *)destructiveButtonTitle
                              otherButtonTitles:(NSArray *)otherButtonTitles
             popoverPresentationControllerBlock:(void(^)(RMPopoverPresentationController *popover))popoverPresentationControllerBlock
                                       tapBlock:(RMUniversalAlertCompletionBlock)tapBlock
{
    RMUniversalAlert *alert = [[RMUniversalAlert alloc] init];
    
    alert.hasCancelButton = cancelButtonTitle != nil;
    alert.hasDestructiveButton = destructiveButtonTitle != nil;
    alert.hasOtherButtons = otherButtonTitles.count > 0;
    
    if ([UIAlertController class]) {
        
        alert.alertController = [UIAlertController showActionSheetInViewController:viewController
                                                                         withTitle:title
                                                                           message:message
                                                                 cancelButtonTitle:cancelButtonTitle
                                                            destructiveButtonTitle:destructiveButtonTitle
                                                                 otherButtonTitles:otherButtonTitles
                                                popoverPresentationControllerBlock:^(UIPopoverPresentationController *popover){
                                                    if (popoverPresentationControllerBlock) {
                                                        RMPopoverPresentationController *configuredPopover = [RMPopoverPresentationController new];
                                                        
                                                        popoverPresentationControllerBlock(configuredPopover);
                                                        
                                                        popover.sourceView = configuredPopover.sourceView;
                                                        popover.sourceRect = configuredPopover.sourceRect;
                                                        popover.barButtonItem = configuredPopover.barButtonItem;
                                                    }
                                                }
                                                                          tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                                                              if (tapBlock) {
                                                                                  tapBlock(alert, buttonIndex);
                                                                              }
                                                                          }];
    } else {
        
        void(^actionSheetTapBlock)(UIActionSheet *actionSheet, NSInteger buttonIndex) = ^(UIActionSheet *actionSheet, NSInteger buttonIndex){
            if (tapBlock) {
                if (buttonIndex == actionSheet.cancelButtonIndex) {
                    tapBlock(alert, RMUniversalAlertCancelButtonIndex);
                } else if (buttonIndex == actionSheet.destructiveButtonIndex) {
                    tapBlock(alert, RMUniversalAlertDestructiveButtonIndex);
                } else if (otherButtonTitles.count) {
                    NSInteger otherOffset = buttonIndex - actionSheet.firstOtherButtonIndex;
                    tapBlock(alert, RMUniversalAlertFirstOtherButtonIndex + otherOffset);
                }
            }
        };
        
        UIActionSheet *actionSheet = [self actionSheetWithTitle:title
                                              cancelButtonTitle:cancelButtonTitle
                                         destructiveButtonTitle:destructiveButtonTitle
                                              otherButtonTitles:otherButtonTitles
                                                       tapBlock:actionSheetTapBlock];
        alert.actionSheet = actionSheet;

        if (popoverPresentationControllerBlock) {
            
            RMPopoverPresentationController *configuredPopover = [RMPopoverPresentationController new];
            
            popoverPresentationControllerBlock(configuredPopover);
            
            if (configuredPopover.barButtonItem) {
                [alert.actionSheet showFromBarButtonItem:configuredPopover.barButtonItem animated:YES];
            } else if (configuredPopover.sourceView) {
                [alert.actionSheet showFromRect:configuredPopover.sourceRect inView:configuredPopover.sourceView animated:YES];
            } else {
                [alert.actionSheet showInView:viewController.view];
            }
        } else {
            [alert.actionSheet showInView:viewController.view];
        }
    }
    
    return alert;
}

+ (UIActionSheet *)actionSheetWithTitle:(NSString *)title
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
                            tapBlock:(void (^)(UIActionSheet *actionSheet, NSInteger buttonIndex))tapBlock
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:nil
                                                    cancelButtonTitle:cancelButtonTitle
                                               destructiveButtonTitle:destructiveButtonTitle
                                                    otherButtonTitles:NSArrayToVariableArgumentsList(otherButtonTitles)];

    [actionSheet bk_setDidDismissBlock:tapBlock];
    
    return actionSheet;
}

#pragma mark -

- (BOOL)visible
{
    if (self.alertController) {
        return self.alertController.visible;
    } else if (self.alertView) {
        return self.alertView.visible;
    } else if (self.actionSheet) {
        return self.actionSheet.visible;
    }
    NSAssert(false, @"Unsupported alert.");
    return NO;
}

- (NSInteger)cancelButtonIndex
{
    if (!self.hasCancelButton) {
        return RMUniversalAlertNoButtonExistsIndex;
    }
    
    return RMUniversalAlertCancelButtonIndex;
}

- (NSInteger)firstOtherButtonIndex
{
    if (!self.hasOtherButtons) {
        return RMUniversalAlertNoButtonExistsIndex;
    }
    
    return RMUniversalAlertFirstOtherButtonIndex;
}

- (NSInteger)destructiveButtonIndex
{
    if (!self.hasDestructiveButton) {
        return RMUniversalAlertNoButtonExistsIndex;
    }
    
    return RMUniversalAlertDestructiveButtonIndex;
}

@end
