//
//  pushSwipe.h
//  CardsDemo
//
//  Created by Sachin Medhekar on 12/3/14.
//  Copyright (c) 2014 Sachin Medhekar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pushSwipe : UISwipeGestureRecognizer {
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@protocol DragGestureRecognizerDelegate <UIGestureRecognizerDelegate>
- (void) gestureRecognizer:(UIGestureRecognizer *)gr movedWithTouches:(NSSet*)touches andEvent:(UIEvent *)event;
@end