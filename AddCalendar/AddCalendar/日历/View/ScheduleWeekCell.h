//
//  ScheduleWeekCell.h
//  AddCalendar
//
//  Created by 赵博 on 2017/12/28.
//  Copyright © 2017年 个人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleWeekCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic, strong) NSString *weekStr;
@property(nonatomic, strong) NSString *dayStr;
@property(nonatomic, strong) NSString *blueStr;
@end
