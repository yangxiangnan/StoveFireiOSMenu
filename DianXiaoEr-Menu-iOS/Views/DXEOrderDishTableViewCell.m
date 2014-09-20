//
//  DXEDishInCartTableViewCell.m
//  DianXiaoEr-Menu-iOS
//
//  Created by Joe Shang on 9/17/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import "DXEOrderDishTableViewCell.h"

@implementation DXEOrderDishTableViewCell

- (void)awakeFromNib
{
    UIColor *nameColor = [[RNThemeManager sharedManager] colorForKey:@"Order.DishCell.NameFontColor"];
    self.dishName.textColor = nameColor;
    self.dishEnglishName.textColor = nameColor;
    self.dishPrice.textColor = nameColor;
    self.dishTotalPrice.textColor = [[RNThemeManager sharedManager] colorForKey:@"Order.DishCell.PriceFontColor"];
    self.dishCount.textColor = [[RNThemeManager sharedManager] colorForKey:@"Order.DishCell.CountFontColor"];
    
    self.backgroundImageView.image = [[RNThemeManager sharedManager] imageForName:@"order_cell_background.png"];
    
    self.contentView.backgroundColor = [UIColor blackColor];
}

- (void)updateCellByDishCount:(NSInteger)count dishPrice:(float)price;
{
    self.dishCount.text = [NSString stringWithFormat:@"%d", (int)count];
    self.dishTotalPrice.text = [NSString stringWithFormat:@"￥%.2f", count * price];
    
    if (count == kDXEDishItemCountInCartMin)
    {
        self.decreaseButton.enabled = NO;
    }
    else if (count == kDXEDishItemCountInCartMax)
    {
        self.increaseButton.enabled = NO;
    }
    else
    {
        self.decreaseButton.enabled = YES;
        self.increaseButton.enabled = YES;
    }
}

- (IBAction)onIncreaseButtonClicked:(id)sender
{
    SEL selector = NSSelectorFromString(@"onIncreaseButtonClickedInTableCell:");
    [self notificateControllerWithSelector:selector];
}

- (IBAction)onDecreaseButtonClicked:(id)sender
{
    SEL selector = NSSelectorFromString(@"onDecreaseButtonClickedInTableCell:");
    [self notificateControllerWithSelector:selector];
}

- (IBAction)onDeleteButtonClicked:(id)sender
{
    SEL selector = NSSelectorFromString(@"onDeleteButtonClickedInTableCell:");
    [self notificateControllerWithSelector:selector];
}

- (void)notificateControllerWithSelector:(SEL)selector
{
    if ([self.controller respondsToSelector:selector])
    {
        // func is a trick for performSelector:withObject without "may cause a leak because its selector is unknown" warning
        // [self.controller performSelector:selector
        //                       withObject:self
        IMP imp = [self.controller methodForSelector:selector];
        void (*func)(id, SEL, DXEOrderDishTableViewCell *) = (void *)imp;
        func(self.controller, selector, self);
    }
}

@end
