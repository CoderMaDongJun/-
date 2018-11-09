//
//  DDView.m
//  转场动画Demo
//
//  Created by 马栋军 on 2018/8/30.
//  Copyright © 2018年 DangDangWang. All rights reserved.
//

#import "DDView.h"

@implementation DDView

+ (instancetype)shareDDView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
