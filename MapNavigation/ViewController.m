//
//  ViewController.m
//  MapNavigation
//
//  Created by Monk on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ViewController.h"
#import "MapNavigationView.h"

@interface ViewController ()

@property (nonatomic, strong) MapNavigationView *mapNavigationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn1 =[UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(0, 100, self.view.frame.size.width, 30);
    [btn1 setTitle:@"从指定地导航到指定地" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 =[UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(0, 150, self.view.frame.size.width, 30);
    [btn2 setTitle:@"从目前位置导航到指定地" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(button2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}


- (MapNavigationView *)mapNavigationView{
    if (_mapNavigationView == nil) {
        _mapNavigationView = [[MapNavigationView alloc]init];
    }
    return _mapNavigationView;
}


//从指定地导航到指定地
//currentLatitude:22.477806  ;:113.902847
// targetLati:22.488260 targetLongi:113.915049
//toName:中海油华英加油站
- (void)button1:(id)sender {
    [self.mapNavigationView showMapNavigationViewFormcurrentLatitude:30.307566 currentLongitute:120.097446 TotargetLatitude:30.2802680300 targetLongitute:120.0953292800 toName:@"西城广场"];
    [self.view addSubview:_mapNavigationView];
}

//从目前位置导航到指定地
// targetLati:22.488260 targetLongi:113.915049
//toName:中海油华英加油站
- (void)button2:(id)sender {
    [self.mapNavigationView showMapNavigationViewWithtargetLatitude:30.2802680300 targetLongitute:120.0953292800 toName:@"西城广场"];
    [self.view addSubview:_mapNavigationView];
}



@end
