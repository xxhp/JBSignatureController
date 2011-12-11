//
//  JBSignatureController.m
//  JBSignatureController
//
//  Created by Jesse Bunch on 12/10/11.
//  Copyright (c) 2011 Jesse Bunch. All rights reserved.
//

#import "JBSignatureController.h"
#import "JBSignatureView.h"



#pragma mark - *** Private Interface ***

@interface JBSignatureController() {
@private
	__strong JBSignatureView *signatureView_;
	__strong UIImageView *signaturePanelBackgroundImageView_;
	__strong UIImage *portraitBackgroundImage_, *landscapeBackgroundImage_;
	__strong UIButton *confirmButton_, *cancelButton_;
}

// The view responsible for handling signature sketching
@property(nonatomic,strong) JBSignatureView *signatureView;

// The background image underneathe the sketch
@property(nonatomic,strong) UIImageView *signaturePanelBackgroundImageView;

@end



@implementation JBSignatureController

@synthesize
signaturePanelBackgroundImageView = signaturePanelBackgroundImageView_,
signatureView = signatureView_,
portraitBackgroundImage = portraitBackgroundImage_,
landscapeBackgroundImage = landscapeBackgroundImage_;



#pragma mark - *** Initializers ***

/**
 * Designated initializer
 * @author Jesse Bunch
 **/
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.signaturePanelBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-signature-portrait"]];
		self.signatureView = [[JBSignatureView alloc] init];
		self.portraitBackgroundImage = [UIImage imageNamed:@"bg-signature-portrait"];
		self.landscapeBackgroundImage = [UIImage imageNamed:@"bg-signature-landscape"];
	}
	
	return self;
	
}

/**
 * Initializer
 * @author Jesse Bunch
 **/
-(id)init {
	return [self initWithNibName:nil bundle:nil];
}



#pragma mark - *** View Lifecycle ***

/**
 * Setup the view heirarchy
 * @author Jesse Bunch
 **/
-(void)viewDidLoad {
	
	[self.signaturePanelBackgroundImageView setFrame:self.view.bounds];
	[self.signaturePanelBackgroundImageView setContentMode:UIViewContentModeTopLeft];
	[self.view addSubview:self.signaturePanelBackgroundImageView];
	
	[self.signatureView setFrame:self.view.bounds];
	[self.view addSubview:self.signatureView];
	
}

/**
 * Support for different orientations
 * @author Jesse Bunch
 **/
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { 	
	return YES;
}

/**
 * Upon rotation, switch out the background image
 * @author Jesse Bunch
 **/
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
		toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		[self.signaturePanelBackgroundImageView setImage:self.landscapeBackgroundImage];
	} else {
		[self.signaturePanelBackgroundImageView setImage:self.portraitBackgroundImage];
	}
	
}

/**
 * After rotation, we need to adjust the signature view's frame to fill.
 * @author Jesse Bunch
 **/
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.signatureView setFrame:self.view.bounds];
	[self.signatureView setNeedsDisplay];
}



@end
