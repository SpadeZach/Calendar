//
//  YXDayCell.m
//  Calendar
//
//  Created by Vergil on 2017/7/6.
//  Copyright © 2017年 Vergil. All rights reserved.
//

#import "YXDayCell.h"

@interface YXDayCell ()

@property (weak, nonatomic) IBOutlet UILabel *dayL;     //日期
@property (weak, nonatomic) IBOutlet UIView *pointV;    //点

@end

@implementation YXDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _dayL.layer.cornerRadius = dayCellH / 2;
    _pointV.layer.cornerRadius = 1.5;
    
}

//MARK: - setmethod

- (void)setCellDate:(NSDate *)cellDate {
    _cellDate = cellDate;
    if (_type == CalendarType_Week) {
        [self showDateFunction];
    } else {
        if ([[YXDateHelpObject manager] checkSameMonth:_cellDate AnotherMonth:_currentDate]) {
            [self showDateFunction];
        } else {
            [self showDateFunction];
//            [self showSpaceFunction];
        }
    }
    
}

//MARK: - otherMethod

- (void)showSpaceFunction {
    self.userInteractionEnabled = NO;
    _dayL.text = @"";
    _dayL.backgroundColor = [UIColor clearColor];
    _dayL.layer.borderWidth = 0;
    _dayL.layer.borderColor = [UIColor clearColor].CGColor;
    _pointV.hidden = YES;
}

- (void)showDateFunction {
    
    self.userInteractionEnabled = YES;
    
    _dayL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"d" Date:_cellDate];
//    if ([[YXDateHelpObject manager] isSameDate:_cellDate AnotherDate:[NSDate date]]) {
//        _dayL.layer.borderWidth = 1.5;
//        _dayL.layer.borderColor = [UIColor blueColor].CGColor;
//        //        _dayL.textColor =
//
//    } else {
//        _dayL.layer.borderWidth = 0;
//        _dayL.layer.borderColor = [UIColor clearColor].CGColor;
//    }
    
    if (_selectDate) {
        
        if ([[YXDateHelpObject manager] isSameDate:_cellDate AnotherDate:_selectDate]) {
            _dayL.backgroundColor = [UIColor colorWithRed:52 / 255.0 green:133 / 255.0 blue:247.0f alpha:1];
            _dayL.textColor = [UIColor whiteColor];
            _pointV.backgroundColor = [UIColor clearColor];
        } else {
            if ([[YXDateHelpObject manager] isSameDate:_cellDate AnotherDate:[NSDate date]]) {
                 _dayL.textColor = [UIColor colorWithRed:52 / 255.0 green:133 / 255.0 blue:247.0f alpha:1];;
            }else{
                
                if ([self isSameMonth]) {
                    _dayL.textColor = [UIColor blackColor];
                }else{
                    _dayL.textColor = [UIColor lightGrayColor];
                }
                
                
            }
            _dayL.backgroundColor = [UIColor clearColor];
            _pointV.backgroundColor = [UIColor clearColor];
        }
        
    }
    
    NSString *currentDate = [[YXDateHelpObject manager] getStrFromDateFormat:@"MM-dd" Date:_cellDate];
    _pointV.hidden = YES;
    if (_eventArray.count) {
        for (NSString *strDate in _eventArray) {
            if ([strDate isEqualToString:currentDate]) {
                _pointV.hidden = NO;
            }
        }
    }
    
}
//是否在同一月
- (BOOL)isSameMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear ;
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:_currentDate];
    //2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:_cellDate];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month);
}

@end
