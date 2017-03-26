//
//  CarouselView.h
//  Picture - Carousel
//
//  Created by zhanghaifeng on 2017/3/25.
//  Copyright © 2017年 BBSWaitting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselView : UIView

/// 提供接口让外界传入 URL, 通过 Block 回调选中的索引
- (void)dataWithURLs:(NSArray <NSURL *> *)urls didSelectedIndex:(void (^)(NSIndexPath *index))selectedIndex;

@end
