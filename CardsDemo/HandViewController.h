//
//  HandViewController.h
//  CardsDemo
//
//  Created by Sachin Medhekar on 12/2/14.
//  Copyright (c) 2014 Sachin Medhekar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HandViewController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    NSMutableArray *cards;
    CGFloat startOffset;
}

@end
