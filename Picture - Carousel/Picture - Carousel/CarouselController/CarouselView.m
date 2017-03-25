//
//  CarouselView.m
//  Picture - Carousel
//
//  Created by zhanghaifeng on 2017/3/25.
//  Copyright © 2017年 BBSWaitting. All rights reserved.
//

#import "CarouselView.h"
#import "CarouslFlowLayout.h"
#import "CarouslCollectionViewCell.h"

static NSString *CarouselcollectionViewId = @"CarouselcollectionViewId";

@interface CarouselView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CarouselView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
    
}

- (void)setUpUI {
    
//    self.backgroundColor = [UIColor redColor];
    
    CarouslFlowLayout *flowLayout = [[CarouslFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[CarouslCollectionViewCell class] forCellWithReuseIdentifier:CarouselcollectionViewId];
    
    [self addSubview:self.collectionView];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CarouslCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CarouselcollectionViewId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    return cell;
    
}












@end
