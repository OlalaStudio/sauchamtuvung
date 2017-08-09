//
//  AppDelegate.m
//  600 Words for Toeic
//
//  Created by NguyenThanhLuan on 15/05/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "AppDelegate.h"
#import "TLCommonDefines.h"

@import GoogleMobileAds;

@interface AppDelegate ()

@end

@implementation AppDelegate{
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //ads
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-4039533744360639~4757840506"];
    
    UIUserNotificationCategory *notiSetting = [[UIUserNotificationCategory alloc] init];
    NSSet *set = [NSSet setWithObject:notiSetting];
    
    UIUserNotificationSettings *notificationsetting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert   categories:set];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationsetting];
    
    NSDictionary *defaul = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithBool:YES], TL_ENABLE_NOTICE,
                            [NSNumber numberWithInteger:0], TL_TIMEPERIOD_NOTICE, nil];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaul];
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    UIApplicationState appState = [[UIApplication sharedApplication] applicationState];
    
    if (appState == UIApplicationStateActive) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
