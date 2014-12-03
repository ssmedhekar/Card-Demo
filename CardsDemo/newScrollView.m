//
//  newScrollView.m
//  CardsDemo
//
//  Created by Sachin Medhekar on 12/2/14.
//  Copyright (c) 2014 Sachin Medhekar. All rights reserved.
//

#import "newScrollView.h"

@implementation newScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)viewDidLoad {
    //scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, 800, 250)];
    self.userInteractionEnabled = true;
    self.scrollEnabled = YES;
    self.pagingEnabled = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.contentSize = CGSizeMake(200*7, 0);
    self.delegate = self;
    
    
    cards = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        //        CALayer *card = [self createCard:<#(CGPoint)#>]
        UIView *card = [[UIView alloc] initWithFrame:CGRectMake(165*i, 0, 160, 200)];
        
        float xPOS = card.frame.origin.x - self.contentOffset.x - self.frame.size.width/2 + card.frame.size.width/2;
        card.frame = CGRectMake(card.frame.origin.x, 0 + fabs(0.05 * xPOS), card.frame.size.width, card.frame.size.height);
        
        //        double rads = DEGREES_TO_RADIANS(30);
        //        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
        //        card.transform = transform;
        
        //        card.translatesAutoresizingMaskIntoConstraints = NO;
        
        [card.layer addSublayer:[self createCard:card.window.frame.origin]];
        
        card.backgroundColor = [UIColor whiteColor];
        [self addSubview:card];
        
        [cards addObject:card];
    }

}

- (CALayer *)createCard:(CGPoint)point {
    
    //CARD DESIGN
    CALayer *cardLayer = [CALayer layer];
    cardLayer.backgroundColor = [UIColor whiteColor].CGColor;
    cardLayer.shadowOffset = CGSizeMake(0, 3);
    cardLayer.shadowColor = [UIColor blackColor].CGColor;
    cardLayer.shadowOpacity = 0.8;
    CGFloat cardHeight = 200;
    CGFloat cardWidth = 160;
    cardLayer.frame = CGRectMake(point.x, point.y, cardWidth, cardHeight);
    
    //PLACE INTO NORMAL VIEW
    //[self.view.layer addSublayer:cardLayer];
    
    
    
    //ADD IMAGE TO CARD
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(cardLayer.bounds.size.width*.05, cardLayer.bounds.size.width*.05, cardLayer.bounds.size.width*.9, cardLayer.bounds.size.width*.9);
    imageLayer.contents = (id) [UIImage imageNamed:@"RishiCropped.jpg"].CGImage;
    imageLayer.masksToBounds = YES;
    [cardLayer addSublayer:imageLayer];
    
    
    //ADD TEXT TO CARD
    CATextLayer *label = [CATextLayer layer];
    [label setFont:@"PermanentMarker"];
    [label setFontSize:14];
    label.contentsScale = [[UIScreen mainScreen] scale];
    label.frame = CGRectMake(cardLayer.bounds.size.width*.07, cardLayer.bounds.size.width*.97, cardLayer.bounds.size.width*.9, cardLayer.bounds.size.width*.1);
    [label setString:@"Rishi Mody"];
    [label setForegroundColor:[[UIColor blackColor] CGColor]];
    [cardLayer addSublayer:label];
    
    return cardLayer;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollViewLol
{
    //    NSLog(@"LOLZ");
    
    //    NSLog(@"%i", cards.count);
    
    //    UIView *card = [cards firstObject];
    //    NSLog(@"%f", -1 * (card.frame.origin.x + scrollViewLol.contentOffset.x));
    
    for (UIView *card in cards)
    {
        //        NSLog(@"LOLZ");
        
        float xPOS = card.frame.origin.x - scrollViewLol.contentOffset.x - self.frame.size.width/2 + card.frame.size.width/2;
        //        NSLog(@"%f", xPOS);
        
        // double rads = DEGREES_TO_RADIANS(90);
        card.frame = CGRectMake(card.frame.origin.x, 0 + fabs(0.05 * xPOS), card.frame.size.width, card.frame.size.height);
        
        //        double rads = DEGREES_TO_RADIANS(scrollView.contentOffset.x - startOffset);
        //        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
        //        card.transform = transform;
        
        //        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
        //        [CATransaction begin];
        //        [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
        //        card.transform = transform;
        //        [CATransaction commit];
        
    }
    //startOffset = scrollView.contentOffset.x;
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        CGPoint touchedPoint = [touch locationInView:self];
        //touchedPoint = [[touch view] convertPoint:touchedPoint toView:nil];
        CALayer *layer;
        
        for (CALayer *subLayer in self.layer.sublayers) {
            NSLog(@"Hi");
            CALayer *temp;
            temp = [subLayer hitTest:touchedPoint];
            if (temp) {
                layer = temp;
            }
        }
        //CALayer *layer = [(CALayer *)self.view.layer.presentationLayer hitTest:touchedPoint];
        if (layer) {
            touchedLayer = layer;
            
        }
        //        else {
        //            [self createCard:touchedPoint];
        //        }
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        if (touchedLayer) {
            
            //sub = layer.modelLayer;
            CGPoint point = [touch locationInView:self];
            CGFloat cardHeight = 200;
            CGFloat cardWidth = 160;
            [CATransaction begin];
            [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
            
            if (touchedLayer.superlayer == self.layer) {
                touchedLayer.frame = CGRectMake(point.x - cardWidth/2, point.y - cardHeight/2, cardWidth, cardHeight);
            }
            else {
                touchedLayer.superlayer.frame = CGRectMake(point.x - cardWidth/2, point.y - cardHeight/2, cardWidth, cardHeight);
            }
            [CATransaction commit];
            
            
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    touchedLayer = nil;
}

@end
