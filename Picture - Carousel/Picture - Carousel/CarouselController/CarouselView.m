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

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, copy) void (^selectedCallBack)(NSIndexPath *index);
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation CarouselView {
    NSArray <NSURL *> *_urls;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self setupCollectionView];
    [self setupPageControl];
    [self addTimer];
    
}


- (void)dataWithURLs:(NSArray<NSURL *> *)urls didSelectedIndex:(void (^)(NSIndexPath *index))selectedIndex {
    _urls = urls;
    _selectedCallBack = selectedIndex;
    
    [self.collectionView reloadData];
    _pageControl.numberOfPages = _urls.count;
    
    [self layoutIfNeeded];
    
    if (_urls.count > 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _urls.count * (_urls.count == 1 ? 1:100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CarouslCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CarouselcollectionViewId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    cell.url = _urls[indexPath.item % _urls.count];
    
    self.indexPath = indexPath;
    
    return cell;
    
}

#pragma mark - <<UICollectionViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (offset == 0 || offset == ([self.collectionView numberOfItemsInSection:0] - 1)) {
        offset = _urls.count - (offset == 1 ? 0 : 1);
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_selectedCallBack != nil) {
        _selectedCallBack(indexPath);
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.timer.fireDate = [NSDate distantFuture];
//    NSLog(@"scrollViewWillBeginDragging-%zd", self.pageControl.currentPage);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
//    NSLog(@"scrollViewDidEndDragging-%zd", self.pageControl.currentPage);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (offset == 0 || offset == ([self.collectionView numberOfItemsInSection:0] - 1)) {
        offset = _urls.count - (offset == 1 ? 0 : 1);
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
    self.pageControl.currentPage = offset % _urls.count;
    [self.pageControl updateCurrentPageDisplay];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger offset = (scrollView.contentOffset.x / scrollView.bounds.size.width) + 0.499;
//    NSLog(@"scrollViewDidScroll-offset-%zd", offset);
    NSInteger pageNO = offset % _urls.count;
    self.pageControl.currentPage = pageNO;
//    NSLog(@"scrollViewDidScroll-currentPage-%zd", self.pageControl.currentPage);
    
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
        scrollToPath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
    } else {
        scrollToPath = [NSIndexPath indexPathForItem:_urls.count + page + 1 inSection:0];
    }
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//    NSLog(@"nextPage-%zd", self.pageControl.currentPage);
}

- (void)setupCollectionView {
    
    CarouslFlowLayout *layout = [[CarouslFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor yellowColor];
    [self addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[CarouslCollectionViewCell class] forCellWithReuseIdentifier:CarouselcollectionViewId];
    
    self.collectionView = collectionView;
}

- (void)setupPageControl {
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [self addSubview:pageControl];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(10);
    }];
    pageControl.enabled = NO;
    self.pageControl = pageControl;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self.timer invalidate];
}

#pragma mark - 测试代码, 检验 timer 是否销毁
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self removeFromSuperview];
//}

- (void)dealloc {
    NSLog(@"我要走了我是 - %@", self.timer);
}

@end
