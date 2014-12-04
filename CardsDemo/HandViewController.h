//
//  HandViewController.h
//  CardsDemo
//
//  Created by Sachin Medhekar on 12/2/14.
//  Copyright (c) 2014 Sachin Medhekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cardScroll.h"

@interface HandViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    cardScroll *scrollView;
    NSMutableArray *cards;
    CGFloat startOffset;
    CALayer *touchedLayer;
    float angles[5];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;

@end
