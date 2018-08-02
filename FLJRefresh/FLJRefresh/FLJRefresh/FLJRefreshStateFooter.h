//
//  FLJRefreshStateFooter.h
//  FLJRefresh
//
//  Created by 贾林飞 on 2018/8/1.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLJRefreshStateHeader.h"

@interface FLJRefreshStateFooter : UIView

@property(nonatomic,assign)FLJRefreshState state;

+(instancetype)footerRefreshWithBlock:(void(^)(void))block;

@end
