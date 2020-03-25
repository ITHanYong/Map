//
//  MapNavigationView.h
//  MapNavigation
//
//  Created by Monk on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapNavigationView : UIView<UIActionSheetDelegate,CLLocationManagerDelegate>

/**
 *  从指定地导航到指定地
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void)showMapNavigationViewFormcurrentLatitude:(double)currentLatitude currentLongitute:(double)currentLongitute TotargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name;
/**
 *  从目前位置导航到指定地
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void)showMapNavigationViewWithtargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name;
- (void)remove;

@end

NS_ASSUME_NONNULL_END
