//
//  PinchTestViewController.m
//  PinchTest
//
//  Created by Kevin Cao on 11-2-21.
//  Copyright 2011 kevincao.com. All rights reserved.
//

#import "PinchTestViewController.h"

float degreeToRadian(float r) {
	return r * M_PI / 180;
}

#pragma mark -

@implementation PinchTestViewController

- (CGAffineTransform) interpolateTransform:(NSUInteger)index atPosition:(float)position {
	CGPoint endPosition = [(NSValue *)[endPositions objectAtIndex:index] CGPointValue];
	float x = (endPosition.x - startPosition.x) * position + startPosition.x;
	float y = (endPosition.y - startPosition.y) * position + startPosition.y;
	
	float starRotation = [(NSNumber *)[startRotations objectAtIndex:index] floatValue];
	float r = (endRotation - starRotation) * position + starRotation;
	
	return CGAffineTransformRotate(CGAffineTransformMakeTranslation(x, y), degreeToRadian(r));
}

#pragma mark -

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	startRotations = [[NSArray arrayWithObjects:
				  [NSNumber numberWithInt:5],
				  [NSNumber numberWithInt:15],
				  [NSNumber numberWithInt:-15],
				  [NSNumber numberWithInt:-5],
				  nil] retain];
	endRotation = 0;
	
	startPosition = CGPointMake(85, 165);
	endPositions = [[NSArray arrayWithObjects:
				  [NSValue valueWithCGPoint:CGPointMake(0, 0)],
				  [NSValue valueWithCGPoint:CGPointMake(170, 0)],
				  [NSValue valueWithCGPoint:CGPointMake(0, 330)],
				  [NSValue valueWithCGPoint:CGPointMake(170, 330)],
				  nil] retain];
	
	imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
	imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
	imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.jpg"]];
	imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4.jpg"]];
	[self.view addSubview:imageView1];
	[self.view addSubview:imageView2];
	[self.view addSubview:imageView3];
	[self.view addSubview:imageView4];
	
	// set initial state to collapsed
	factor = 0;
	isCollapsed = YES;
	
	// update transform
	imageView1.transform = [self interpolateTransform:0 atPosition:factor];
	imageView2.transform = [self interpolateTransform:1 atPosition:factor];
	imageView3.transform = [self interpolateTransform:2 atPosition:factor];
	imageView4.transform = [self interpolateTransform:3 atPosition:factor];
	
	// add pinch gesture recognizer
	UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchHandler:)];
	[self.view addGestureRecognizer:recognizer];
	[recognizer release];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[imageView1 release];
	[imageView2 release];
	[imageView3 release];
	[imageView4 release];
	[startRotations release];
	[endPositions release];
}

- (void)dealloc {
    [super dealloc];
	[imageView1 release];
	[imageView2 release];
	[imageView3 release];
	[imageView4 release];
	[startRotations release];
	[endPositions release];
}

#pragma mark -

- (void)pinchHandler:(UIPinchGestureRecognizer *)recognoizer {
	switch (recognoizer.state) {
		case UIGestureRecognizerStateBegan:
		case UIGestureRecognizerStateChanged:
		{
			if (isCollapsed) {
				// start form 0
				factor = recognoizer.scale - 1;
			} else {
				// start from 1
				factor = recognoizer.scale;
			}
			
			if (factor > 1.15) {
				factor = 1.15;
			} else if (factor < -0.05) {
				factor = -0.05;
			}
			
			imageView1.transform = [self interpolateTransform:0 atPosition:factor];
			imageView2.transform = [self interpolateTransform:1 atPosition:factor];
			imageView3.transform = [self interpolateTransform:2 atPosition:factor];
			imageView4.transform = [self interpolateTransform:3 atPosition:factor];
			break;
		}
		case UIGestureRecognizerStateEnded:
		{
			factor = factor > 0.6 ? 1 : 0;
			isCollapsed = factor == 0 ? YES : NO;
			// animate to end
			[UIView animateWithDuration:0.2
								  delay:0
								options:UIViewAnimationOptionCurveEaseOut
							 animations:^{
								 imageView1.transform = [self interpolateTransform:0 atPosition:factor];
								 imageView2.transform = [self interpolateTransform:1 atPosition:factor];
								 imageView3.transform = [self interpolateTransform:2 atPosition:factor];
								 imageView4.transform = [self interpolateTransform:3 atPosition:factor];
							 }
							 completion:nil];
			break;
		}
	}
}

@end
