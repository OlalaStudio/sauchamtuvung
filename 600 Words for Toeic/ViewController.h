//
//  ViewController.h
//  600 Words for Toeic
//
//  Created by NguyenThanhLuan on 15/05/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLSettingViewController.h"

@import GoogleMobileAds;

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,TLSettingViewControllerDelegate,GADBannerViewDelegate>{
    
    NSMutableArray *categorys;
    GADBannerView           *_adBannerView;
}

@property (weak, nonatomic) IBOutlet UITableView *categoryTable;

- (IBAction)settingAction:(id)sender;

@end

