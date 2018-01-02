//
//  ScheduleMonthController.m
//  AddCalendar
//
//  Created by 赵博 on 2017/12/28.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "ScheduleMonthController.h"
#import "YXCalendarView.h"
#import "ZBTool.h"
@interface ScheduleMonthController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) YXCalendarView *calendar;
@end

@implementation ScheduleMonthController

- (void)viewDidLoad {
    [super viewDidLoad];
    _calendar = [[YXCalendarView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [YXCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month]) Date:[NSDate date] Type:CalendarType_Month];
    
    _calendar.getYear = ^(NSString *yearMonthStr) {
        NSDictionary *dict = @{@"titleKey":yearMonthStr};
        NSNotification *notification =[NSNotification notificationWithName:ScheduleMonthNotification object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    };
    

    __weak __typeof(self) weakSelf = self;
    
    _calendar.sendSelectDate = ^(NSDate *selDate) {
        NSLog(@"%@",[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate]);
        NSLog(@"%@", [weakSelf getOneWeekArr:selDate]);
        NSDictionary *dict = @{@"weekArr":[weakSelf getOneWeekArr:selDate],@"currentDay":[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate]};
        
        NSNotification *notification =[NSNotification notificationWithName:ScheduleWeekNotification object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
    };
       
    [self.view addSubview:_calendar];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _calendar.custom_height, kScreenWidth, self.view.custom_height - 270 - 124) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];

    __weak typeof(_calendar) weakCalendar = _calendar;
    _calendar.refreshH = ^(CGFloat viewH) {
        [UIView animateWithDuration:0.3 animations:^{
            weakCalendar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, viewH);
            tableView.frame = CGRectMake(0, viewH, kScreenWidth, self.view.custom_height - viewH);
        }];
        
    };
}

- (NSMutableArray *)getOneWeekArr:(NSDate *)selDate{
    NSMutableArray *arr = @[].mutableCopy;
    NSString *week = [self weekdayStringFromDate:selDate];
    int j = 0;
    if ([week isEqualToString:@"周日"]) {
        j = 0;
    }else if ([week isEqualToString:@"周六"]){
        j = 6;
    }else if ([week isEqualToString:@"周五"]){
        j = 5;
    }else if ([week isEqualToString:@"周四"]){
        j = 4;
    }else if ([week isEqualToString:@"周三"]){
        j = 3;
    }else if ([week isEqualToString:@"周二"]){
        j = 2;
    }else if ([week isEqualToString:@"周一"]){
        j = 1;
    }
    if (j != 0) {
        for (int i = 1; i < j + 1; i++) {
            [arr addObject:[self getTime:selDate aheadTime:-i]];
        }
        arr = (NSMutableArray *)[[arr reverseObjectEnumerator] allObjects];
    }
    for (int i = 0; i < 7 - j; i++) {
        [arr addObject:[self getTime:selDate aheadTime:i]];
    }
    return arr;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 24;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    bottomView.backgroundColor =[SetHexColor colorWithHexString:@"#f8f8f8"];
    return bottomView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}



///根据用户输入的时间(dateString)确定当天是星期几,输入的时间格式 yyyy-MM-dd ,如 2015-12-18
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}
- (NSString *)getTime:(NSDate *)mydate aheadTime:(NSInteger)aheadTime{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:aheadTime];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    return beforDate;
}

@end
