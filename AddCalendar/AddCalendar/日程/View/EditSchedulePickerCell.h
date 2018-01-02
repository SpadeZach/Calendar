//
//  EditSchedulePickerCell.h
//  AddCalendar
//
//  Created by 赵博 on 2017/12/25.
//  Copyright © 2017年 个人. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditSchedulePickerCellDelegate <NSObject>

- (void)reloadPickerViewDates:(NSString *)dateStr;

@end

@interface EditSchedulePickerCell : UITableViewCell
@property(nonatomic, assign)id<EditSchedulePickerCellDelegate>delegate;
@end
