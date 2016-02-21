//
//  AppListTableViewController.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/25.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "AppListTableViewController.h"
#import "PrivateApiHeader.h"
#import "AppInfo.h"
#import "AppCell.h"
//#import "dlfcn.h"
#include <dlfcn.h>
#import <objc/runtime.h>
#define PRIVATE_PATH  "/System/Library/PrivateFrameworks/CoreTelephony.framework/CoreTelephony"

#define SBSERVPATH  "/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices"
#define UIKITPATH "/System/Library/Framework/UIKit.framework/UIKit"
@interface AppListTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSMutableArray *appArrays;
@end

@implementation AppListTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:NO animated:YES];
    
}

/**
 *打开APP
 */
-(void)openAppByBundleId:(NSString*)bundleId
{
    int ret = -1;
    if (bundleId) {
        ret = SBSLaunchApplicationWithIdentifier(bundleId, NO);
        if (ret != 0) {
            NSLog(@"run app error \n");
        }else
            printf("run app successfully \n");
    }
    
}
//typedef kern_return_t SpringBoardServicesReturn;

-(void)getAppArrays{
    
    
    
//    void *SpringBoardServices = dlopen("/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices", RTLD_LAZY);
//    NSParameterAssert(SpringBoardServices);
//    mach_port_t (*SBSSpringBoardServerPort)() = dlsym(SpringBoardServices, "SBSSpringBoardServerPort");
//    NSParameterAssert(SBSSpringBoardServerPort);
//    SpringBoardServicesReturn (*SBSuspend)(mach_port_t port) = dlsym(SpringBoardServices, "SBSuspend");
//    NSParameterAssert(SBSuspend);
//    mach_port_t sbsMachPort = SBSSpringBoardServerPort();
//    SBSuspend(sbsMachPort);
//    dlclose(SpringBoardServices);
    
    
    
    
//    
//    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
//    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
    
//    
//    mach_port_t port = (mach_port_t)SBSSpringBoardServerPort();
//    NSArray* apps = SBSCopyApplicationDisplayIdentifiers(port, NO, YES);
//    mach_port_deallocate(mach_task_self(), port);
//    
//    NSLog(@"app:%@",apps);
    
    char buff[256]  = {0};
    mach_port_t port = (mach_port_t)SBSSpringBoardServerPort();
    SBFrontmostApplicationDisplayIdentifier(port,buff);
   
    NSArray *currentRunningAppBundleIdArray= SBSCopyApplicationDisplayIdentifiers(&port,NO,YES);
     mach_port_deallocate(mach_task_self(), port);
    
    NSLog(@"-------------%s",buff);
    NSLog(@"array:%@",currentRunningAppBundleIdArray);
    _appArrays =[[NSMutableArray alloc] init];
    for (int i =0; i<currentRunningAppBundleIdArray.count; i++) {
        NSString *buildId =[currentRunningAppBundleIdArray objectAtIndex:i];
        NSString *str = SBSCopyLocalizedApplicationNameForDisplayIdentifier(buildId );
        NSLog(@"第%d个APP:%@",i,str);
        UIImage *icon = nil;
        NSData *iconData = SBSCopyIconImagePNGDataForDisplayIdentifier(buildId);
        if (iconData != nil) {
            icon = [UIImage imageWithData:iconData];
        }
        AppInfo *appInfo = [AppInfo new];
        appInfo.appName = str;
        appInfo.image = icon;
        appInfo.buildId=buildId;
        [_appArrays addObject:appInfo];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAppArrays];
    
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"选择应用";
    
    self.tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0] ;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)refresh:(UIBarButtonItem *)item{
    [self getAppArrays];
    [self.tableView reloadData];
    //    [self openAppByBundleId:@"com.tencent.mqq"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _appArrays.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppInfo *appInfo = _appArrays[indexPath.row];
    AppCell *cell = [AppCell cellWithTableView:tableView];
    [cell settingData:appInfo];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppInfo *appInfo = _appArrays[indexPath.row];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:appInfo forKey:@"AppInfo"];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notif_SendValue object:self userInfo:dictionary];
    [self .navigationController popViewControllerAnimated:YES];
}
@end
