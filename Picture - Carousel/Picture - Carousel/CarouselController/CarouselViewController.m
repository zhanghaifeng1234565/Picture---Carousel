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

@end

@implementation CarouselViewController {
    NSArray <NSURL *> *_urls;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI {
    
    [self loadCarouslImageData];
    CarouselView *carouslView = [[CarouselView alloc]  initWithURLs:_urls didSelectedIndex:^(NSInteger index) {
        
    }];
    carouslView.frame = CGRectMake(30, 30, KWindowW, 200);
    [self.view addSubview:carouslView];
    
}

#pragma mark - loadData
- (void)loadCarouslImageData {
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"Snip%zd.png", i+1];
        NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
        [arrM addObject:url];
    }
    _urls = arrM.copy;

}


@end
