//
//  PhotosViewViewController.m
//  Pages
//
//  Created by mysoft on 11/20/14.
//  Copyright (c) 2014 mysoft. All rights reserved.
//

#import "PhotosViewViewController.h"
#import "CommomDefind.h"
#import "PhotosViewView.h"

@interface PhotosViewViewController ()<UIScrollViewDelegate>
{

}

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *photosViewArray;
@end

@implementation PhotosViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photosViewArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addGetrueRecognizer];
    [self layoutSubView];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutSubView
{
    if (!self.scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = YES;
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self.view addSubview:self.scrollView];
    }
}

- (void)addGetrueRecognizer
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:tapGesture];
    [self.view addGestureRecognizer:swipeRight];
}

- (void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadData
{
    for (int i = 0; i<self.photoURLArray.count ; i++) {
        PhotosViewView *photoV = [[PhotosViewView alloc] initWithFrame:CGRectMake(0 , kScreenHeight*(self.photoURLArray.count-1) ,kScreenWidth, kScreenHeight)];
        photoV.backgroundColor = [UIColor grayColor];
        photoV.photoURL = [self.photoURLArray objectAtIndex:i];
        if (i>self.photoURLArray.count-10) {
            [photoV loadImage];
        }
        [self minScaleView:photoV scale:0.8];
        [self.scrollView addSubview:photoV];

        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, photoV.frame.size.height*(i+1));
        [self.photosViewArray addObject:photoV];
    }
    [self.scrollView scrollRectToVisible:CGRectMake(0, kScreenHeight*(self.photoURLArray.count-1), kScreenWidth, kScreenHeight) animated:NO];
}

- (void)minScaleView:(PhotosViewView*)photoV scale:(float)scale
{
    //CATransform3DScale
    CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform = CATransform3DMakeScale(scale, scale, scale);  //x,y,z放大缩小倍数
    NSValue *value = [NSValue valueWithCATransform3D:transform];
    [theAnimation setToValue:value];
    
//    transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
//    value = [NSValue valueWithCATransform3D:transform];
//    [theAnimation setFromValue:value];
////
//    [theAnimation setAutoreverses:YES];  //原路返回的动画一遍
//    [theAnimation setDuration:2];
//    [theAnimation setRepeatCount:2];
    
    theAnimation.removedOnCompletion = NO;
    theAnimation.fillMode = kCAFillModeForwards;
    
//    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position.y"];
//    move.byValue = @(-22);
//    move.toValue = @0;
    
    [photoV.layer addAnimation:theAnimation forKey:@"scale"];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint translation = [self.scrollView.panGestureRecognizer translationInView:[self.scrollView superview]];
    CGFloat offset = scrollView.contentOffset.y+scrollView.contentInset.top;
    NSInteger indexPhoto = offset/kScreenHeight;
    PhotosViewView *photoV = [self.photosViewArray objectAtIndex:indexPhoto];
    
    //向下拉
    if (translation.y>0) {
        float scale = 1;
        CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D transform = CATransform3DMakeScale(scale, scale, scale);  //x,y,z放大缩小倍数
        NSValue *value = [NSValue valueWithCATransform3D:transform];
        [theAnimation setToValue:value];
        theAnimation.removedOnCompletion = NO;
        
        [photoV.layer addAnimation:theAnimation forKey:@"scaletrans"];
        
        
        photoV.layer.timeOffset = (offset-kScreenHeight*indexPhoto)/kScreenHeight;
    } else {
        
    }
}


@end
