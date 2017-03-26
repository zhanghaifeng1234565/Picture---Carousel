//
//  CarouslCollectionViewCell.m
//  Picture - Carousel
//
//  Created by zhanghaifeng on 2017/3/25.
//  Copyright © 2017年 BBSWaitting. All rights reserved.
//

#import "CarouslCollectionViewCell.h"
#import "Masonry.h"

@interface CarouslCollectionViewCell()

@end

@implementation CarouslCollectionViewCell {
    UIImageView *_carouslImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    _carouslImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_carouslImageView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 5;
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.enabled = NO;
    [self.contentView addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    self.pageControl = pageControl;
}

- (void)setUrl:(NSURL *)url {
    _url = url;
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    _carouslImageView.image = image;
}


@end
