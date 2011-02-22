//
//  PinchTestAppDelegate.h
//  PinchTest
//
//  Created by Kevin Cao on 11-2-21.
//  Copyright 2011 kevincao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PinchTestViewController;

@interface PinchTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PinchTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PinchTestViewController *viewController;

@end

