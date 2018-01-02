//
//  SecheduleModel.h
//  AddCalendar
//
//  Created by 赵博 on 2017/12/26.
//  Copyright © 2017年 个人. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecheduleModel : NSObject

/**
 主题
 */
@property(nonatomic, strong)NSString *theme;

/**
 开始时间 yyyy-mm-dd hh:MM
 */
@property(nonatomic, strong)NSString *beginTime;
/**
 结束时间 yyyy-mm-dd hh:MM
 */
@property(nonatomic, strong)NSString *endTime;

/**
 全天 0  1
 */
@property(nonatomic, strong)NSString *isAllDay;

/**
 重复类型   0.每天  1.每周 2.每月 3.每年
 */
@property(nonatomic, strong)NSString *repeatType;

/**
 结束条件
 */
@property(nonatomic, strong)NSString *repeatEnd;

/**
 定时提醒
 */
@property(nonatomic, strong)NSString *reminded;

/**
 事件类型
 */
@property(nonatomic, strong)NSString *eventType;

/**
 日程内容
 */
@property(nonatomic, strong)NSString *content;
/**
 参与人员
 */
@property(nonatomic, strong)NSString *participants;
/**
 参与人员
 */
@property(nonatomic, strong)NSString *executor;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
