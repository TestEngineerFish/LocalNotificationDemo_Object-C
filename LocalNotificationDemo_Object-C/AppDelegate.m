//
//  AppDelegate.m
//  LocalNotificationDemo_Object-C
//
//  Created by 沙庭宇 on 2019/3/24.
//  Copyright © 2019 沙庭宇. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>// 导入UserNotifications.h头文件

@interface AppDelegate () <UNUserNotificationCenterDelegate>// 实现UNUserNotificationCenterDelegate协议

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    注册通知
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Register fail, error info: %@", error);
            } else {
                NSLog(@"Register successes");
            }
        }];
    } else {
        UIUserNotificationSettings *notificationSetting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:notificationSetting];
    }
//    判断程序启动时,是否是通过点击本地通知来触发的
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        NSLog(@"是通过点击本地通知来打开程序的");
        /**
         *其他相关的通知key
         对应的是启动应用程序的的远程通知信息userInfo（NSDictionary）
         
         UIApplicationLaunchOptionsRemoteNotificationKey
         
         对应的是为启动应用程序的的本地通知对象(UILocalNotification)
         
         UIApplicationLaunchOptionsLocalNotificationKey
         
         对应的对象为启动URL（NSURL）
         
         UIApplicationLaunchOptionsURLKey
         
         从点击3D Touch iCon启动,对应的是点击的iCon的信息。
         
         UIApplicationLaunchOptionsShortcutItemKey
         
         有关蓝牙的操作
         
         UIApplicationLaunchOptionsBluetoothPeripheralsKey
         
         UIApplicationLaunchOptionsBluetoothCentralsKey
         
         对应启动的源应用程序的bundle ID (NSString)
         
         UIApplicationLaunchOptionsSourceApplicationKey
         **/
    }
    return YES;
}

// iOS 10 之后
//App在前台时,收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0))
{
    NSLog(@"App在前台时,收到通知");
}

//点击通知栏
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0))
{
    completionHandler();
    NSLog(@"点击通知后打开App");
}

// iOS 10 之前
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"系统版本低于10.0,系统在在后台,点击后打开程序,接收到了通知");
}
//
- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0))
{
    NSLog(@"要求显示在App里面的通知设置");
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
