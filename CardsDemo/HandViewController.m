//
//  HandViewController.m
//  CardsDemo
//
//  Created by Sachin Medhekar on 12/2/14.
//  Copyright (c) 2014 Sachin Medhekar. All rights reserved.
//

#import "HandViewController.h"
#define DEGREES_TO_RADIANS(x) ((x) * M_PI / 180.0)

@interface HandViewController ()

@end

@implementation HandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, 800, 250)];
    scrollView.userInteractionEnabled = true;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(200*7, 0);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    startOffset = 0;
//    scrollView.translatesAutoresizingMaskIntoConstraints = YES;
    
    
    
    cards = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
//        CALayer *card = [self createCard:<#(CGPoint)#>]
        UIView *card = [[UIView alloc] initWithFrame:CGRectMake(165*i, 0, 160, 200)];
        
        float xPOS = card.frame.origin.x - scrollView.contentOffset.x - self.view.frame.size.width/2 + card.frame.size.width/2;
        card.frame = CGRectMake(card.frame.origin.x, 0 + fabs(0.05 * xPOS), card.frame.size.width, card.frame.size.height);
        
//        double rads = DEGREES_TO_RADIANS(30);
//        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
//        card.transform = transform;
        
//        card.translatesAutoresizingMaskIntoConstraints = NO;
        
        [card.layer addSublayer:[self createCard:card.window.frame.origin]];
        
        card.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:card];
        
        [cards addObject:card];
    }
    
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
        
        float xPOS = card.frame.origin.x - scrollViewLol.contentOffset.x - self.view.frame.size.width/2 + card.frame.size.width/2;
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
    startOffset = scrollView.contentOffset.x;
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    startOffset = scrollView.contentOffset.x;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"hello");
    UITouch *lastTouch = nil;
    for (UITouch *touch in touches) {
        if (lastTouch != nil) {
            CGPoint touchedPoint = [touch locationInView:self.view];
            CGPoint lastTouchedPoint = [lastTouch locationInView:self.view];
            CGFloat change = touchedPoint.x - lastTouchedPoint.x;
            
            for (UIView *card in cards)
            {
                double rads = DEGREES_TO_RADIANS(change);
                CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
                card.transform = transform;
                NSLog(@"hello");
            }
        }
        
        lastTouch = touch;
        NSLog(@"bye");
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
