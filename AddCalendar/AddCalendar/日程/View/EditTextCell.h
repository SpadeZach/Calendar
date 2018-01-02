//
//  EditTextCell.h
//  AddCalendar
//
//  Created by 赵博 on 2017/12/25.
//  Copyright © 2017年 个人. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditTextCellDelegate <NSObject>
//插入重复组
- (void)insertRepeatGroup;
//删除重复组
- (void)deletRepeatGroup;

- (void)noMoveUpTextField:(BOOL)isAppear;

@end
@interface EditTextCell : UITableViewCell
@property(nonatomic, assign)id<EditTextCellDelegate>delegate;
/**
 标题
 */
@property(nonatomic, copy)NSString *title;

/**
 标题内容
 */
@property(nonatomic, copy)NSString *titleContent;

/**
 右侧文字
 */
@property(nonatomic, copy)NSString *rightText;

/**
 是否选择开始时间
 */
@property(nonatomic, assign) BOOL signStartTimeSelect;

@property(nonatomic, assign) BOOL isRepeat;
- (void)recoveryKeyboard;
@end
