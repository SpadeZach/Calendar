//
//  EditSchedulePickerCell.m
//  AddCalendar
//
//  Created by 赵博 on 2017/12/25.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "EditSchedulePickerCell.h"
#import "ZBTool.h"
@interface EditSchedulePickerCell()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *yearArr;
    NSMutableArray *monthArr;
    NSMutableArray *dayArr;
    NSMutableArray *hourArr;
    NSMutableArray *secondArr;
    NSMutableArray *bigArr;
}
@property(nonatomic, strong) UIPickerView *pickerView;
@end
@implementation EditSchedulePickerCell
- (instancetype)init{
    self = [super init];
    if (self) {
        yearArr = @[@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023"].mutableCopy;
        monthArr = @[].mutableCopy;
        for (int i = 0; i < 12; i++) {
            [monthArr addObject:[NSString stringWithFormat:@"%d月",i+1]];
        }
        
        dayArr = @[].mutableCopy;
        for (int i = 0; i < 31; i++) {
            [dayArr addObject:[NSString stringWithFormat:@"%d日",i+1]];
        }
        hourArr = @[].mutableCopy;
        for (int i = 0; i < 24; i++) {
            [hourArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        secondArr = @[].mutableCopy;
        for (int i = 0; i < 12; i++) {
            if (i * 5  < 10) {
                [secondArr addObject:[NSString stringWithFormat:@"0%d",i * 5]];
            }else{
                [secondArr addObject:[NSString stringWithFormat:@"%d",i * 5]];
            }
            
        }
        
        bigArr = @[].mutableCopy;
        [bigArr addObject:yearArr];
        [bigArr addObject:monthArr];
        [bigArr addObject:dayArr];
        [bigArr addObject:hourArr];
        [bigArr addObject:secondArr];
        
        [self.contentView addSubview:self.pickerView];
        NSDate *nowDate = [NSDate date];
        
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
        int year =(int) [dateComponent year];
        int month = (int) [dateComponent month];
        int day = (int) [dateComponent day];
        int hour = (int) [dateComponent hour];
        
        NSInteger yearIndex = [yearArr indexOfObject:[NSString stringWithFormat:@"%d",year]];
        NSInteger monthIndex = [monthArr indexOfObject:[NSString stringWithFormat:@"%d月",month]];
        NSInteger dayIndex = [dayArr indexOfObject:[NSString stringWithFormat:@"%d日",day]];
        NSInteger hourIndex = [hourArr indexOfObject:[NSString stringWithFormat:@"%d",hour]];
        [self.pickerView selectRow:yearIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:monthIndex inComponent:1 animated:YES];
        [self.pickerView selectRow:dayIndex inComponent:2 animated:YES];
        [self.pickerView selectRow:hourIndex inComponent:3 animated:YES];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        yearArr = @[@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023"].mutableCopy;
        monthArr = @[].mutableCopy;
        for (int i = 0; i < 12; i++) {
           [monthArr addObject:[NSString stringWithFormat:@"%d月",i+1]];
        }
       
        dayArr = @[].mutableCopy;
        for (int i = 0; i < 31; i++) {
            [dayArr addObject:[NSString stringWithFormat:@"%d日",i+1]];
        }
        hourArr = @[].mutableCopy;
        for (int i = 0; i < 24; i++) {
            [hourArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        secondArr = @[].mutableCopy;
        for (int i = 0; i < 12; i++) {
            if (i * 5  < 10) {
                [secondArr addObject:[NSString stringWithFormat:@"0%d",i * 5]];
            }else{
                [secondArr addObject:[NSString stringWithFormat:@"%d",i * 5]];
            }
            
        }
        
        bigArr = @[].mutableCopy;
        [bigArr addObject:yearArr];
        [bigArr addObject:monthArr];
        [bigArr addObject:dayArr];
        [bigArr addObject:hourArr];
        [bigArr addObject:secondArr];
   
        [self.contentView addSubview:self.pickerView];
        NSDate *nowDate = [NSDate date];
        
 
        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
        int year =(int) [dateComponent year];
        int month = (int) [dateComponent month];
        int day = (int) [dateComponent day];
        int hour = (int) [dateComponent hour];
        
        NSInteger yearIndex = [yearArr indexOfObject:[NSString stringWithFormat:@"%d",year]];
        NSInteger monthIndex = [monthArr indexOfObject:[NSString stringWithFormat:@"%d月",month]];
        NSInteger dayIndex = [dayArr indexOfObject:[NSString stringWithFormat:@"%d日",day]];
        NSInteger hourIndex = [hourArr indexOfObject:[NSString stringWithFormat:@"%d",hour]];
        [self.pickerView selectRow:yearIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:monthIndex inComponent:1 animated:YES];
        [self.pickerView selectRow:dayIndex inComponent:2 animated:YES];
        [self.pickerView selectRow:hourIndex inComponent:3 animated:YES];
        
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 5;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSMutableArray *numArr = bigArr[component];
    return numArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSMutableArray *numArr = bigArr[component];
    return numArr[row];

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    NSInteger rowTwo = [pickerView selectedRowInComponent:1];
    NSInteger rowThree = [pickerView selectedRowInComponent:2];
    NSInteger rowFour = [pickerView selectedRowInComponent:3];
    NSInteger rowFive = [pickerView selectedRowInComponent:4];
    
    NSString *hourStr = hourArr[rowFour];
    if ([hourStr integerValue] < 10) {
        hourStr = [NSString stringWithFormat:@"0%@",hourStr];
    }
    
    NSString *chooseStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",yearArr[rowOne],monthArr[rowTwo],dayArr[rowThree],hourStr,secondArr[rowFive]];
    chooseStr = [chooseStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
    chooseStr = [chooseStr stringByReplacingOccurrencesOfString:@"月" withString:@""];
    [self.delegate reloadPickerViewDates:chooseStr];
    
    
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView  = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 120)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
@end
