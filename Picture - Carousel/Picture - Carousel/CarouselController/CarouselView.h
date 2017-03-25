//
//  CarouselView.h
//  Picture - Carousel
//
//  Created by zhanghaifeng on 2017/3/25.
//  Copyright © 2017年 BBSWaitting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselView : UICollectionView

/// 重写初始化方法
- (instancetype)initWithURLs:(NSArray <NSURL *> *)urls didSelectedIndex:(void (^)(NSInteger index))selectedIndex;

@end
