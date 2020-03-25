//
//  ViewController.m
//  MapNavigation
//
//  Created by Monk on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ViewController.h"
#import "MapNavigationView.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

<CLLocationManagerDelegate, UITextFieldDelegate>
{
    double longitude;
    double latitude;
}

@property (nonatomic, strong) MapNavigationView *mapNavigationView;

@property (nonatomic, strong) CLLocationManager *localtionManager;

@property (nonatomic, strong) UITextField *addressTF;

@property (nonatomic, copy) NSString *address;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.addressTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 40)];
    self.addressTF.delegate = self;
    self.addressTF.layer.masksToBounds = YES;
    self.addressTF.layer.borderWidth = 1.0f;
    self.addressTF.layer.borderColor = [UIColor orangeColor].CGColor;
    self.addressTF.layer.cornerRadius = 10;
    self.addressTF.placeholder = @"请输入目的地";
    [self.view addSubview:self.addressTF];
    
    UIButton *btn1 =[UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(0, 200, self.view.frame.size.width, 30);
    [btn1 setTitle:@"从指定地导航到指定地" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 =[UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(0, 250, self.view.frame.size.width, 30);
    [btn2 setTitle:@"从目前位置导航到指定地" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(button2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"%@-%@",textField.text,string);
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    
    return YES;
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
    [self.view endEditing:YES];
    [self genocoder:1];
    
    
}

//从目前位置导航到指定地
// targetLati:22.488260 targetLongi:113.915049
//toName:中海油华英加油站
- (void)button2:(id)sender {
    [self.view endEditing:YES];
    [self genocoder:2];
}


//MARK: - 当位置发生改变时调用（上面设置的10米，也就是当位置改变大于10米的时候这个方法就会调用）
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //取出第一个位置
    CLLocation *localtion = [locations firstObject];
    NSLog(@"%@", localtion.timestamp);
    //位置坐标
    CLLocationCoordinate2D coordinate = localtion.coordinate;
    
    NSLog(@"经度： %f, 纬度： %f， 海拔：%f， 航向：%f, 速度： %f", coordinate.longitude, coordinate.latitude, localtion.altitude, localtion.course, localtion.speed);
    //如果不需要实时定位，使用完即关闭定位功能
    // [_localtionManager stopUpdatingLocation];
}


//MARK: - 比较两地之间距离（直线距离）
- (void)compareDistance{
    //北京（116.3， 39.9）
    CLLocation *localtion1 = [[CLLocation alloc]initWithLatitude: 39.9 longitude:116.3];
    //郑州(113.42, 34.44)
    CLLocation *localtion2 = [[CLLocation alloc]initWithLatitude:34.44 longitude:113.42];
    //比较两地距离
    CLLocationDistance distance = [localtion1 distanceFromLocation:localtion2];
    //单位是m/s, 所以这里除以1000
    NSLog(@"北京距离郑州的距离是：%f", distance/1000);
}

//MARK: - 地理编码与反地理编码
//地理编码:根据地址获得相应的经纬度以及详细信息
//反地理编码:根据经纬度获取详细的地址信息(比如:省市、街区、楼层、门牌等信息)
//地理编码
- (void)genocoder:(NSInteger)type {
    //创建编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //判断是否空
    if (self.addressTF.text.length == 0) {
        return;
    }
    [geocoder geocodeAddressString:self.addressTF.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil || placemarks.count == 0) {
            return ;
        }
        //创建placeMarks对象
        CLPlacemark *placeMark = [placemarks firstObject];
        //赋值经度
        self->longitude = placeMark.location.coordinate.longitude;
        
        //赋值纬度
        self->latitude = placeMark.location.coordinate.latitude;
        
        //赋值详细地址
        self.address = placeMark.name;
        
        if (type == 1) {
            //起始位置到目标位置
            [self.mapNavigationView showMapNavigationViewFormcurrentLatitude:30.307566 currentLongitute:120.097446 TotargetLatitude:self->latitude targetLongitute:self->longitude toName:self.address];
            [self.view addSubview:self.mapNavigationView];
        }else{
            //从当前位置出发
            [self.mapNavigationView showMapNavigationViewWithtargetLatitude:self->latitude targetLongitute:self->longitude toName:self.address];
            [self.view addSubview:self.mapNavigationView];
        }
    }];
}
//反地理编码
- (void)AntiEncoder {
    //创建地理编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //创建位置
    CLLocation *localtion = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    //反地理编码
    [geocoder reverseGeocodeLocation:localtion completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil ||  placemarks.count == 0) {
            return ;
        }
        
        for (CLPlacemark *placeMark in placemarks) {
            //赋值详细地址
            self.address = placeMark.name;
        }
    }];
}


@end
