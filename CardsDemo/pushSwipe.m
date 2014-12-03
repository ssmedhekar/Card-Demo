//
//  pushSwipe.m
//  CardsDemo
//
//  Created by Sachin Medhekar on 12/3/14.
//  Copyright (c) 2014 Sachin Medhekar. All rights reserved.
//

#import "pushSwipe.h"

@implementation pushSwipe

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
       CGPoint location = [touch locationInView:self.view];
        NSLog(@"%f", location.y);
    }
   // [super touchesMoved:touches withEvent:event];
    
    if ([self.delegate respondsToSelector:@selector(gestureRecognizer:movedWithTouches:andEvent:)]) {
        [(id)self.delegate gestureRecognizer:self movedWithTouches:touches andEvent:event];
    }
    
}

@end
