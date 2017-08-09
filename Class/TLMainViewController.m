//
//  TLMainViewController.m
//  600EST
//
//  Created by NguyenThanhLuan on 16/02/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLMainViewController.h"

@interface TLMainViewController ()

@end

@implementation TLMainViewController{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //load banner ads
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeFullBanner];
    }
    else{
        _adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    }
    
    //show ads
    _interstitial = [self createAndLoadInterstitial];
    
    [_adBannerView setAdUnitID:@"ca-app-pub-4039533744360639/6234573701"];
    [_adBannerView setDelegate:self];
    [_adBannerView setRootViewController:self];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setAllowsMultipleSelection:NO];
    [_tableView setSeparatorColor:[UIColor orangeColor]];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TLDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"idCellDetail"];
    [_tableView registerNib:[UINib nibWithNibName:@"TLExpandableViewCell" bundle:nil] forCellReuseIdentifier:@"idExpandableCell"];
    
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self runRateApp];
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID,@"aea500effe80e30d5b9edfd352b1602d"];
    
    [_adBannerView loadRequest:request];
    
    [self createNotification];
}

-(void)setData:(NSArray *)data{

    dataArr = [NSMutableArray arrayWithCapacity:0];
    for (NSArray *item in data) {
        
        BOOL isExpandable = YES;
        BOOL isExpanded = NO;
        NSDictionary *dicitem = [NSDictionary dictionaryWithObjectsAndKeys:item, @"data",
                                                                           [NSNumber numberWithBool:isExpandable], @"isExpandable",
                                                                           [NSNumber numberWithBool:isExpanded], @"isExpanded",nil];
        
        [dataArr addObject:dicitem];
    }
}

-(GADInterstitial*)createAndLoadInterstitial
{
    _interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-4039533744360639/7711306900"];
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID,@"aea500effe80e30d5b9edfd352b1602d"];
    
    [_interstitial setDelegate:self];
    [_interstitial loadRequest:request];
    
    return _interstitial;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Ads Delegate
-(void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    [ad presentFromRootViewController:self];
}

-(void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad
{
    _adsloaded = NO;
    NSLog(@"Fail to load interstitial ads");
}

#pragma mark - UITableView Delegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _adBannerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _adBannerView.frame.size.height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data  = [dataArr objectAtIndex:indexPath.row];
    
    if ([[data objectForKey:@"isExpandable"] boolValue] == NO) {
        TLExpandableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idExpandableCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.textColor = [UIColor grayColor];
        
        NSArray  *item = [data objectForKey:@"data"];
        NSString *description = [item objectAtIndex:3];
        
        [cell setStringDetail:description];
        
        return cell;
    }else{
        TLDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellDetail"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.textColor = [UIColor grayColor];
        [cell setDelegate:self];
        
        NSDictionary *data  = [dataArr objectAtIndex:indexPath.row];
        NSArray  *item = [data objectForKey:@"data"];
        
        NSString *title  = @"";
        NSString *catID  = @"";
        NSString *description = @"";
        NSString *audio = @"";
        
        catID = [item objectAtIndex:1];
        title = [item objectAtIndex:2];
        description = [item objectAtIndex:3];
        audio = [item objectAtIndex:5];
        
        [cell setCategoryID:[catID integerValue]];
        [cell setDisplayTitle:title];
        [cell setDisplaySpell:[self getSpell:description]];
        [cell setDisplayDetail:[self getGiaiThichVal:description]];
        [cell setAudio:audio];
        
        return cell;
    }
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //setup page
    [self setupPageView:indexPath];
//    
//    NSDictionary *item = [dataArr objectAtIndex:indexPath.row];
//
//    if ([[item objectForKey:@"isExpandable"] boolValue]) {
//        
//        if ([[item objectForKey:@"isExpanded"] boolValue] == NO) {
//            BOOL isExpandable = NO;
//            BOOL isExpanded = NO;
//            NSDictionary *dicitem = [NSDictionary dictionaryWithObjectsAndKeys:[item objectForKey:@"data"], @"data",
//                                     [NSNumber numberWithBool:isExpandable], @"isExpandable",
//                                     [NSNumber numberWithBool:isExpanded], @"isExpanded",nil];
//            
//            [dataArr insertObject:dicitem atIndex:indexPath.row + 1];
//            
//            isExpanded = YES;
//            isExpandable = YES;
//            NSDictionary *updateItem = [NSDictionary dictionaryWithObjectsAndKeys:[item objectForKey:@"data"], @"data",
//                                       [NSNumber numberWithBool:isExpandable], @"isExpandable",
//                                       [NSNumber numberWithBool:isExpanded], @"isExpanded",nil];
//            
//            [dataArr replaceObjectAtIndex:indexPath.row withObject:updateItem];
//            
//            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//        }
//        else{
//            
//            BOOL isExpandable = YES;
//            BOOL isExpanded = NO;
//            NSDictionary *updateItem = [NSDictionary dictionaryWithObjectsAndKeys:[item objectForKey:@"data"], @"data",
//                                        [NSNumber numberWithBool:isExpandable], @"isExpandable",
//                                        [NSNumber numberWithBool:isExpanded], @"isExpanded",nil];
//            
//            [dataArr replaceObjectAtIndex:indexPath.row withObject:updateItem];
//            [dataArr removeObjectAtIndex:indexPath.row + 1];
//            
//            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//        }
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data  = [dataArr objectAtIndex:indexPath.row];
    
    if ([[data objectForKey:@"isExpandable"] boolValue] == NO) {
        return 120;
    }
    
    return 80;
}

