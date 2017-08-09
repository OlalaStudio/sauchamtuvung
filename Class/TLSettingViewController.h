//
//  TLSettingViewController.h
//  600 Words for Toeic
//
//  Created by NguyenThanhLuan on 25/05/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLCommonDefines.h"

@protocol TLSettingViewControllerDelegate <NSObject>

-(void)confirmSetting;

@end

@interface TLSettingViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>

@property id<TLSettingViewControllerDelegate>        delegate;
@property (weak, nonatomic) IBOutlet UIView         *settingview;
@property (weak, nonatomic) IBOutlet UILabel        *lbEnable;
@property (weak, nonatomic) IBOutlet UISwitch       *swEnable;
@property (weak, nonatomic) IBOutlet UILabel        *lbselectTime;
@property (weak, nonatomic) IBOutlet UIPickerView   *pkTime;
@property (weak, nonatomic) IBOutlet UIButton       *btConfirm;

- (IBAction)confirm_Action:(id)sender;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end
