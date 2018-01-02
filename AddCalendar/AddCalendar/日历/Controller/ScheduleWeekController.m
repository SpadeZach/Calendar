//
//  ScheduleWeekController.m
//  AddCalendar
//
//  Created by 赵博 on 2017/12/28.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "ScheduleWeekController.h"
#import "ZBTool.h"
#import "ScheduleWeekCell.h"
#import "YXDateHelpObject.h"
@interface ScheduleWeekController ()<UITableViewDataSource,UITableViewDelegate>
//周数组
@property(nonatomic, strong) NSMutableArray *weekArr;
//当前选中时间
@property(nonatomic, strong) NSString *blueStr;
//标记选中时间
@property(nonatomic, assign) NSInteger blueRow;
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation ScheduleWeekController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoNotificationAction:) name:ScheduleWeekNotification object:nil];
     self.weekArr = [self getOneWeekArr:[NSDate date]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 124) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.view addSubview:self.tableView];


}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleWeekCell *cell = [ScheduleWeekCell cellWithTableView:tableView];
    cell.weekStr = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"][indexPath.row];
    if (self.blueStr == nil) {
        self.blueStr = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:[NSDate date]];
    }
    cell.blueStr =self.blueStr;
    cell.dayStr = self.weekArr[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (void)infoNotificationAction:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
//    NSLog(@"%@",dic);
    self.weekArr = dic[@"weekArr"];
    self.blueStr = dic[@"currentDay"];
    [self.tableView reloadData];
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
