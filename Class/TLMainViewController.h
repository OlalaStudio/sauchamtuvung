//
//  TLMainViewController.h
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Appirater.h"
#import "TLPageViewController.h"
#import "TLDetailTableViewCell.h"
#import "TLExpandableTableViewCell.h"
#import "TLSettingViewController.h"

@import GoogleMobileAds;

@interface TLMainViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,AppiraterDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource,TLPageViewControllerDelegate, TLDetailTableViewCellProtocol,GADBannerViewDelegate,GADInterstitialDelegate>
{
    NSMutableArray      *dataArr;
    GADBannerView       *_adBannerView;
    GADInterstitial     *_interstitial;
    
    BOOL        _adsloaded;
    BOOL       _startLearning;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIPageViewController   *pageController;
@property (strong,nonatomic) UIPageControl          *pageControll;

@property(nonatomic, retain) AVAudioPlayer *player;

-(void)setData:(NSArray*)data;

@end
