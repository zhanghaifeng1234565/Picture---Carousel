//
//  CarouslFlowLayout.m
//  Picture - Carousel
//
//  Created by zhanghaifeng on 2017/3/25.
//  Copyright © 2017年 BBSWaitting. All rights reserved.
//

#import "CarouslFlowLayout.h"

@implementation CarouslFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat itemW = self.collectionView.bounds.size.width;
    CGFloat itemH = self.collectionView.bounds.size.height;
    
    self.itemSize = CGSizeMake(itemW, itemH);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
