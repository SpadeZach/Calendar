//
//  RepeatTypesController.h
//  AddCalendar
//
//  Created by 赵博 on 2017/12/26.
//  Copyright © 2017年 个人. All rights reserved.
//
 
#import <UIKit/UIKit.h>
typedef void(^PopRepeatType)(NSString *typeStr);
@interface RepeatTypesController : UIViewController
@property(nonatomic, copy)PopRepeatType block;

@property(nonatomic ,strong) NSString *navTitle;

//数据源
@property (nonatomic, strong) NSArray *titleArry;
/**
 重复类型
 */
@property (nonatomic, assign) NSInteger chooseType;
@end
