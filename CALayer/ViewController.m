//
//  ViewController.m
//  CALayer
//
//  Created by sirko on 21/04/15.
//  Copyright (c) 2015 sirko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  CALayer *containerLayer = [CALayer layer];
  [containerLayer setBounds:CGRectMake(0.0f, 0.0f, 500.0f, 320.0f)];
  [containerLayer setPosition:[[self view] center]];
  UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRYNIXZ9BvAJTlK4mPPIzCKqAJQtk56Of4tsWtAG7-gHkzVGNA5xg"]]];
  [containerLayer setContents:(id)[image CGImage]];
  
  CALayer *translucentBlackLayer = [CALayer layer];
  [translucentBlackLayer setBounds:[containerLayer bounds]];
  [translucentBlackLayer setPosition:
   CGPointMake([containerLayer bounds].size.width/2.0f,
               [containerLayer bounds].size.height/2.0f)];
  [translucentBlackLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
  [translucentBlackLayer setOpacity:0.45];
  [containerLayer addSublayer:translucentBlackLayer];
  
  CAShapeLayer *maskLayer = [CAShapeLayer layer];
  [maskLayer setBorderColor:[[UIColor purpleColor] CGColor]];
  [maskLayer setBorderWidth:5.0f];
  [maskLayer setBounds:[containerLayer bounds]];
  
  UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
                        CGRectMake([translucentBlackLayer bounds].size.width/2.0f - 100.0f,
                                   [translucentBlackLayer bounds].size.height/2.0f - 100.0f,
                                   200.0f, 200.0f)];
  
  [path appendPath:[UIBezierPath bezierPathWithRect:[maskLayer bounds]]];
  
  [maskLayer setFillColor:[[UIColor blackColor] CGColor]];
  [maskLayer setPath:[path CGPath]];
  
  [maskLayer setPosition:
   CGPointMake([translucentBlackLayer bounds].size.width/2.0f,
               [translucentBlackLayer bounds].size.height/2.0f)];
  
  [maskLayer setFillRule:kCAFillRuleEvenOdd];
  [translucentBlackLayer setMask:maskLayer];

  [[[self view] layer] addSublayer:containerLayer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
