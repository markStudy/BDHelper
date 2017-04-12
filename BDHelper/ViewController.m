//
//  ViewController.m
//  BDHelper
//
//  Created by Mark_Mac on 2017/4/12.
//  Copyright © 2017年 BD. All rights reserved.
//

#import "ViewController.h"
#import "MKHelper.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDate];
}


- (void)getDate {
    
    NSString *currentTimestamp = [MKDateHelper getCurrentTimestamp];
    NSLog(@"currentTimestamp == %@",currentTimestamp);
    
    
    NSString *timestamp = [MKDateHelper timestampChangesStandarTime:currentTimestamp dateFormatter:nil];
    NSLog(@"timestamp == %@",timestamp);
    
    NSString *week = [MKDateHelper timeToweek:timestamp dateFormatter:nil];
    NSLog(@"week == %@",week);
    
    
    NSString *timestampDate = [MKDateHelper timestampChangesStandarTime:currentTimestamp dateFormatter:minFormatter];
    NSLog(@"timestampDate == %@",timestampDate);
    
    NSString *phoneModel = [MKDeviceInfoHelper phoneModels];
    NSLog(@"phoneModel == %@",phoneModel);
    
    NSString *phoneVersion = [MKDeviceInfoHelper phoneSystemVersion];
    NSLog(@"phoneVersion == %@",phoneVersion);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
