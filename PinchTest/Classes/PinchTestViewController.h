//
//  PinchTestViewController.h
//  PinchTest
//
//  Created by Kevin Cao on 11-2-21.
//  Copyright 2011 kevincao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinchTestViewController : UIViewController {
	UIImageView *imageView1;
	UIImageView *imageView2;
	UIImageView *imageView3;
	UIImageView *imageView4;
	
	float endRotation;
	NSArray *startRotations;
	
	CGPoint startPosition;
	NSArray *endPositions;
	
	// 0 ~ 1 : collapse to expand
	float factor;
	
	BOOL isCollapsed;
}

@end

