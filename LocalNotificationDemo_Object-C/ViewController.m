//
//  ViewController.m
//  LocalNotificationDemo_Object-C
//
//  Created by 沙庭宇 on 2019/3/24.
//  Copyright © 2019 沙庭宇. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController () <UNUserNotificationCenterDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// send notification
- (void)sendNotifcation
{
    NSString *title    = @"Notification title";// 通知的标题
    NSString *subtitle = @"Notification subtitle";// 通知的副标题
    NSString *body     = @"Notification body";// 通知的内容
    
    // iOS 10 之后统一了通知的模块,使用UNUserNotificationCenter处理,而不是UILocalNotification
    if (@available(iOS 10.0, *)) {
        NSString *identifier = @"request_notification";// 通知标识符,类似线程名,用于调试
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];// 获取通知控制中心对象,管理通知
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];//设置通知内容
        content.badge = [NSNumber numberWithInt:1];// 设置通知消息数,一般统一管理,这里因Demo不做考虑
        content.title = title;
        content.subtitle = subtitle;
        content.body = body;
        content.sound = [UNNotificationSound defaultSound];// 默认通知声音,可以自定义
        
        UNTimeIntervalNotificationTrigger *triggerTime = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];// 触发通知时间
        UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:triggerTime];// 创建一个通知请求对象
        // 添加通知到控制中心
        [center addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Notification error, in idenifier: %@, error message:%@", identifier, error);
            } else {
                NSLog(@"Add notification request object successed");
            }
        }];
    } else {
        // 创建本地通知
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        // 设置通知内容
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];//设置通知时间
        localNotification.alertTitle = title;
        localNotification.alertBody = body;
        localNotification.alertAction = @"action";//设置通知滑块内容
        localNotification.soundName = UILocalNotificationDefaultSoundName;//设置通知声音
        localNotification.applicationIconBadgeNumber = 1;//设置图标右上角通知数字
//        发送通知
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

// 移除通知
- (void)removeNotification
{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllDeliveredNotifications];
//        取消某一个通知
//        NSArray *requestIdList = @[@"id_01", @"id_02", @"id_..."];
//        [center removePendingNotificationRequestsWithIdentifiers:requestIdList];
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
//        取消某一个通知
//        [[UIApplication sharedApplication] cancelLocalNotification:[UILocalNotification alloc]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self sendNotifcation];
}


@end
