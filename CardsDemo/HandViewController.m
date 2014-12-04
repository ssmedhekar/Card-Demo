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

@property CGPoint mTouchPoint;
@property NSInteger mFingerCount;
@property UIView *temp;
@property CGRect originalFrame;
@property int originalZ;
@property float xTouchOffset;
@property float yTouchOffset;


@end

@implementation HandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.temp = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    scrollView = [[cardScroll alloc] initWithFrame:CGRectMake(0, 0, 890, 600)];
    scrollView.userInteractionEnabled = true;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(200*7, 0);
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    [self.view addSubview:scrollView];
    [scrollView setDelegate:self];
    
    startOffset = 0;
//    scrollView.translatesAutoresizingMaskIntoConstraints = YES;
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 420, 800, 600)];
    view.backgroundColor =[UIColor redColor];
    view.alpha = .5;
    [self.view addSubview:view];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 200)];
    topView.backgroundColor =[UIColor redColor];
    topView.alpha = .5;
    [self.view addSubview:topView];
    
    
    
    cards = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        UIView *card = [[UIView alloc] initWithFrame:CGRectMake(165*i, 200, 160, 200)];
        
        float xPOS = card.frame.origin.x - scrollView.contentOffset.x - self.view.frame.size.width/2 + card.frame.size.width/2;
        card.frame = CGRectMake(card.frame.origin.x, 200 + fabs(0.05 * xPOS), card.frame.size.width, card.frame.size.height);
        
//        double rads = DEGREES_TO_RADIANS(30);
//        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
//        card.transform = transform;
        
//        card.translatesAutoresizingMaskIntoConstraints = NO;
        
        [card.layer addSublayer:[self createCard:card.window.frame.origin]];
        
        card.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:card];
        
        [cards addObject:card];
    }
    
//    UISwipeGestureRecognizer *singleTap = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureCaptured:)];
//    [scrollView addGestureRecognizer:singleTap];
    
//    UISwipeGestureRecognizer *recognizer;
//    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
//    [scrollView addGestureRecognizer:recognizer];
//    [recognizer setDelegate:self];
//    //recognizer.cancelsTouchesInView = NO;
//    
}

- (void) gestureRecognizer:(UIGestureRecognizer *)gr movedWithTouches:(NSSet*)touches andEvent:(UIEvent *)event{
    

    UITouch * touch = [touches anyObject];
    self.mTouchPoint = [touch locationInView:self.view];
    self.mFingerCount = [touches count];
    
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    
    NSLog(@"Swipe received.");
    NSUInteger index = [recognizer  numberOfTouches];
    NSLog(@"%lu", (unsigned long)index);
    for (NSUInteger i = 0; i < index; i++) {
        CGPoint touchPoint = [recognizer locationOfTouch:i inView:scrollView];
        NSLog(@"%f", touchPoint.x);
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            CGPoint location = [recognizer locationInView: scrollView];
            
            NSLog(@"Point: %f", location.y);
            
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"Ended");
            
            break;
        }
            
        default:
            break;
    }
    
    
    
    //CGPoint touchPoint=[recognizer locationInView:scrollView];
    
}

- (void)swipeGestureCaptured:(UITapGestureRecognizer *)gesture
{
    CGPoint touchPoint=[gesture locationInView:scrollView];
    NSLog(@"%f", touchPoint.x);
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
 //   for (UITouch *touch in touches) {
        //CGPoint touchedPoint = [touch locationInView:self.view];
//        if (touchedPoint.x > 160)
//        {
//            scrollView.userInteractionEnabled = YES;
//        }
//        else
//        {
//            scrollView.userInteractionEnabled = NO;
//        }
//    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
//        CGPoint touchedPoint = [touch locationInView:self.view];
//        NSLog(@"%f", touchedPoint.x);
//        NSLog(@"hello");
        
//        if (touchedPoint.x > 160)
//        {
//            scrollView.userInteractionEnabled = YES;
//        }
//        else
//        {
//            scrollView.userInteractionEnabled = NO;
//        }
        
        CGPoint location = [touch locationInView:scrollView];
        CGPoint prevLocation = [touch previousLocationInView:scrollView];
        if (location.y - prevLocation.y < 0) {
            scrollView.scrollEnabled = NO;
        }
        
        if(scrollView.scrollEnabled == NO) {
            if (self.temp == nil) {
                
                for (UIView *card in cards) {
                    
                   // temp = [card hitTest:location withEvent:event];
                    if (CGRectContainsPoint(card.frame, location)) {
                        self.temp = card;
                        self.originalFrame = self.temp.frame;
                        self.originalZ = self.temp.layer.zPosition;
                        self.temp.layer.zPosition = 100;
                        self.yTouchOffset = self.temp.frame.origin.y - location.y;
                        self.xTouchOffset = self.temp.frame.origin.x - location.x;
                    }
                    
                }
            }
            if (self.temp) {
                CGFloat cardHeight = 200;
                CGFloat cardWidth = 160;
                [CATransaction begin];
                [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
                self.temp.frame = CGRectMake(location.x + self.xTouchOffset, location.y +self.yTouchOffset, 160, 200);
                [CATransaction commit];
            }
        }
        
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    scrollView.scrollEnabled = YES;
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    //[UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.temp.frame = self.originalFrame;
    [UIView commitAnimations];
    self.temp.layer.zPosition = self.originalZ;
    self.temp = nil;
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
        card.frame = CGRectMake(card.frame.origin.x, 200 + fabs(0.05 * xPOS), card.frame.size.width, card.frame.size.height);
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
