//
//  CalendarController.m
//  AddCalendar
//
//  Created by 赵博 on 2017/12/28.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "CalendarController.h"
#import "ScheduleMonthController.h"
#import "ScheduleWeekController.h"
#import "ScheduleDayController.h"
#import "ZBTool.h"
@interface CalendarController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) NSString *yearAndMonthStr;
@property (nonatomic, strong) NSString *weekAndDayStr;
@end

@implementation CalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoNotificationAction:) name:ScheduleMonthNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scheduleWeekNotification:) name:ScheduleWeekNotification object:nil];
    self.navigationItem.title = @"日程";
    [self setUpNav];
    [self setupChildViewControllers];
    [self addChildVC];
    
}
- (void)setUpNav{
    /******************  蓝底  ******************/
    UIView *blueView = [[UIView alloc] init];
    blueView.frame = CGRectMake(0, 64, kScreenWidth, 60);
    blueView.backgroundColor = [SetHexColor colorWithHexString:@"#419bf9"];
    [self.view addSubview:blueView];
    /******************  年月  ******************/
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
    int year =(int) [dateComponent year];
    int month = (int) [dateComponent month];
    self.monthYearL = [[UILabel alloc] init];
    self.monthYearL.frame = CGRectMake(22, 22.5, 90, 15);
    self.monthYearL.textAlignment = NSTextAlignmentCenter;
    self.monthYearL.font = [UIFont systemFontOfSize:15];
    self.monthYearL.text = [NSString stringWithFormat:@"%d年%d月",year,month];
    self.monthYearL.textColor = [UIColor whiteColor];
    [blueView addSubview:self.monthYearL];
    NSArray *array = [NSArray arrayWithObjects:@"月",@"周",@"日", nil];
    //初始化UISegmentedControl
    self.segment = [[UISegmentedControl alloc]initWithItems:array];
    //设置frame
    self.segment.frame = CGRectMake(kScreenWidth - 130, 15, 100, 30);
    self.segment.selectedSegmentIndex = 0;
    self.segment.tintColor = [UIColor whiteColor];
    [self.segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    //添加到视图
    [blueView addSubview:self.segment];
    [self.view addSubview:blueView];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 124, kScreenWidth, kScreenHeight - 124);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth *array.count, 0);
    [self.view addSubview:self.scrollView];
   
}
- (void)infoNotificationAction:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    self.yearAndMonthStr = dic[@"titleKey"];
    self.monthYearL.text = self.yearAndMonthStr;
}
- (void)scheduleWeekNotification:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    NSLog(@"~~~~%@",dic);
    NSArray *arry = [dic[@"currentDay"] componentsSeparatedByString:@"-"];
    self.weekAndDayStr = [NSString stringWithFormat:@"%@年%@月",arry[0],arry[1]];
}
- (void)setupChildViewControllers{
    ScheduleMonthController *monthVC = [[ScheduleMonthController alloc] init];
    [self addChildViewController:monthVC];
    ScheduleWeekController *weekVC = [[ScheduleWeekController alloc] init];
    [self addChildViewController:weekVC];
    ScheduleDayController *dayVC = [[ScheduleDayController alloc] init];
    [self addChildViewController:dayVC];
}
- (void)addChildVC{
    for (int i = 0; i < 3; i++) {
        //取出子控制器
        UIViewController *childVC = self.childViewControllers[i];
        if (childVC.view.superview) {
            return;
        }
        childVC.view.frame = CGRectMake(kScreenWidth * i, 0, self.scrollView.custom_width, self.scrollView.custom_height);
        [self.scrollView addSubview:childVC.view];
    }
    
}

-(void)change:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
        if (self.yearAndMonthStr == nil) {
            NSDate *nowDate = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
            int year =(int) [dateComponent year];
            int month = (int) [dateComponent month];
            self.monthYearL.text = [NSString stringWithFormat:@"%d年%d月",year,month];
        }else{
            self.monthYearL.text = self.yearAndMonthStr;
        }
        
        
    }else if (sender.selectedSegmentIndex == 1){
        self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
        if (self.weekAndDayStr == nil) {
            NSDate *nowDate = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
            int year =(int) [dateComponent year];
            int month = (int) [dateComponent month];
            self.monthYearL.text = [NSString stringWithFormat:@"%d年%d月",year,month];
        }else{
            self.monthYearL.text = self.weekAndDayStr;
        }
        
    }else if (sender.selectedSegmentIndex == 2){
        self.scrollView.contentOffset = CGPointMake(kScreenWidth * 2, 0);
        if (self.weekAndDayStr == nil) {
            NSDate *nowDate = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
            int year =(int) [dateComponent year];
            int month = (int) [dateComponent month];
            self.monthYearL.text = [NSString stringWithFormat:@"%d年%d月",year,month];
        }else{
            self.monthYearL.text = self.weekAndDayStr;
        }
    }
}

@end
