//
//  UIScrollView+FLJRefreshHeader.h
//  FLJRefresh
//
//  Created by 贾林飞 on 2018/8/1.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLJRefreshStateHeader.h"
#import "FLJRefreshStateFooter.h"

@interface UIScrollView (FLJExtension)

@property(nonatomic,strong)FLJRefreshStateHeader* fljHeader;

@property(nonatomic,strong)FLJRefreshStateFooter* fljFooter;

@end
