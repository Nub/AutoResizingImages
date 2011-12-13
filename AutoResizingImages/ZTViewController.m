//
//  ZTViewController.m
//  AutoResizingImages
//
//  Created by Zachry Thayer on 12/4/11.
//  Copyright (c) 2011 Zachry Thayer. All rights reserved.
//

#import "ZTViewController.h"
#import "UIImage_AutoResizing.h"

@implementation ZTViewController
@synthesize a;
@synthesize b;
@synthesize s;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    s.image = [UIImage imageNamed:@"arrow"];
    CGRect fixed = s.frame;
    fixed.size = s.image.size;
    s.frame = fixed;
    a.image = [UIImage autoResizingImageNamed:@"arrow"];
    b.image = [UIImage autoResizingImageNamed:@"arrow"];
    
    [UIView animateWithDuration:2.5f animations:^(void){
        
        [UIView setAnimationRepeatAutoreverses:YES];
        [UIView setAnimationRepeatCount:1e20f];
        
        CGRect af = a.frame;
        af.size = CGSizeApplyAffineTransform(af.size, CGAffineTransformMakeScale(2.f, 1.f));
        a.frame = af;
        
        CGRect bf = b.frame;
        bf.size = CGSizeApplyAffineTransform(bf.size, CGAffineTransformMakeScale(2.f, 2.f));
        b.frame = bf;
        
        
    }];

    
}

- (void)viewDidUnload
{
    [self setA:nil];
    [self setB:nil];
    [self setS:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
