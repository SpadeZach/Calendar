//
//  EditScheduleController.h
//  AddCalendar
//
//  Created by 赵博 on 2017/12/25.
//  Copyright © 2017年 个人. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, TableSectionName)   {
    Title,              //主题
    Time,               //时间
    Repeat,             //重复
    Participants,       //参与人员
    Executor            //执行人
    
};
@class SecheduleModel;
@interface EditScheduleController : UIViewController
@property(nonatomic, strong)SecheduleModel *sechedModel;
@end
