//
//  FLJRefreshStateHeader.m
//  FLJRefresh
//
//  Created by 贾林飞 on 2018/8/1.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJRefreshStateHeader.h"

@interface FLJRefreshStateHeader ()

@property(nonatomic,strong)UILabel* label;

@property(nonatomic,strong)UIActivityIndicatorView* indicatorView;

@end

@implementation FLJRefreshStateHeader

+(instancetype)headerRefreshWithBlock:(void (^)(void))block
{
    FLJRefreshStateHeader* headerView = [[FLJRefreshStateHeader alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 64);
    UILabel* label = [[UILabel alloc] init];
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"下拉刷新";
    label.frame = headerView.bounds;
    headerView.label = label;
    
    UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
    indicatorView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    headerView.indicatorView = indicatorView;
    indicatorView.hidden = YES;
    
    [headerView addSubview:indicatorView];
    [headerView addSubview:label];
    return headerView;
}

-(void)setState:(FLJRefreshState)state
{
    _state = state;
    self.indicatorView.hidden = YES;
    if (self.indicatorView.isAnimating) {
        [self.indicatorView stopAnimating];
    }

    switch (state) {
        case FLJRefreshStateNormal:
            self.label.text = @"下拉刷新";
            break;
        case FLJRefreshStatePulling:
            self.label.text = @"松开刷新";
            break;
        case FLJRefreshStateRefreshing:
            self.label.text = @"正在刷新...";
            self.indicatorView.hidden = NO;
            [self.indicatorView startAnimating];
            break;
        case FLJRefreshStateNoMoreData:
            self.label.text = @"没有更多";

            break;

        default:
            break;
    }
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    self.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 64);
//    self.label.frame = self.bounds;
//}
@end
