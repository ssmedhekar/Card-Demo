//
//  CardScrollView.m
//  CardsDemo
//
//  Created by Sachin Medhekar on 12/2/14.
//  Copyright (c) 2014 Sachin Medhekar. All rights reserved.
//

#import "CardScrollView.h"

@interface CardScrollView ()

@property CALayer *touchedLayer;

@end

@implementation CardScrollView



- (void)viewDidLoad {
        self.backgroundColor = [UIColor redColor];
        self.scrollEnabled = YES;
        self.pagingEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize = CGSizeMake(super.bounds.size.width * 2, 250);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSLog(@"%f", scrollView.contentOffset.x);
//    
    if (scrollView.contentOffset.x < 0) {
        
        for (CALayer *sub in scrollView.layer.sublayers) {
            sub.transform = CATransform3DMakeRotation(90.0 / 180.0 * M_PI, 0.0, 0.0, 1.0);
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        
        CGPoint touchedPoint = [touch locationInView:self];
       // touchedPoint = [[touch view] convertPoint:touchedPoint toView:nil];
        NSLog(@"%f", touchedPoint.x);
        //touchedPoint.x += self.contentOffset.x;
        CALayer *layer;
        
        for (CALayer *subLayer in self.layer.sublayers) {
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
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        if (self.touchedLayer) {
            
            //sub = layer.modelLayer;
            CGPoint point = [touch locationInView:self];
            //point.x += self.contentOffset.x;
            CGFloat cardHeight = 200;
            CGFloat cardWidth = 160;
            [CATransaction begin];
            [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
            
            if (self.touchedLayer.superlayer == self.layer) {
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


