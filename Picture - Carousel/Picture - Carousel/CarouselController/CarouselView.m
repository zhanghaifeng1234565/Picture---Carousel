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
#import "Masonry.h"

static NSString *CarouselcollectionViewId = @"CarouselcollectionViewId";

#define KSectionCount 100

@interface CarouselView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) void (^selectedCallBack)(NSInteger index);
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation CarouselView {
    NSArray <NSURL *> *_urls;
}

- (instancetype)initWithURLs:(NSArray<NSURL *> *)urls didSelectedIndex:(void (^)(NSInteger index))selectedIndex {
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[CarouslFlowLayout alloc] init]];
    if (self) {
        
        [self addTimer];
        _urls = urls;
        _selectedCallBack = selectedIndex;
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[CarouslCollectionViewCell class] forCellWithReuseIdentifier:CarouselcollectionViewId];
        
        if (_urls.count > 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
                [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
                
            });
        }
    }
    return self;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _urls.count * (_urls.count == 1 ? 1:100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CarouslCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CarouselcollectionViewId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    cell.url = _urls[indexPath.item % _urls.count];
    self.pageControl = cell.pageControl;
    
    return cell;
    
}

#pragma mark - <<UICollectionViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (offset == 0 || offset == ([self numberOfItemsInSection:0] - 1)) {
        offset = _urls.count - (offset == 1 ? 0 : 1);
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_selectedCallBack != nil) {
        _selectedCallBack(indexPath.item % _urls.count);
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.timer.fireDate = [NSDate distantFuture];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    [self scrollViewDidEndDecelerating:scrollView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger page = (scrollView.contentOffset.x / scrollView.bounds.size.width) + 0.499;
    NSInteger pageNO = page % _urls.count;
    self.pageControl.currentPage = pageNO;
    
}

#pragma mark - <timer>
- (void)addTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)nextPage {
    
    NSInteger page = self.pageControl.currentPage;
    NSIndexPath *scrollToPath = nil;
    if (page == _urls.count - 1) {
        scrollToPath = [NSIndexPath indexPathForItem:0 inSection:0];
    } else {
        scrollToPath = [NSIndexPath indexPathForItem:page + 1 inSection:0];
    }
    
    [self scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}


@end
