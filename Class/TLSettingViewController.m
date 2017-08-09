//
//  TLSettingViewController.m
//  600 Words for Toeic
//
//  Created by NguyenThanhLuan on 25/05/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLSettingViewController.h"

@interface TLSettingViewController ()

@end

@implementation TLSettingViewController{
    NSArray     *timeArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.settingview.layer.cornerRadius = 8;
    self.settingview.layer.shadowOpacity = 0.8;
    self.settingview.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    [self.pkTime setDelegate:self];
    [self.pkTime setDataSource:self];
    
    timeArr = TL_TIME_ARRAY;
    
    NSInteger timePeriodNotice = [[[NSUserDefaults standardUserDefaults] valueForKey:TL_TIMEPERIOD_NOTICE] integerValue];
    BOOL isEnableNotice = [[[NSUserDefaults standardUserDefaults] valueForKey:TL_ENABLE_NOTICE] boolValue];

    
    [self.pkTime selectRow:timePeriodNotice inComponent:0 animated:YES];
    [self.swEnable setOn:isEnableNotice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirm_Action:(id)sender {
 
    if (_delegate && [_delegate respondsToSelector:@selector(confirmSetting)]) {
        
        NSInteger selectedTime = [_pkTime selectedRowInComponent:0];
        BOOL  isNotice = [_swEnable isOn];
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:selectedTime] forKey:TL_TIMEPERIOD_NOTICE];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:isNotice] forKey:TL_ENABLE_NOTICE];
        
        if (!isNotice) {
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
        }
        
        [_delegate confirmSetting];
    }
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}

#pragma mark - UIPickerView Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [timeArr count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [timeArr objectAtIndex:row];
}

@end
