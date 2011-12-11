//
//  SignatureView.m
//  JBSignatureControl
//
//  Created by Jesse Bunch on 12/10/11.
//  Copyright (c) 2011 Jesse Bunch. All rights reserved.
//

#import "JBSignatureView.h"



#pragma mark - *** Private Interface ***

@interface JBSignatureView() {
@private
	__strong NSMutableArray *handwritingCoords_;
	__weak UIImage *currentSignatureImage_;
}
@property(nonatomic,strong) NSMutableArray *handwritingCoords;
@end



@implementation JBSignatureView

@synthesize 
handwritingCoords = handwritingCoords_;



#pragma mark - *** Initializers ***

/**
 * Designated initializer
 * @author Jesse Bunch
 **/
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		self.handwritingCoords = [[NSMutableArray alloc] init];
		[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}



#pragma mark - *** Drawing ***

/**
 * Main drawing method. We keep an array of touch coordinates to represent
 * the user dragging their finter across the screen. This method loops through
 * those coordinates and draws a line to each. When the user lifts their finger,
 * we insert a CGPointZero object into the array and handle that here.
 * @author Jesse Bunch
 **/
- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Set drawing params
	CGContextSetLineWidth(context, 5.0f);
	CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
	CGContextSetLineCap(context, kCGLineCapRound);
	CGContextBeginPath(context);
	
	// This flag tells us to move to the point
	// rather than draw a line to the point
	BOOL isFirstPoint = YES;
	
	// Loop through the strings in the array
	// which are just serialized CGPoints
	for (NSString *touchString in self.handwritingCoords) {
		
		// Unserialize
		CGPoint tapLocation = CGPointFromString(touchString);
		
		// If we have a CGPointZero, that means the next
		// iteration of this loop will represent the first
		// point after a user has lifted their finger.
		if (CGPointEqualToPoint(tapLocation, CGPointZero)) {
			isFirstPoint = YES;
			continue;
		}
		
		// If first point, move to it and continue. Otherwize, draw a line from
		// the last point to this one.
		if (isFirstPoint) {
			CGContextMoveToPoint(context, tapLocation.x, tapLocation.y);
			isFirstPoint = NO;
		} else {
			CGPoint startPoint = CGContextGetPathCurrentPoint(context);
			CGContextAddQuadCurveToPoint(context, startPoint.x, startPoint.y, tapLocation.x, tapLocation.y);
			CGContextAddLineToPoint(context, tapLocation.x, tapLocation.y);
		}
		
	}	
	
	// Stroke it, baby!
	CGContextStrokePath(context);

}



#pragma mark - *** Touch Handling ***

/**
 * Not implemented.
 * @author Jesse Bunch
 **/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	// Nothin' doin'
}

/**
 * This method adds the touch to our array.
 * @author Jesse Bunch
 **/
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation = [touch locationInView:self];
	
	[self.handwritingCoords addObject:NSStringFromCGPoint(touchLocation)];	
	[self setNeedsDisplay];
	
}

/**
 * Add a CGPointZero to our array to denote the user's finger has been
 * lifted.
 * @author Jesse Bunch
 **/
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.handwritingCoords addObject:NSStringFromCGPoint(CGPointZero)];	
}

/**
 * Touches Cancelled.
 * @author Jesse Bunch
 **/
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.handwritingCoords addObject:NSStringFromCGPoint(CGPointZero)];
}



#pragma mark - *** Public Methods ***

/**
 * Returns the signature as a UIImage
 * @author Jesse Bunch
 **/
-(UIImage *)getSignatureImage {
	
	UIGraphicsBeginImageContext(self.bounds.size);
	[self drawRect: self.bounds];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
	
}


@end