#pragma mark - TableCellView Delegate
-(void)speaker:(NSString *)audio{
    [self play:audio];
}


-(NSString*)getWord:(NSString*)html{
    
    for(NSString* line in [html componentsSeparatedByString:@"\n\t"])
    {
        if ([line containsString:@"<span style='color: blue; font-size: 16px ! important;'>"]){  //word
            for (NSString* subline in [line componentsSeparatedByString:@"</span>"]) {
                if ([subline containsString:@"<span style='color: blue; font-size: 16px ! important;'>"]) {
                    return [subline stringByReplacingOccurrencesOfString:@"<span style='color: blue; font-size: 16px ! important;'>" withString:@""];
                }
            }
        }
    }
    
    return @"";
}

-(NSString*)getSpell:(NSString*)html{

    for(NSString* line in [html componentsSeparatedByString:@"\n\t"])
    {
        if ([line containsString:@"<span style='color: blue; font-size: 16px ! important;'>"]){  //word
            
            for (NSString* subline in [line componentsSeparatedByString:@"</span>"]) {
                if ([subline containsString:@"<span style='color: red;'>"]){
                    return [subline stringByReplacingOccurrencesOfString:@"<span style='color: red;'>" withString:@""];
                }
            }
        }
    }
    
    return @"";
}

