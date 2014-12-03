//
//  cardScroll.m
//  CardsDemo
//
//  Created by Sachin Medhekar on 12/3/14.
//  Copyright (c) 2014 Sachin Medhekar. All rights reserved.
//

#import "cardScroll.h"

@implementation cardScroll

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    for (UITouch *touch in touches) {
//    CGPoint location = [touch locationInView:self];
//    CGPoint prevLocation = [touch previousLocationInView:self];
//    if (location.y - prevLocation.y < 0) {
//        self.userInteractionEnabled = NO;
//    }
//    }
    [[self.nextResponder nextResponder] touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    for (UITouch *touch in touches) {
    //    CGPoint location = [touch locationInView:self];
    //    CGPoint prevLocation = [touch previousLocationInView:self];
    //    if (location.y - prevLocation.y < 0) {
    //        self.userInteractionEnabled = NO;
    //    }
    //    }
    [[self.nextResponder nextResponder] touchesEnded:touches withEvent:event];
}

@end
