//
//  UIView+CustomSize.m
//  百思
//
//  Created by 赵博 on 16/7/14.
//  Copyright © 2016年 赵博. All rights reserved.
//

#import "UIView+CustomSize.h"

@implementation UIView (CustomSize)

- (CGFloat)custom_width{
    return self.frame.size.width;
}
- (CGFloat)custom_height{
    return self.frame.size.height;
}
- (CGFloat)custom_x{
    return self.frame.origin.x;
}
- (CGFloat)custom_y{
    return self.frame.origin.y;;
}
- (CGFloat)custom_CenterX{
    return self.center.x;
}
- (CGFloat)custom_CenterY{
    return self.center.y;
}
- (CGSize)custom_size{
    return  self.frame.size;
}
- (CGFloat)custom_botton{
    return self.frame.size.height + self.frame.origin.y;
}
- (CGFloat)custom_right{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setCustom_width:(CGFloat)custom_width{
    CGRect frame = self.frame;
    frame.size.width = custom_width;
    self.frame = frame;
}
- (void)setCustom_height:(CGFloat)custom_height{
    CGRect frame = self.frame;
    frame.size.height = custom_height;
    self.frame = frame;
}
- (void)setCustom_x:(CGFloat)custom_x{
    CGRect frame = self.frame;
    frame.origin.x = custom_x;
    self.frame = frame;
}
- (void)setCustom_y:(CGFloat)custom_y{
    CGRect frame = self.frame;
    frame.origin.y = custom_y;
    self.frame = frame;
}
- (void)setCustom_CenterX:(CGFloat)custom_CenterX{
    CGPoint center = self.center;
    center.x = custom_CenterX;
    self.center = center;
}

- (void)setCustom_CenterY:(CGFloat)custom_CenterY{
    CGPoint center = self.center;
    center.y  = custom_CenterY;
    self.center = center;
}
- (void)setCustom_size:(CGSize)custom_size{
    CGRect frame = self.frame;
    frame.size = custom_size;
    self.frame = frame;
}
- (void)setCustom_botton:(CGFloat)custom_botton{
    CGFloat frame = self.frame.origin.y + self.frame.size.height;
    frame = custom_botton;
    custom_botton = frame;
}
- (void)setCustom_right:(CGFloat)custom_right{
    CGFloat frame = self.frame.origin.x + self.frame.size.width;
    frame = custom_right;
    custom_right = frame;
}
@end
