//
//  ScheduleWeekCell.m
//  AddCalendar
//
//  Created by 赵博 on 2017/12/28.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "ScheduleWeekCell.h"
#import "ZBTool.h"
@interface ScheduleWeekCell()
{
    __weak IBOutlet UILabel *weekLabel;
    
    __weak IBOutlet UILabel *dayLabel;
}
@end

@implementation ScheduleWeekCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier= @"ScheduleWeekCellidentif";
    ScheduleWeekCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ScheduleWeekCell" owner:nil options:nil]firstObject];
    }
    
    return cell;
}
- (void)setWeekStr:(NSString *)weekStr{
    _weekStr = weekStr;
    weekLabel.text = _weekStr;
}
- (void)setDayStr:(NSString *)dayStr{
    _dayStr = dayStr;
    if ([_blueStr isEqualToString:_dayStr]) {
        dayLabel.textColor = [SetHexColor colorWithHexString:@"#3485f7"];
    }else{
        dayLabel.textColor = [SetHexColor colorWithHexString:@"#A2A2A2"];
    }
    NSArray*array = [_dayStr componentsSeparatedByString:@"-"];
    dayLabel.text = array.lastObject;
    dayLabel.font = [UIFont boldSystemFontOfSize:12];
}
- (void)setBlueStr:(NSString *)blueStr{
    _blueStr = blueStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
