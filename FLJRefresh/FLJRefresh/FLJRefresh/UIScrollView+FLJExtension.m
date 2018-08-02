//
//  UIScrollView+FLJRefreshHeader.m
//  FLJRefresh
//
//  Created by 贾林飞 on 2018/8/1.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "UIScrollView+FLJExtension.h"
#import <objc/runtime.h>

@interface UIScrollView ()



@end


@implementation UIScrollView (FLJExtension)

static const NSString* headerKey = @"FLJRefreshHeaderKey";

-(void)setFljHeader:(FLJRefreshStateHeader *)fljHeader
{
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    objc_setAssociatedObject(self, &headerKey, fljHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self insertSubview:fljHeader atIndex:0];
}

-(FLJRefreshStateHeader *)fljHeader
{
   return objc_getAssociatedObject(self, &headerKey);
}

static const NSString* footerKey = @"FLJRefreshFooterKey";

-(void)setFljFooter:(FLJRefreshStateFooter *)fljFooter
{
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    objc_setAssociatedObject(self, &footerKey, fljFooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self insertSubview:fljFooter atIndex:0];
}

-(FLJRefreshStateFooter *)fljFooter
{
    return objc_getAssociatedObject(self, &footerKey);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.fljHeader.frame =CGRectMake(0, 0, self.bounds.size.width, 64);
    self.fljFooter.frame =CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 64);
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {

        if ([[change valueForKey:NSKeyValueChangeNewKey] isEqual:[change valueForKey:NSKeyValueChangeOldKey]]) {
            return;
        }
        
        if (self.fljHeader.state == FLJRefreshStateRefreshing || self.fljFooter.state == FLJRefreshStateRefreshing) {
            return;
        }
        CGFloat contentOffSet_y = self.contentOffset.y;
        CGFloat contentSize_h = self.contentSize.height;
        __weak typeof(self) weakSelf = self;

        NSLog(@"%.f",contentOffSet_y);
        if (contentOffSet_y >= 0) {
            
            if (contentOffSet_y >= contentSize_h-self.bounds.size.height) {
                if (self.isDragging) {
                    self.fljFooter.state = FLJRefreshStatePulling;
                }else
                {
                    self.fljFooter.state = FLJRefreshStateRefreshing;
                    
                    [UIView animateWithDuration:.25f animations:^{
                        UIEdgeInsets insets = weakSelf.contentInset;
                        insets.bottom += 64;
                        weakSelf.contentInset = insets;
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [UIView animateWithDuration:.25f animations:^{
                            weakSelf.contentInset = UIEdgeInsetsZero;
                        } completion:^(BOOL finished) {
                            self.fljFooter.state = FLJRefreshStateNormal;
                        }];
                    });

                }
            }else
                self.fljFooter.state = FLJRefreshStateNormal;

        }else
        {
            if (contentOffSet_y <= - 64) {
                if (self.isDragging) {
                    self.fljHeader.state = FLJRefreshStatePulling;
                }else
                {
                    self.fljHeader.state = FLJRefreshStateRefreshing;

                    [UIView animateWithDuration:.25f animations:^{
                        UIEdgeInsets insets = weakSelf.contentInset;
                        insets.top = 64;
                        weakSelf.contentInset = insets;
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [UIView animateWithDuration:.25f animations:^{
                            weakSelf.contentInset = UIEdgeInsetsZero;
                        } completion:^(BOOL finished) {
                            self.fljHeader.state = FLJRefreshStateNormal;
                        }];
                    });
                }
            }else
            {
                self.fljHeader.state = FLJRefreshStateNormal;
            }
        }

    }

}
@end
