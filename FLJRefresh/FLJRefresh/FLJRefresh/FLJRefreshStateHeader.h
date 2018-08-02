//
//  FLJRefreshStateHeader.h
//  FLJRefresh
//
//  Created by 贾林飞 on 2018/8/1.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FLJRefreshStateNormal,
    FLJRefreshStatePulling,
    FLJRefreshStateRefreshing,
    FLJRefreshStateNoMoreData,
} FLJRefreshState;

@interface FLJRefreshStateHeader : UIView

@property(nonatomic,assign)FLJRefreshState state;

+(instancetype)headerRefreshWithBlock:(void(^)(void))block;


@end
