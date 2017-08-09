//
//  ViewController.m
//  600 Words for Toeic
//
//  Created by NguyenThanhLuan on 15/05/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "ViewController.h"
#import "TLTableViewCell.h"
#import "TLMainViewController.h"
#import "TDatabaseManager.h"

@interface ViewController ()

@end

@implementation ViewController{
    TLSettingViewController *settingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //load banner ads
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeFullBanner];
    }
    else{
        _adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    }
    
    [_adBannerView setAdUnitID:@"ca-app-pub-4039533744360639/6234573701"];
    [_adBannerView setDelegate:self];
    [_adBannerView setRootViewController:self];
    
    [_categoryTable setDelegate:self];
    [_categoryTable setDataSource:self];
    [_categoryTable setSeparatorColor:[UIColor orangeColor]];
    [_categoryTable registerNib:[UINib nibWithNibName:@"TLTableViewCell" bundle:nil] forCellReuseIdentifier:@"idCellNormal"];
    
    categorys = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self initDatabase];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initDatabase{
    
    TDatabaseManager *dbManager = [TDatabaseManager sharedInstance];
    
    if([dbManager open:@"tuvung.sqlite"]){
     
        NSString *query = @"SELECT * FROM wordcat";
        
        // Get the results.
        categorys = [NSMutableArray arrayWithArray:[dbManager loadDataFromDB:query]];
        
        [dbManager close];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID,@"aea500effe80e30d5b9edfd352b1602d"];
    [_adBannerView loadRequest:request];
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

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _adBannerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _adBannerView.frame.size.height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categorys count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellNormal"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.textColor = [UIColor grayColor];
    
    NSArray *item    = [categorys objectAtIndex:indexPath.row];
    NSString *title  = @"";
    NSString *catID  = @"";
    
    catID = [item objectAtIndex:0];
    title = [item objectAtIndex:1];
    
    [cell setDisplayTitle:title];
    [cell setCategoryID:[catID integerValue]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *item = [categorys objectAtIndex:indexPath.row];
    
    NSString *title  = @"";
    NSString *catID  = @"";
    
    catID = [item objectAtIndex:0];
    title = [item objectAtIndex:1];
    
    TDatabaseManager *dbManager = [TDatabaseManager sharedInstance];
    
    NSMutableArray *dataArr;
    
    if([dbManager open:@"tuvung.sqlite"]){
        
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM wordcontent WHERE catid=%@",catID];
        
        // Get the results.
        dataArr = [NSMutableArray arrayWithArray:[dbManager loadDataFromDB:query]];
        
        [dbManager close];
    }
    
    TLMainViewController *lessonViewController = (TLMainViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"idUnit"];
    [lessonViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [lessonViewController setData:dataArr];
    
    [self.navigationController pushViewController:lessonViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (IBAction)settingAction:(id)sender {
    settingView = (TLSettingViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"idSetting"];
    
    [settingView setDelegate:self];
    [settingView.view setFrame:[[self view] frame]];
    
    [self addChildViewController:settingView];
    [[self view] addSubview:[settingView view]];
    
    settingView.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    settingView.view.alpha = 0;
    
    [UIView animateWithDuration:0.2 animations:^{
        settingView.view.alpha = 1;
        settingView.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

#pragma mark - Setting Delegate
-(void)confirmSetting{
    NSLog(@"Confirm setting");
    
    [UIView animateWithDuration:0.2 animations:^{
        settingView.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        settingView.view.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [[settingView view] removeFromSuperview];
    }];
}
@end
