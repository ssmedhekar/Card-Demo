//
//  newScrollView.h
//  CardsDemo
//
//  Created by Sachin Medhekar on 12/2/14.
//  Copyright (c) 2014 Sachin Medhekar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newScrollView : UIScrollView <UIScrollViewDelegate> {
    
    CALayer *touchedLayer;
    NSMutableArray *cards;
}

-(void)viewDidLoad;

@end