-(NSString*)getGiaiThich:(NSString*)html{

    for(NSString* line in [html componentsSeparatedByString:@"\n\t"])
    {
        if ([line containsString:@"<span class='bold'>Giải thích: "]){ //giai thich
            
            NSString *shortline = [line stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            for (NSString *subline in [shortline componentsSeparatedByString:@"</span>"]) {
                if ([subline containsString:@"<span class='bold'>"]) {
                    return [subline stringByReplacingOccurrencesOfString:@"<span class='bold'>" withString:@""];
                }
            }
        }
    }
    
    return @"";
}

-(NSString*)getGiaiThichVal:(NSString*)html{
    
    for(NSString* line in [html componentsSeparatedByString:@"\n\t"])
    {
        if ([line containsString:@"<span class='bold'>Giải thích: "]){ //giai thich
            
            NSString *shortline = [line stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            for (NSString *subline in [shortline componentsSeparatedByString:@"</span>"]) {
                if([subline containsString:@"<br>"]){
                    return [subline stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
                }
            }
        }
    }
    
    return @"";
}

-(NSString*)getTuLoai:(NSString*)html{
    
    for(NSString* line in [html componentsSeparatedByString:@"\n\t"])
    {
        if ([line containsString:@"<span class='bold'>Từ loại: "]){ //tu loai
            
            NSString *shortline = [line stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            for (NSString *subline in [shortline componentsSeparatedByString:@"</span>"]) {
                if ([subline containsString:@"<span class='bold'>"]) {
                    return [subline stringByReplacingOccurrencesOfString:@"<span class='bold'>" withString:@""];
                }
            }
        }
    }
    
    return @"";
}

-(NSString*)getTuLoaiVal:(NSString*)html{
  
    for(NSString* line in [html componentsSeparatedByString:@"\n\t"])
    {
        if ([line containsString:@"<span class='bold'>Từ loại: "]){ //tu loai
            
            NSString *shortline = [line stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            for (NSString *subline in [shortline componentsSeparatedByString:@"</span>"]) {
                if([subline containsString:@"<br>"]){
                    return [subline stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
                }
            }
        }
    }
    
    return @"";
}

-(NSString*)getVidu:(NSString*)html{
    
    for(NSString* line in [html componentsSeparatedByString:@"\n\t"])
    {
        if([line containsString:@"<span class='bold'>Ví dụ: "]){ //vi du
            
            NSString *shortline = [line stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            for (NSString *subline in [shortline componentsSeparatedByString:@"</span>"]) {
                if ([subline containsString:@"<span class='bold'>"]) {
                    return [subline stringByReplacingOccurrencesOfString:@"<span class='bold'>" withString:@""];
                }
            }
        }
    }
    
    return @"";
}

-(NSString*)getViduVal:(NSString*)html{
    
    for(NSString* line in [html componentsSeparatedByString:@"\n\t"])
    {
        if([line containsString:@"<span class='bold'>Ví dụ: "]){ //vi du
            NSString *shortline = [line stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            for (NSString *subline in [shortline componentsSeparatedByString:@"</span>"]) {
                if([subline containsString:@"<br>"]){
                    return [[subline componentsSeparatedByString:@"<br/>"] objectAtIndex:0];
                }
            }
        }
    }
    
    return @"";
}

#pragma mark - Page view
-(void)setupPageView:(NSIndexPath*)index{
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    TLPageViewController *initialView = [self viewControllerAtIndex:index.row];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialView];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    
    [self showPopupAnimation];
    
    [self.pageController didMoveToParentViewController:self];
    [self addPageControll:index];
}

#pragma mark
#pragma mark PageViewControllerDelegate
-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    TLPageViewController *pageContentView = (TLPageViewController*)pendingViewControllers[0];
    [self.pageControll setCurrentPage:[pageContentView index]];
    [self.pageControll updateCurrentPageDisplay];
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [(TLPageViewController*)viewController index];
    
    index++;
    
    if (index > [dataArr count] - 1) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [(TLPageViewController*)viewController index];
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    
    return [self viewControllerAtIndex:index];
}

-(TLPageViewController*)viewControllerAtIndex:(NSInteger)index
{
    TLPageViewController *pageviewcontroller = [[TLPageViewController alloc] initWithNibName:@"TLPageViewController" bundle:nil];
    [pageviewcontroller setDelegate:self];
    pageviewcontroller.index = index;
    
    NSDictionary *data  = [dataArr objectAtIndex:index];
    NSArray  *item = [data objectForKey:@"data"];
    NSString *description = [item objectAtIndex:3];
    NSString *audio = [item objectAtIndex:5];
                             
    [pageviewcontroller setAudio:audio];
    [pageviewcontroller setTitle:[self getWord:description]];
    [pageviewcontroller setSpell:[self getSpell:description]];
    [pageviewcontroller setTuloai:[self getTuLoaiVal:description]];
    [pageviewcontroller setGiaiThich:[self getGiaiThichVal:description]];
    [pageviewcontroller setVidu:[self getViduVal:description]];
    
    [pageviewcontroller.view setFrame:[[self view] frame]];
    
    return pageviewcontroller;
}

-(void)addPageControll:(NSIndexPath*)index
{
    self.pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    [self.pageControll setTintColor:[UIColor orangeColor]];
    [self.pageControll setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [self.pageControll setHidesForSinglePage:YES];
    [self.pageControll setNumberOfPages:[dataArr count]];
    [self.pageControll setCurrentPage:index.row];
    [self.view addSubview:self.pageControll];
}

#pragma mark - Popup Delegate
-(void)nextpage{
    NSLog(@"Next page");
    
}

-(void)closepage{
    [self.pageController removeFromParentViewController];
    
    [self closePopupAnimation];
}

-(void)speak:(NSString *)audio{
    [self play:audio];
}

-(void)play:(NSString*)audio{
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],audio];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSError *error = nil;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    _player.volume = 1.0;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:soundFilePath]){
        
        [_player prepareToPlay];
        
        if(![_player play]){
            NSLog(@"speak fail %@",audio);
        }
    }
}

-(void)showPopupAnimation{
    self.pageController.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.pageController.view.alpha = 0;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.pageController.view.alpha = 1;
        self.pageController.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

-(void)closePopupAnimation{
    [UIView animateWithDuration:0.2 animations:^{
        self.pageController.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.pageController.view.alpha = 0.0;
        
        self.pageControll.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.pageControll.alpha = 0.0;
    } completion:^(BOOL finished) {
        [[self.pageController view] removeFromSuperview];
        [self.pageControll removeFromSuperview];
    }];
}

#pragma mark - Local Notification
-(void)createNotification{
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSDate *currentDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitHour  | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    
    NSInteger timePeriod = [self getNotificationTimePeriod];
    BOOL isEnableNotice = [[[NSUserDefaults standardUserDefaults] valueForKey:TL_ENABLE_NOTICE] boolValue];
    
    
    if (isEnableNotice) {
        NSInteger count = ((22 - hour)*60 - minute)/timePeriod;
        
        for (int i=0; i < count; i++) {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            
            NSDictionary *data  = [dataArr objectAtIndex:i%12];
            NSArray  *item = [data objectForKey:@"data"];
            
            NSString *description = @"";
            
            description = [item objectAtIndex:3];
            
            NSString *strBody = [[self getWord:description] stringByAppendingString:@" "];
            strBody = [strBody stringByAppendingString:[self getSpell:description]];
            strBody = [strBody stringByAppendingString:@"\n"];
            strBody = [strBody stringByAppendingString:[self getTuLoaiVal:description]];
            
            notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:i*timePeriod*60];
            notification.userInfo = data;
            notification.alertBody = strBody;
            notification.timeZone = [NSTimeZone localTimeZone];
            notification.applicationIconBadgeNumber = 1;
            notification.soundName = UILocalNotificationDefaultSoundName;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    }
}

-(NSInteger)getNotificationTimePeriod{
    NSInteger timePeriod = [[[NSUserDefaults standardUserDefaults] valueForKey:TL_TIMEPERIOD_NOTICE] integerValue];
    
    switch (timePeriod) {
        case 0:
            return 5;
            break;
        case 1:
            return 10;
            break;
        case 2:
            return 15;
            break;
        case 3:
            return 30;
            break;
        case 4:
            return 60;
            break;
        default:
            return 5;
            break;
    }
    
    return 5;
}

#pragma mark - Setting
-(void)runRateApp
{
    //1190545147
    [Appirater setAppId:@"1243304442"];    // Change for your "Your APP ID"
    [Appirater setDaysUntilPrompt:2];     // Days from first entered the app until prompt
    [Appirater setUsesUntilPrompt:12];     // Number of uses until prompt
    [Appirater setTimeBeforeReminding:2]; // Days until reminding if the user taps "remind me"
    //[Appirater setDebug:YES];           // If you set this to YES it will display all the time
    
    //... Perhaps do stuff
    
    [Appirater appLaunched:YES];
}

@end
