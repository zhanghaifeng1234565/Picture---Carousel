//
//  CarouselViewController.m
//  Picture - Carousel
//
//  Created by zhanghaifeng on 2017/3/25.
//  Copyright © 2017年 BBSWaitting. All rights reserved.
//

#import "CarouselViewController.h"
#import "CarouselView.h"

#define KWindowW ([UIScreen mainScreen].bounds.size.width-60)

@interface CarouselViewController ()

@property (nonatomic, strong) UIView *carouselView;

@end

@implementation CarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI {
    
    self.carouselView = [[CarouselView alloc] initWithFrame:CGRectMake(30, 30, KWindowW, 200)];
    [self.view addSubview:self.carouselView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
