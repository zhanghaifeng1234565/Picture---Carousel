//
//  CarouslCollectionViewCell.h
//  Picture - Carousel
//
//  Created by zhanghaifeng on 2017/3/25.
//  Copyright © 2017年 BBSWaitting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouslCollectionViewCell : UICollectionViewCell

/**
 接收图片数据的 url
 */
@property (nonatomic) NSURL *url;

@property (nonatomic, weak) UIPageControl *pageControl;

@end
