//
//  ViewController.m
//  CardsDemo
//
//  Created by Sachin Medhekar on 12/1/14.
//  Copyright (c) 2014 Sachin Medhekar. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@property CALayer *touchedLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    //self.view.layer.cornerRadius = 20.0;
    //CGRectInset takes a frame and an amount to shrink it by (for both the X and Y), returns a new frame
    //self.view.layer.frame = CGRectInset(self.view.layer.frame, 20, 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)createCard:(CGPoint)point {
    CALayer *cardLayer = [CALayer layer];
    cardLayer.backgroundColor = [UIColor whiteColor].CGColor;
    cardLayer.shadowOffset = CGSizeMake(0, 3);
    //sublayer.shadowRadius = 5.0;
    cardLayer.shadowColor = [UIColor blackColor].CGColor;
    cardLayer.shadowOpacity = 0.8;
    CGFloat cardHeight = 200;
    CGFloat cardWidth = 160;
    cardLayer.frame = CGRectMake(point.x - cardWidth/2, point.y - cardHeight/2, cardWidth, cardHeight);
    [self.view.layer addSublayer:cardLayer];
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(cardLayer.bounds.size.width*.05, cardLayer.bounds.size.width*.05, cardLayer.bounds.size.width*.9, cardLayer.bounds.size.width*.9);
    imageLayer.contents = (id) [UIImage imageNamed:@"RishiCropped.jpg"].CGImage;
    imageLayer.masksToBounds = YES;
    [cardLayer addSublayer:imageLayer];
    
    CATextLayer *label = [CATextLayer layer];
    [label setFont:@"PermanentMarker"];
    [label setFontSize:14];
    label.contentsScale = [[UIScreen mainScreen] scale];
    label.frame = CGRectMake(cardLayer.bounds.size.width*.07, cardLayer.bounds.size.width*.97, cardLayer.bounds.size.width*.9, cardLayer.bounds.size.width*.1);
    //[label setFrame:cardLayer.frame];
    [label setString:@"Rishi Mody"];
    //[label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:[[UIColor blackColor] CGColor]];
    [cardLayer addSublayer:label];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        CGPoint touchedPoint = [touch locationInView:self.view];
        touchedPoint = [[touch view] convertPoint:touchedPoint toView:nil];
        CALayer *layer;
        for (CALayer *subLayer in self.view.layer.sublayers) {
            CALayer *temp;
            temp = [subLayer hitTest:touchedPoint];
            if (temp) {
                layer = temp;
            }
        }
        //CALayer *layer = [(CALayer *)self.view.layer.presentationLayer hitTest:touchedPoint];
        if (layer) {
            self.touchedLayer = layer;
            
        }
        else {
        [self createCard:touchedPoint];
        }
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        if (self.touchedLayer) {
            
            //sub = layer.modelLayer;
            CGPoint point = [touch locationInView:self.view];
            CGFloat cardHeight = 200;
            CGFloat cardWidth = 160;
            [CATransaction begin];
            [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
            
            if (self.touchedLayer.superlayer == self.view.layer) {
                self.touchedLayer.frame = CGRectMake(point.x - cardWidth/2, point.y - cardHeight/2, cardWidth, cardHeight);
            }
            else {
                self.touchedLayer.superlayer.frame = CGRectMake(point.x - cardWidth/2, point.y - cardHeight/2, cardWidth, cardHeight);
            }
            [CATransaction commit];
            
            
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.touchedLayer = nil;
}

@end
